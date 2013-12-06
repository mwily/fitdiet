# -*- coding: utf-8 -*- 

from common import db

def selcttest(app):
	database = db.DB(app)
	datas = database._selectOp('*','rootaddress','ID=1')[0]
	return str(datas['name'])
	# return database._selectOp('*','rootaddress')
	# database = db.DB(app)
	# return database._test()
	# return str(database._updateOne('rootaddress',('name','testtest'),'ID=1'))