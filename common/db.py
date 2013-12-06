# -*- coding: utf-8 -*- 
import MySQLdb
import codecs
import json
import random
import io
import datetime
from types import *

from flask import jsonify

from settings import DATACONNECT

import sys
reload(sys)
sys.setdefaultencoding("utf-8")

class DB():
	def __init__(self):
		self.host = DATACONNECT['HOST']
		self.database = DATACONNECT['DATABASE']
		self.user = DATACONNECT['USER']
		self.pwd = DATACONNECT['PASSWORD']
		self.conn = MySQLdb.connect(host=self.host,user=self.user,passwd=self.pwd,db=self.database,charset="utf8")
		self.cursor = self.conn.cursor()
		self.cursor.execute('set names utf8')

	def _test(self):
		return self.conn

	def datetostr(date):
		return str(date)[0:22]

	#input:fildname,tablename,condition
	#output:like [{},{}] the result of the option
	def _selectOp(self,filedname,tablename,condition=""):
		result = []
		if condition == "":
			sql = "SELECT %s FROM %s" %(filedname,tablename)
			self.cursor.execute(sql)
			result = [dict((self.cursor.description[idx][0], value) for idx, value in enumerate(row)) for row in self.cursor.fetchall()]
			return result
		else:
			sql = "SELECT %s FROM %s WHERE %s" %(filedname,tablename,condition)
			self.cursor.execute(sql)
			result = [dict((self.cursor.description[idx][0], value) for idx, value in enumerate(row)) for row in self.cursor.fetchall()]
			return result

	#key_value like [('name','value'),...] is a truple list
	#condition like 'id = 1' is string
	#selfplus means this update will use the old data plus the new data
	def _updateOne(self,tablename,key_value,condition="",selfplus = False):
		try:
			if condition == "":
				return 0
			else:
				sql = 'UPDATE `%s` SET' %tablename
				if not selfplus:
					for item in key_value:
						sql = sql + " %s='%s'," %(item[0],item[1])
				else:
					for item in key_value:
						sql = sql + " %s= %s + %d," %(item[0],item[0],int(item[1]))
				sql = sql[:-1]
				sql = sql + ' WHERE %s' %condition
				# print 'sqlupdate:',sql
				n = self.cursor.execute(sql)
				self.conn.commit()
				return n
		except:
			self.conn.rollback()
			return -1

	def _deleteOp(self,tablename,key):
		try:
			if key:
				sql = "DELETE FROM `%s` WHERE ID in %s" %(tablename,key)
				n = self.cursor.execute(sql)
				self.conn.commit()
				return n
				# return sql
			else:
				return -1
		except:
			self.conn.rollback()
			return -1

	#return the last ID you insert
	#idenabel is a bool ,means if return the ID you just insert
	#index means which colums is key for serche 
	def _insertOp(self,tablename,valuelist,idenabel=False , index=0):
		filed_name = ""
		sqltable = "SELECT * FROM `%s` WHERE 1=0" %tablename
		n = self.cursor.execute(sqltable)
		for i in self.cursor.description:
			if str(i[0]) != 'ID':
				filed_name = filed_name + str(i[0]) +","

		values = ""
		for item in valuelist:
			if item == None:
				values = values + "Null,"
			else: 
				values = values + "'"+ str(item) +"',"

		if filed_name:
			sql = u"INSERT INTO `%s` (%s)VALUES (%s)" %(tablename,filed_name[:-1:1],values[:-1:1])
			if sql:
				try:
					n = self.cursor.execute(sql)
					self.conn.commit()
					if idenabel:
						colname = filed_name[:-1].split(',')[index]
						colvalue = values[:-1].split(',')[index]
						sqlser = u"SELECT `ID` FROM `%s` WHERE `%s` = %s" %(tablename,str(colname),str(colvalue))
						idresult = self.cursor.execute(sqlser)
						idreturn = self.cursor.fetchall()
						return idreturn[-1][0]
					return n
				except:
					self.conn.rollback()
					return 0
		return 0

	def insert_delete(conn,cursor,tableold,tablenew,key):
		filed_name = ""
		fileds = []
		error = ""
		if key:
			sql = "SELECT * FROM %s" %(tableold)
			n=cursor.execute(sql)
			result = []		
			for i in cursor.description:
				if str(i[0]) != 'id':
					filed_name = filed_name + str(i[0]) +","
					fileds.append(str(i[0]))
			
			filed_name = filed_name +'deletetime'

			resultserach = selectOp(cursor,"*",tableold,"id in %s" %key)

			for result in resultserach:
				valuelist = ""
				ids = result.get('id')
				for item in fileds:
					if type(result.get(item)) is datetime.datetime:
						valuelist= valuelist + "'" + datetostr(result.get(item)) +"',"
					elif result.get(item) is None:
						valuelist= valuelist + "'Null',"
					else:
						valuelist= valuelist + "'" + result.get(item) +"',"

				valuelist= valuelist + "'" + datetostr(datetime.datetime.now()) + "'"
				sqlinsert = "INSERT INTO `%s` (%s)VALUES (%s) " %(tablenew,filed_name,valuelist)

				try:
					m = cursor.execute(sqlinsert)
					conn.commit()

					if m:
						sqldel = "DELETE FROM %s WHERE id = '%s'" %(tableold,ids)
						try:
							cursor.execute(sqldel)
							conn.commit()
						except:
							conn.rollback()
							continue
					else:
						return error
				except:
					conn.rollback()
					continue
		return "OK"
			# return str(resultserach)