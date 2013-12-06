#-*- coding: UTF-8 -*-
import urllib,urllib2 
from xml.etree import ElementTree
from flask import jsonify
import random
import datetime
import hashlib

from common import db

dbinfo = db.DB()

#Say Hello with you
def say_hello():
    return "Welcome to Fit_Diet on Android!"

def passwordLogin(userName,password):
    if userName:
        tableName = 'customer'
        hashmd5 = hashlib.md5(password)
        password = hashmd5.hexdigest()
        condition = u'userName="%s" AND password="%s"' %(userName,password)
        result = dbinfo._selectOp('*',tableName,condition)
        if result:
            return True
        else:
            return -1
    else:
        return -1

def passwordChange(userName,psded,psd):
    if userName:
        hashmd5 = hashlib.md5(psd)
        password = hashmd5.hexdigest()
        hashmd5 =hashlib.md5(psded)
        passworded = hashmd5.hexdigest()
        tableName = 'customer'
        condition = 'userName="%s" AND password="%s"' %(userName,passworded)
        result = dbinfo._selectOp('*',tableName,condition)
        if len(result) == 1:
            key_values = [('password',password)]
            dbinfo._updateOne(tableName,key_values,condition)
            return True
        else:
            return False
    else:
        return False

def registUser(name,password):
    if name:
        hashmd5 = hashlib.md5(password)
        password = hashmd5.hexdigest()
        tableName = 'customer'
        condition = 'userName="%s"' %name
        result = dbinfo._selectOp('*',tableName,condition)
        if result:
            return -1
        else:
            print name
            valueList = ['','','',None,name,password,'',1,1,1,1,1,1,1,1,'11111111']
            userID = dbinfo._insertOp(tableName,valueList,True)
            if userID:
                return userID
            else:
                return -1
    else:
        return -1