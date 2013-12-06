#-*- coding: UTF-8 -*-

from flask import Flask,jsonify,request,session,abort
import random
import simplejson as json
from control import functions
from control import fit_diet

app = Flask(__name__)

#加载基本配置
app.config.from_pyfile('settings.py', silent=True)
app.secret_key = app.config['SECRETLEY']

@app.route('/')
def hello():
    return functions.say_hello()

@app.route('/test',methods=['POST'])
def Test():
    a = json.loads(request.form['a'])['state']
    return jsonify(haha = a)

@app.route('/regist',methods=['POST'])
def registUser():
    try:
        name = request.form['name']
        password = request.form['password']
        result = functions.registUser(name,password)
        if result != -1:
            return jsonify(state = 1,error = "OK", userID = result)
        else:
            return jsonify(state = -1,error = "此用户名已注册，请换个用户名")
    except KeyError:
        abort(400)

@app.route('/login',methods=['POST'])
def passwordLogin():
    try:
        userName = request.form['userName']
        password = request.form['password']
        result = functions.passwordLogin(userName,password)
        if result != -1:
            return jsonify(state = 1,error = 'OK')
        else:
            return jsonify(state = -1,error = '您的密码错误或者帐号还没有激活，请重新注册')
    except KeyError:
        abort(400)
    
@app.route('/pwdchange',methods=['POST'])
def passwordChange():
    try:
        userName = request.form['userName']
        psded = request.form['psded']
        psd = request.form['psd']
        result = functions.passwordChange(userName,psded,psd)
        if result:
            return jsonify(state = 1,error = 'OK')
        else:
            return jsonify(state = -1,error = 'Error')
    except KeyError:
        raise e

#获取“一键做菜”的列表:
@app.route('/cookdishlist',methods=['POST'])
def cookDishList():
    try:
        userID = request.form['userID']
        result = fit_diet.cookDishList(userID)
        if result!=-1:
            return jsonify(state = 1,error = "OK",dishList = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取“我的最爱”的列表:
@app.route('/myfavoritelist',methods=['POST'])
def myFavoriteList():
    try:
        userID = request.form['userID']
        result = fit_diet.myFavoriteList(userID)
        if result!=-1:
            return jsonify(state = 1,error = "OK",favoriteList = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取“烹饪日记”的列表:
@app.route('/cookdiarylist',methods=['POST'])
def cookDiaryList():
    try:
        userID = request.form['userID']
        result = fit_diet.cookDiaryList(userID)
        if result!=-1:
            return jsonify(state = 1,error = "OK",diaryList = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取“我的菜篮”的列表:
@app.route('/mybasketlist',methods=['POST'])
def myBasketList():
    try:
        userID = request.form['userID']
        result = fit_diet.myBasketList(userID)
        if result!=-1:
            return jsonify(state = 1,error = "OK",basketList = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

@app.route('/getfooddetail',methods=['POST'])
def getFoodDetail():
    try:
        foodID = request.form['foodID']
        result = fit_diet.getFoodDetail(foodID)
        if result != -1:
            return jsonify(state = 1,error = "OK",foodDetail = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

@app.route('/getuserinfo',methods=['POST'])
def getUserInfo():
    try:
        userID = request.form['userID']
        result = fit_diet.getUserInfo(userID)
        if result!= -1:
            return jsonify(state = 1,error = 'OK',userInfo = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

@app.route('/setuserinfo',methods=['POST'])
def setUserInfo():
    try:
        userID = request.form['userID']
        userName = request.form['userName']
        sex = request.form['sex']
        birthday = request.form['birthday']
        workCategory = request.form['workCategory']
        healthStr = request.form['healthStr']
        result = fit_diet.setUserInfo(userID,userName,sex,birthday,workCategory,healthStr)
        if result != -1:
            return jsonify(state = 1,error = "OK")
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取某用户 本月“某大类的五周含量“
@app.route('/monthnutrition',methods=['POST'])
def monthNutrition():
    try:
        className = request.form['className']
        userID  = request.form['userID']
        month = request.form['month']
        result = fit_diet.monthNutrition(userID,className,month)
        if result != -1:
            return jsonify(state = 1, error = 'OK', monthNutrition = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取某用户 本周“某大类的含量“
@app.route('/weeknutrition',methods=['POST'])
def weekNutrition():
    try:
        className = request.form['className']
        userID  = request.form['userID']
        week = request.form['week']
        result = fit_diet.weekNutrition(userID,className,week)
        if result != -1:
            return jsonify(state = 1, error = 'OK', weekNutrition = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取某用户 今日各类营养元素的含量“
@app.route('/todaynutrition',methods=['POST'])
def todayNutrition():
    try:
        userID  = request.form['userID']
        day = request.form['day']
        result = fit_diet.todayNutrition(userID,day)
        if result != -1:
            return jsonify(state = 1, error = 'OK', todayNutrition = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

#获取某用户 今日各大类的含量“
@app.route('/classnutrition',methods=['POST'])
def classNutrition():
    try:
        userID  = request.form['userID']
        day = request.form['day']
        result = fit_diet.classNutrition(userID,day)
        if result != -1:
            return jsonify(state = 1, error = 'OK', classNutrition = result)
        else:
            return jsonify(state = -1,error = 'There is something Wrong!')
    except KeyError:
        abort(400)

@app.route('/getsteps',methods = ['POST'])
def getSteps():
    try:
        foodID = request.form['foodID']
        result = fit_diet.getSteps(foodID)
        if result != -1:
            return jsonify(state = 1,error = 'OK',steps = result)
        else:
            return jsonify(state = -1,error = 'Error')
    except KeyError:
        abort(400)

@app.route('/getfoodpic',methods= ['POST'])
def getFoodPic():
    try:
        foodName = request.form['foodName']
        result = fit_diet.getFoodPic(foodName)
        if result != -1:
            return jsonify(state = 1,error = 'OK', foodUrl = result)
        else:
            return jsonify(state = -1,error= 'Error')
    except KeyError:
        abort(400)

@app.route('/addshoppingcart',methods=['POST'])
def addShoppingCart():
    try:
        foodID = request.form['foodID']
        userID = request.form['userID']
        # number = request.form['number']
        result = fit_diet.addShoppingCart(userID,foodID)
        if result != -1:
            return jsonify(state = 1,error = 'OK')
        else:
            return jsonify(state = -1,error = 'Error')
    except KeyError:
        abort(400)

@app.route('/getshoppingcart',methods=['POST'])
def getShoppingCart():
    try:
        userID = request.form['userID']
        result = fit_diet.myBasketList(userID)
        #result = fit_diet.getShoppingCart(userID)
        if result != -1:
            return jsonify(state = 1,error = 'OK',shoppingList = result)
        else:
            return jsonify(state = -1,error = 'Error')
    except KeyError:
        abort(400)

@app.route('/addmylove',methods=['POST'])
def addMyLove():
    try:
        foodID = request.form['foodID']
        userID = request.form['userID']
        result = fit_diet.addMyLove(userID,foodID)
        if result != -1:
            return jsonify(state = 1,error = 'OK')
        else:
            return jsonify(state = -1,error = 'Error')
    except KeyError:
        abort(400)

@app.route('/getnormalrecommend',methods =['POST'])
def getNormalRecommend():
    try:
        result = fit_diet.getNormalRecommend()
        if result != -1:
            return jsonify(state = 1,error = 'OK',recommendList = result)
        else:
            return jsonify(state = -1,error = 'Error') 
    except KeyError:
        abort(400)

@app.route('/getmyrecommend',methods =['POST'])
def getMyRecommend():
    try:
        userID = request.form['userID']
        result = fit_diet.getMyRecommend(userID)
        if result != -1:
            return jsonify(state = 1,error = 'OK',recommendList = result)
        else:
            return jsonify(state = -1,error = 'Error') 
    except KeyError:
        abort(400)

@app.route('/search',methods = ['POST'])
def searchFood():
    try:
        keyWord = request.form['keyWord']
        result = fit_diet.searchFood(keyWord)
        if result != -1:
            return jsonify(state = 1,error = 'OK',foodList = result)
        else:
            return jsonify(state = -1,error = 'Error')
    except KeyError:
        abort(400)

@app.route('/matchrecommend',methods =['POST'])
def matchRecommed():
    try:
        userID = request.form['userID']
        result = fit_diet.matchRecommed(userID)
        if result != -1:
            return jsonify(state = 1,error = 'OK',recommendList = result)
    except KeyError:
        abort(400)

if __name__ == '__main__':
    app.debug = True
    app.run("0.0.0.0",5555)
