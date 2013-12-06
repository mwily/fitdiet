 #-*- coding: UTF-8 -*-
import os

#this is the config information about database connection
DATACONNECT = {
	'HOST':'127.0.0.1',
	'DATABASE':'Fit_Diet',
	'USER':'root',
	'PASSWORD':'phone123456',
	'PORT':'3306'
}
SECRETLEY = os.urandom(24)

#图片根目录
IMAGEADR = 'http://ec22.birdbird.net/static/img/'
