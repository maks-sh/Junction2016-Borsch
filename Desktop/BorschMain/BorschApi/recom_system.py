#-*- coding:utf-8 - *-

from .apriory import *
#import pandas as pd
import math

# constants
ordersNum = 5;
categoryNum = 1;
similarNum = 7;
alikeNum = 2;
period = 1;		# month

# функция сравнения объектов - используется в top5Dishes
def comparisonFunction (x,y):
		return (x[1]>y[1])
'''
"Топ5 блюд сегодня" - работаем с данными по конкретному ресторану. Ранжируем блюда по количеству их заказов за period- на выходе 
 отсортированный список блюд данного ресторана. Берем первые топ5 блюд из РАЗНЫХ категорий 
 (пояснение: если в полученном списке первое и второе блюда относятся к одной категории, то советуем только первое).
 Режим расчета: ежедневно, в заранее заданное и согласованное(?) с рестораном время.
 @param dishDict - кортеж блюд данного ресторана. В кортеже обязательно должны быть: на второй позиции - количество заказов за месяц, на третьей - категория
 @return result - топ 5 блюд по количеству заказов из разных категорий
'''

#получаю словарь
def top5Dishes (dishList) :
	#dostaem iz bd po id restorana nuzhnie dannie - bluda za mesjaz iz dannogo restorana c ih kolichestvom
	result = []
	a = []
	flag = False
	dishList.sort(key=lambda i: i[1], reverse = True)
	for dish in dishList:
		if dish[2] in a:
			flag = True
			continue
		a.append(dish[2])
		result.append(dish)
		if (len(result)==5):
			break
	#dishList.sort(comparisonFunction)
	#sortedDishDict = sorted(dishList.items(), key=lambda item: item[1])
	return result


'''
"Топ 5 блюд именно для тебя!":
-достаем из БД заказанные этим человеком блюда за последние ordersNum заказов (по всей сети)
-находим схожие* блюда в данном ресторане
-ранжируем их по количеству заказов за period и выдаем топ5, но не более categoryNum на категорию.
@param orderedEarlierDishList - набор блюд, которые пользователь где-либо заказывал ранее
@param currentRestaurantAllDishList - набор блюд данного ресторана
@return top5Dishes(similarDishes) - топ 5 блюд по количеству заказов из разных категорий
'''
#
def top5DishesForCurrentUser (orderedEarlierDishList, currentRestaurantAllDishList) :
	#обрабатываем только 10 последних блюд (TODO: не реализован отбор по ДАТЕ!!!)
	orderedEarlierDishListTopN = orderedEarlierDishList[0:ordersNum]
	similarDishes = findNSimilarDishes(orderedEarlierDishListTopN,currentRestaurantAllDishList)

	return top5Dishes(similarDishes)
	
# "Топ 5 блюд к конкретному":
# -ищем similarNum схожих* c уже заказанным блюдом по всей сети
# -алгоритмом Априори** определяем alikeNum блюд, которые заказывают совместно с каждым из схожих
# -определяем схожие* с найденными на предыдущем шаге блюда в КОНКРЕТНОМ ресторане
# -ранжируем по количеству заказов за period, выводим для рекомендации топ5
# @param dish - уже заказанное блюдо
# @param allDishes - все блюда в системе
# @param currentRestaurantAllDishes - блюдо в конкретном ресторане
# @return top5Dishes(resultDishes)

def top5DishesWithOrderedOne (dish, allDishes,currentRestaurantAllDishes) :
	#Ближайшие по всей сети:
	similarDishes = find5SimilarDishesToOne(dish,allDishes)
	#Априори
	AprioriDishes = aprioryCall(similarDishes)
	resultDishes = findNSimilarDishes(AprioriDishes,currentRestaurantAllDishes)

	return top5Dishes(resultDishes)


# Алгоритм определения схожести - работает с таблицей (строки - блюда, столбцы - ингридиенты, значения - долевой вклад ингридиента 
# в блюдо(вычисляется по массе)), на входе имеет spisok blu`d и список других блюд, с которыми сравнивать (при нуле - со всей таблицей).
# На выходе - similarNum схожих блюд - либо топ по результату выборки, либо выше порогового значения.
# Анализ - сумма(или иной способ агрегации) мер расстояний по каждому ингридиенту.
# @param dishListToCompare - список, ИЗ которого сравнивать
# @param dishListToCompareWith - список С которым сравнивать (из которого будем возвращать результаты)
# @return resultList[0:ordersNum] - ordersNum топовых блюд 
def findNSimilarDishes (dishListToCompare,dishListToCompareWith) :
	resultList = []
	for dish1 in dishListToCompare:
		resultList.extend(find5SimilarDishesToOne(dish1,dishListToCompareWith))
	return resultList[0:ordersNum]



# Возвращает N ближайших к dish блюда из dishListToCompare
# @param dish - блюдо для сравнения
# @param dishListToCompare - лист блюд, с которым сравнивать
# @return dishListToCompare[0:ordersNum] - orderNum ближайших блюд
def find5SimilarDishesToOne (dish,dishListToCompare) :
	for dish2 in dishListToCompare:
		dish2.append(similarityDetermination(dish,dish2))
	dishListToCompare.sort(key=lambda i: i[-1], reverse = True)
	for dish in dishListToCompare:
		del dish[-1]
	return dishListToCompare[0:ordersNum]

#загуглить реализацию :) есть в книжке 100%, но Макс говорит надо бы погуглить
#def AprioriAlgorythm () :
# Возвращает наиболее часто встречающиеся блюда (15 штук)
def aprioryCall(dataSet) :
	dataset = apriori.load_dataset()
	print(dataset), "-----"
	C1= apriori.createC1(dataset)
	D = map(set, dataset)
	L1, support_data = apriori.scanD(D, C1, 0.5)
	print (L1)
	apriori.aprioriGen(L1, 0)
	L = apriori.apriori(dataset)
	L, support_data = apriori.apriori(dataset, minsupport = 0.5)
	print ("------", L)
	return L



#новые функции

# Определяет схожесть двух блюд
# @param dish1 - первое блюдо
# @param dish2 - второе блюдо
# @return similarity - схожесть
def similarityDetermination(dish1, dish2) :
	similarity = 0
	count = 0
	for ingredient1 in dish1[3]:
		for ingredient2 in dish2[3]:
			if (ingredient1==ingredient2):
				similarity += devision(dish1[3][ingredient1],dish2[3][ingredient2])
				count += 1
	return similarity


# Делит меньшее на большее
# @param one - первое число
# @param two - второе число
# @return result - результат деления
def devision(one,two):
	res = one/two
	return res if res < 1 else 1/res


dishList = [['borsch','1','russian',{"romaine lettuce":0.5,"black olives":0.5}],['makaroshki','3','french',{"grape tomatoes":0.7,"garlic":0.3}],
['schi','2','russian',{"pepper":0.8,"purple onion":0.2}],['pasta','1','spanish',{"seasoning":0.3,"garbanzo beans":0.3,"feta cheese crumbles":0.4}],
['pivo','3','german',{"pepper":0.2,"purple onion":0.8}],['hotdog','2','american',{"romaine lettuce":0.5,"garbanzo beans":0.4}]]
dishList2 = [['borsch','1','russian',{"romaine lettuce":0.5,"black olives":0.5}]]
dishList3 = [['pivo','3','german',{"pepper":0.2,"purple onion":0.8}],['hotdog','2','american',{"romaine lettuce":0.5,"garbanzo beans":0.4}]]
a = top5Dishes(dishList)
b = top5DishesForCurrentUser(dishList3,dishList3)
# print(a)
print(b)