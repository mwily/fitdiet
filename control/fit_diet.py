#-*- coding: UTF-8 -*-
from flask import jsonify
import random
import datetime
from common import db
from control import functions
from settings import IMAGEADR

dbinfo = db.DB()

def cookDishList(userID):
    if userID:
        tableName = 'finishorder'
        condition = 'userID="%s" AND ifCooking = 0 AND ifFinish = 1' %userID
        valueList = '*'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            for item in result:
                item['foodName'] = ''
                item['pictureUrl'] = ''
                item['foodTime'] = ''
                tableName = 'food'
                condition = 'ID="%s"' %item['foodID']
                valueList = 'name,pictureUrl,time'
                foodInfo = dbinfo._selectOp(valueList,tableName,condition)
                if foodInfo:
                    item['foodName'] = foodInfo[0]['name']
                    item['pictureUrl'] = IMAGEADR + str(foodInfo[0]['pictureUrl'])
                    item['foodTime'] = foodInfo[0]['time']
        if result != -1:
            return result
        else:
            return -1
    else:
        return -1

def myFavoriteList(userID):
    if userID:
        tableName = 'favorite'
        condition = 'userID="%s"' %userID
        valueList = '*'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            for item in result:
                item['foodName'] = ''
                item['pictureUrl'] = ''
                item['boughtTimes'] = 0
                tableName = 'food'
                condition = 'ID="%s"' %item['foodID']
                valueList = 'name,pictureUrl,times'
                foodInfo = dbinfo._selectOp(valueList,tableName,condition)
                if foodInfo:
                    item['foodName'] = foodInfo[0]['name']
                    item['pictureUrl'] = IMAGEADR + str(foodInfo[0]['pictureUrl'])
                    item['boughtTimes'] = foodInfo[0]['times']
            return result 
        else:
            return -1
    else:
        return -1

def cookDiaryList(userID):
    if userID:
        #return userID
        tableName = 'historyorder'
        condition = 'userID="%s"' %userID
        valueList = '*'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            for item in result:
                item['foodName'] = ''
                item['pictureUrl'] = ''
                item['cookTime'] = str(item['finishTime'])
                del item['finishTime']
                tableName = 'food'
                condition = 'ID="%s"' %item['foodID']
                valueList = 'name,pictureUrl'
                foodInfo = dbinfo._selectOp(valueList,tableName,condition)
                if foodInfo:
                    item['foodName'] = foodInfo[0]['name']
                    item['pictureUrl'] = IMAGEADR + str(foodInfo[0]['pictureUrl'])
        if result != -1:
            return result
        else:
            return -1
    else:
        return -1

def myBasketList(userID):
    if userID:
        tableName = 'initialorder'
        condition = 'userID="%s"' %userID
        valueList = '*'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            for item in result:
                item['foodName'] = ''
                item['pictureUrl'] = ''
                item['foodPrice'] = 0.0
                tableName = 'food'
                condition = 'ID="%s"' %item['foodID']
                valueList = 'name,pictureUrl,price'
                foodInfo = dbinfo._selectOp(valueList,tableName,condition)
                if foodInfo:
                    item['foodName'] = foodInfo[0]['name']
                    item['pictureUrl'] = IMAGEADR + str(foodInfo[0]['pictureUrl'])
                    item['foodPrice'] = foodInfo[0]['price']
        if result != -1:
            return result
        else:
            return -1
    else:
        return -1

def getFoodDetail(foodID):
    if foodID:
        tableName = 'food'
        condition = 'ID="%s"' %foodID
        valueList = '*'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result!=-1:
            return result[0]
        else:
            result -1
    else:
        return -1

def getUserInfo(userID):
    if userID:
        tableName = 'customer'
        condition = 'ID="%s"' %userID
        valueList = 'userName,sex,birthday,workCategory,healthStr'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            for item in result:
                item['birthday'] = str(item['birthday'])
            return result[0]
        else:
            return -1
    else:
        return -1

def setUserInfo(userID,userName,sex,birthday,workCategory,healthStr):
    if userID:
        tableName = 'customer'
        condition = 'ID="%s"' %userID
        healthType = ['isHealth','isFat','isHypertension','isHyperlipidemia','isCardiopathy','isGlycuresis','isAnemia']
        key_values = [('userName',userName),('sex',sex),('birthday',birthday),('workCategory',workCategory),('healthStr',healthStr)]
        for i in range(len(healthStr)):
            key_values.append((healthType[i],healthStr[i]))
        result = dbinfo._updateOne(tableName,key_values,condition)
        if result != -1:
            return True
        else:
            return -1
    else:
        return -1

def monthNutrition(userID,className,month):
    if userID:
        result = {
            'weekNutritionList' : [
                {
                    'name' : 'month1',
                    'value' : 300
                },
                {
                    'name' : 'month2',
                    'value' : 400
                },
                {
                    'name' : 'month3',
                    'value' : 269     
                },
                {
                    'name' : 'month4',
                    'value' : 386           
                },
                {
                    'name' : 'month5',
                    'value' : 546 
                }
            ],
            'shouldEat' : 1000,
            'haveEat' :  869+386+546
        }
        tableName = 'category'
        condition = 'englishName="%s"' %className
        valueList = 'monthShouldEat,weekShouldEat'
        eatOne = dbinfo._selectOp(valueList,tableName,condition)
        if eatOne:
            result['shouldEat'] = eatOne[0]['monthShouldEat']
            eatSum = 0
            for item in result['weekNutritionList']:
                item['value'] = random.randint(int(eatOne[0]['weekShouldEat'] / 3), eatOne[0]['weekShouldEat'] + 200)
                eatSum += item['value']
            result['haveEat'] = eatSum
            return result
        else:
            return -1
    else:
        return -1

def weekNutrition(userID,className,week):
    if userID:
        result = {
            'weekNutritionList' : [
                {
                    'name' : 'day1',
                    'value' : 180
                },
                {
                    'name' : 'day2',
                    'value' : 120
                },
                {
                    'name' : 'day3',
                    'value' : 125     
                },
                {
                    'name' : 'day4',
                    'value' : 50           
                },
                {
                    'name' : 'day5',
                    'value' : 68 
                },
                {
                    'name' : 'day6',
                    'value' : 68 
                },
                {
                    'name' : 'day7',
                    'value' : 68 
                }
            ],
            'shouldEat' : 30,
            'haveEat' : 28
        }
        tableName = 'category'
        condition = 'englishName="%s"' %className
        valueList = 'weekShouldEat'
        eatOne = dbinfo._selectOp(valueList,tableName,condition)
        if eatOne:
            result['shouldEat'] = eatOne[0]['weekShouldEat']
            eatSum = 0
            for item in result['weekNutritionList']:
                item['value'] = random.randint(int(eatOne[0]['weekShouldEat'] / 14), int(eatOne[0]['weekShouldEat'] / 7) + 200)
                eatSum += item['value']
            result['haveEat'] = eatSum
            return result
        else:
            return -1
    else:
        return -1

def todayNutrition(userID,day):
    if userID:
        result = [
            {
                'name' : 'calory',
                'value' : 180
            },
            {
                'name' : 'carbohydrate',
                'value' : 120
            },
            {
                'name' : 'fat',
                'value' : 125     
            },
            {
                'name' : 'protein',
                'value' : 50           
            },
            {
                'name' : 'na',
                'value' : 68 
            },
            {
                'name' : 'vitaminA',
                'value' : 5
            },
            {
                'name' : 'vitaminC',
                'value' : 153
            },
            {
                'name' : 'ca',
                'value' : 70
            },
            {
                'name' : 'fe',
                'value' : 90
            }
            
        ]
        return result
    else:
        return -1

def classNutrition(userID,day):
    if userID:
        result = [
            {
                'name' : 'vegetable',
                'value' : 1           
            },
            {
                'name' : 'diary_products',
                'value' : 1 
            },
            {
                'name' : 'beans',
                'value' : 1
            },
            {
                'name' : 'fish',
                'value' : 1
            },
            {
                'name' : 'egg',
                'value' : 1
            },
            {
                'name' : 'meat',
                'value' : 1
            }
        ]
        return result
    else:
        return -1

def getSteps(foodID):
    if foodID:
        tableName = 'food'
        valueList = 'stepToMircrowave'
        condition = 'ID="%s"' %foodID
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            return result[0]['stepToMircrowave']
        else:
            return -1
    else:
        return -1

def getFoodPic(foodName):
    if foodName:
        tableName = 'food'
        valueList = 'pictureUrl'
        condition = 'name="%s"' %foodName
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            return IMAGEADR + result[0]['pictureUrl']
        else:
            return -1
    else:
        return -1

def addShoppingCart(userID,foodID):
    if userID:
        tableName = 'initialorder'
        valueList = 'ID'
        condition = 'userID="%s" AND foodID="%s"' %(userID,foodID)
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            key_values = [('foodNum',1)]
            condition = 'ID="%s"' %result[0]['ID']
            result1 = dbinfo._updateOne(tableName,key_values,condition,True)
            if result1:
                return True
            else:
                return -1
        else:
            valueList = [userID,foodID,1]
            result1 = dbinfo._insertOp(tableName,valueList)
            if result1:
                return True
            else:
                return -1
    else:
        return -1

def getShoppingCart(userID):
    if userID:
        tableName = 'initialorder,food'
        condition = 'userID="%s" AND foodID=food.ID' %userID
        valueList = 'foodID,name foodName,price foodPrice,foodNum foodCount'
        result = dbinfo._selectOp(valueList,tableName,condition)
        for item in result:
            item['sumPrice'] = float(item['foodPrice']) * int(item['foodCount'])
        if result != -1:
            return result
        else:
            return -1
    else:
        return -1

def addMyLove(userID,foodID):
    if userID:
        tableName = 'favorite'
        valueList = '*'
        condition = 'userID="%s" AND foodID="%s"' %(userID,foodID)
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result:
            return True
        else:
            valueList = [userID,foodID]
            result = dbinfo._insertOp(tableName,valueList)
            if result != -1:
                return True
            else:
                return -1
    else:
        return -1

def getNormalRecommend():
    tableName = 'food'
    condition = '1=1'
    valueList = 'ID foodID,pictureUrl,name foodName'
    result = dbinfo._selectOp(valueList,tableName,condition)
    if result != -1:
        for item in result:
            item['pictureUrl'] = IMAGEADR + str(item['pictureUrl'])
        return result
    else:
        return -1

def getMyRecommend(userID):
    if userID:
        tableName = 'food'
        condition = '1=1'
        valueList = 'ID foodID,pictureUrl,name foodName'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result != -1:
            for item in result:
                item['pictureUrl'] = IMAGEADR + str(item['pictureUrl'])
            return result
        else:
            return -1
    else:
        result -1

def searchFood(keyWord):
    if keyWord:
        tableName = 'food'
        condition = '`name` LIKE "%%%s%%"' %keyWord
        #print condition
        valueList = 'ID foodID,pictureUrl,name foodName,time cookTime'
        result = dbinfo._selectOp(valueList,tableName,condition)
        if result != -1:
            for item in result:
                item['pictureUrl'] = IMAGEADR + str(item['pictureUrl'])
            return result
        else:
            return -1
    else:
        return -1
def matchRecommed(userID):
    if userID:
        fruitList = []
        fucaiList = []
        dessertList = []
        tableName = 'fruit'
        valueList = 'ID foodID,name foodName,pictureUrl'
        fruitList = dbinfo._selectOp(valueList,tableName)
        for item in fruitList:
            item['pictureUrl'] = IMAGEADR + str(item['pictureUrl'])
        tableName = 'dessert'
        valueList = 'ID foodID,name foodName,pictureUrl'
        dessertList = dbinfo._selectOp(valueList,tableName)
        for item in dessertList:
            item['pictureUrl'] = IMAGEADR + str(item['pictureUrl'])
        tableName = 'food'
        valueList = 'ID foodID,name foodName,pictureUrl'
        fucaiList = dbinfo._selectOp(valueList,tableName)
        for item in fucaiList:
            item['pictureUrl'] = IMAGEADR + str(item['pictureUrl'])
        return {
            'fruitList' : fruitList,
            'fucaiList' : fucaiList,
            'dessertList' : dessertList 
        }
    else:
        return -1
