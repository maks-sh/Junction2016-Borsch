from django.views.decorators.csrf import csrf_exempt
from rest_framework import generics, permissions
from django.utils.decorators import method_decorator
from .serializers import UserSerializer, DishSerializer, RestaurantSerializer, FeedbackSerializer, DishOrderRsSerializer
from .serializers import OrderSerializer, RestaurantListSerializer, TimeBookingSerializer, BookingSerializer
from .models import User, Restaurant, PhotoRestaurant, Feedback, Dish, Order, OrderDishes, Booking, TimeBooking, Ingridient,IngridientsDishes
from rest_framework import status
from rest_framework.response import Response
from django.shortcuts import render, render_to_response
from django.contrib.auth import login, authenticate, logout
from rest_framework.parsers import MultiPartParser
import json
import datetime
from decimal import Decimal
import math
import random

class UserList(generics.ListAPIView):
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]
    queryset = User.objects.all()

class UserAuth(generics.ListAPIView):
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]
    queryset = User.objects.all()

    def get_queryset(self):
        return self.queryset.filter(id=self.request.user.id)

class RegisterView(generics.CreateAPIView):
    permission_classes = [permissions.AllowAny]
    serializer_class = UserSerializer

    @method_decorator(csrf_exempt)
    def post(self, request, *args, **kwargs):
        serialized = UserSerializer(data=request.data)
        dict_arg={}
        if(request.data['is_admin_restaurant'] == "True" or request.data['is_waiter'] == "True"):
            dict_arg['last_name'] = serialized.initial_data['last_name']
            dict_arg['restaurant_name'] = serialized.initial_data['restaurant_name']
        dict_arg['is_admin_restaurant'] = serialized.initial_data['is_admin_restaurant']
        dict_arg['is_waiter'] = serialized.initial_data['is_waiter']
        if serialized.is_valid():
            User.objects.create_user(
                    serialized.initial_data['phone_number'],
                    serialized.initial_data['email'],
                    serialized.initial_data['first_name'],
                    serialized.initial_data['password'],
                    **dict_arg
                    )
            a = User.objects.last()
            a.restaurant = Restaurant.objects.get(id=332)
            a.save()
            return Response({'d':323},status=200)
        else:
            return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)


class LoginView(generics.CreateAPIView):

    def post(self, request, *args, **kwargs):
        username = request.POST['phone_number']
        password = request.POST['password']
        user = authenticate(username=username, password=password)

        if user is not None:
            if user.is_active:
                login(request, user)
                return Response(UserSerializer(user).data, status=200)
            else:
                return Response(status=401)
        else:
            return Response(status=401)

class LogoutView(generics.DestroyAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def delete(self, request, *args, **kwargs):
            logout(request)
            return Response(status=200)

class AddRestaurantView(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = RestaurantSerializer
    parser_classes = (MultiPartParser, )

    def post(self, request, *args, **kwargs):
        if 'name' not in request.POST.keys() or request.POST['name'] == "":
            return Response({'error': 'Name is empty!'}, status=400)
        if 'coords' not in request.POST.keys() or request.POST['coords'] == "":
            return Response({'error': 'Coords is empty!'}, status=400)
        if 'regime' not in request.POST.keys() or request.POST['regime'] == "":
            return Response({'error': 'Regime is empty!'}, status=400)
        if 'description' in request.POST.keys():
            description = request.POST['description']
        else:
            description = ""

        name = request.POST['name']
        coords = request.POST['coords']
        regime = request.POST['regime']

        restaurant = Restaurant(name=name, coords=coords, regime=regime, description=description)
        restaurant.save()

        user = User.objects.get(id=request.user.id)
        user.restaurant = restaurant
        user.restaurant_name = name
        user.save()

        if 'file' in request.data.keys():
            file_obj = request.data['file']
            upload = PhotoRestaurant(photo=file_obj, restaurant=restaurant)
            upload.save()

        return Response(status=201)

class RestaurantList(generics.ListAPIView):
    serializer_class = RestaurantListSerializer
    permission_classes = [permissions.IsAuthenticated]
    queryset = Restaurant.objects.all()

class RestaurantDetail(generics.RetrieveAPIView):
    serializer_class = RestaurantSerializer
    lookup_field = 'pk'
    permission_classes = [permissions.IsAuthenticated]
    queryset = Restaurant.objects.all()

class RestaurantSearchList(generics.ListAPIView):
    serializer_class = RestaurantListSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, *args, **kwargs):
        name="" #return all restaurants
        if 'name' in request.GET.keys():
            name=request.GET['name']
        obj = Restaurant.objects.filter(name__icontains=name)
        return Response(RestaurantListSerializer(obj, many=True).data, status=200)

class AddFeedBackView(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, *args, **kwargs):
        if ('feedback' not in request.POST.keys()) or ('restaurant_id' not in request.POST.keys()):
            return Response({'error':'parametrs is empty!'}, status=400)
        obj = Feedback(text=request.POST['feedback'], restaurant=Restaurant.objects.get(id=request.POST['restaurant_id']))
        obj.save()
        return Response(status=201)

class RestaurantFeedBackView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = FeedbackSerializer
    queryset = Feedback.objects.all()

    def get_queryset(self):
        return self.queryset.filter(restaurant__id=self.kwargs.get('id'))

class AddDishView(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = DishSerializer
    parser_classes = (MultiPartParser, )

    def post(self, request, *args, **kwargs):
        if 'name' not in request.POST.keys() or request.POST['name'] == "":
            return Response({'error': 'Name is empty!'}, status=400)
        if 'price' not in request.POST.keys() or request.POST['price'] == "":
            return Response({'error': 'Price is empty!'}, status=400)
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'Restaurant_id is empty!'}, status=400)
        if 'type' not in request.POST.keys() or request.POST['type'] == "":
            return Response({'error': 'type is empty!'}, status=400)
        if 'cuisine' not in request.POST.keys() or request.POST['cuisine'] == "":
            return Response({'error': 'cuisine is empty!'}, status=400)

        name = request.POST['name']
        price = request.POST['price']
        restaurant_id = request.POST['restaurant_id']
        type = request.POST['type']
        cuisine = request.POST['cuisine']

        if 'file' in request.data.keys():
            file_obj = request.data['file']
            upload = Dish(photo=file_obj, name=name, price=price, type=type, cuisine=cuisine)
        else:
            upload = Dish(name=name, price=price)

        upload.save()
        upload.restaurants.add(Restaurant.objects.get(id=restaurant_id))

        return Response(status=201)

class AddOrderView(generics.CreateAPIView):#доделать время оплаты неправильно, несколько одинаковых блюд в заказе
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = DishSerializer

    def post(self, request, *args, **kwargs):
        if 'user_id' not in request.POST.keys() or request.POST['user_id'] == "":
            return Response({'error': 'User_id is empty!'}, status=400)
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'Restaurant_id is empty!'}, status=400)
        if 'dishes_list' not in request.POST.keys() or request.POST['dishes_list'] == "":
            return Response({'error': 'Dishes_list is empty!'}, status=400)
        if 'is_paid' not in request.POST.keys() or request.POST['is_paid'] == "":
            return Response({'error': 'Is_paid is empty!'}, status=400)
        if 'total_price' not in request.POST.keys() or request.POST['total_price'] == "":
            return Response({'error': 'total_price is empty!'}, status=400)

        user_id = request.POST['user_id']
        restaurant_id = request.POST['restaurant_id']
        dishes_list = request.POST['dishes_list']
        is_paid = request.POST['is_paid']
        total_price = request.POST['total_price']

        order = Order(restaurant=Restaurant.objects.get(id=restaurant_id),
                      user=User.objects.get(id=user_id),
                      is_paid=is_paid,
                      total_price=total_price)

        order.save()

        dishes_json = json.loads(dishes_list)

        for dish_id in dishes_json:
            OrderDishes.objects.create(order=order, dish=Dish.objects.get(id=dish_id), amount=int(dishes_json[dish_id]))

        return Response(status=201)

class OrderRestaurantView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer
    queryset = Order.objects.all()

    def get_queryset(self):
        return self.queryset.filter(restaurant__id=self.kwargs.get('id'))

class OrderUserView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer
    queryset = Order.objects.all()

    def get_queryset(self):
        return self.queryset.filter(user__id=self.kwargs.get('id'))

class OrderRestaurantLastView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer
    queryset = Order.objects.all()

    def get_queryset(self):
        now_date = datetime.datetime.today()
        delta = datetime.timedelta(days=2)  # дельта в 2 дня
        now_date = now_date - delta
        return self.queryset.filter(creation_date__gte=now_date)

class RestaurantNearastView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = RestaurantSerializer
    queryset = Restaurant.objects.all()

    def get_queryset(self):
        dct = {}
        min = 10000000
        point = 1
        coords_x = [Decimal(x) for x in self.request.GET['coords'].split(',')]
        for obj in self.queryset.all():
            coords_y = [Decimal(x) for x in obj.coords.split(',')]
            delta = math.sqrt(abs(coords_x[0]**2 - coords_y[0]**2) + abs(coords_x[1]**2 - coords_y[1]**2))
            dct[obj.id] = delta
            # if delta < min:
            #     point = obj.id
            #     min = delta
        return self.queryset.filter(id=point)

class AddPhotoRestaurantView(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    parser_classes = (MultiPartParser, )

    def post(self, request, *args, **kwargs):
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'restaurant_id is empty!'}, status=400)

        restaurant_id = request.POST['restaurant_id']

        restaurant = Restaurant.objects.get(id=restaurant_id)

        file_obj = request.data['file']
        upload = PhotoRestaurant(photo=file_obj, restaurant=restaurant)
        upload.save()

        return Response(status=201)

 #Генерация таблицы со временем
class GenerationTimeView(generics.CreateAPIView):
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        for i in range(24):
            TimeBooking.objects.create(time=datetime.time(i, 0))
            TimeBooking.objects.create(time=datetime.time(i, 30))

        return Response(status=201)


class TimeBookingFreeView(generics.ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = TimeBookingSerializer
    queryset = TimeBooking.objects.all()

    def post(self, request, *args, **kwargs):
        if 'user_id' not in request.POST.keys() or request.POST['user_id'] == "":
            return Response({'error': 'User_id is empty!'}, status=400)
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'Restaurant_id is empty!'}, status=400)
        if 'date' not in request.POST.keys() or request.POST['date'] == "":
            return Response({'error': 'date is empty!'}, status=400)
        if 'seats' not in request.POST.keys() or request.POST['seats'] == "":
            return Response({'error': 'seats is empty!'}, status=400)

        user_id = request.POST['user_id']
        restaurant_id = request.POST['restaurant_id']
        date = request.POST['date'] #format 12.07.2016
        seats = int(request.POST['seats'])

        obj_restaurant = Restaurant.objects.get(id=restaurant_id)
        restaurant_regime = obj_restaurant.regime.split("-")
        regime_begin = restaurant_regime[0].split(":")
        regime_end = restaurant_regime[1].split(":")

        #Код, чтобы юзер мог иметь только одну бронь в день в определеном ресторане
        #if len(Booking.objects.filter(date=date, restaurant=obj_restaurant, user_id=user_id)) > 0:
            #return Response({'error': 'User have reserve in this restaurant '}, status=400)

        if int(regime_end[1]) == 0: #Чтобы последнее время бронирования было за пол часа до закрытия.
            regime_end_hour = int(regime_end[0]) - 1
            regime_end_minutes = 30
        else:
            regime_end_hour = int(regime_end[0])
            regime_end_minutes = 0

        start_time = datetime.time(hour=int(regime_begin[0]), minute=int(regime_begin[1]))
        end_time = datetime.time(hour=regime_end_hour, minute=regime_end_minutes)

        regime_time = self.queryset.filter(time__range=(start_time, end_time))
        available_time_booking = []

        for x in regime_time:
            bookings = Booking.objects.filter(date=date, restaurant=obj_restaurant, time=x)
            s = sum([int(i.seats) for i in bookings])
            if (s + seats) > obj_restaurant.seats: continue
            else: available_time_booking.append(x)

        return Response(TimeBookingSerializer(available_time_booking, many=True).data, status=200)

class AddBookingView(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, *args, **kwargs):
        if 'user_id' not in request.POST.keys() or request.POST['user_id'] == "":
            return Response({'error': 'User_id is empty!'}, status=400)
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'Restaurant_id is empty!'}, status=400)
        if 'date' not in request.POST.keys() or request.POST['date'] == "":
            return Response({'error': 'date is empty!'}, status=400)
        if 'seats' not in request.POST.keys() or request.POST['seats'] == "":
            return Response({'error': 'seats is empty!'}, status=400)
        if 'time' not in request.POST.keys() or request.POST['time'] == "":
            return Response({'error': 'time is empty!'}, status=400)

        user_id = request.POST['user_id']
        restaurant_id = request.POST['restaurant_id']
        date = request.POST['date'] #format 12.07.2016
        seats = int(request.POST['seats'])
        time = request.POST['time'].split(':')

        obj_bk = Booking(user_id=user_id,
                         restaurant_id=restaurant_id,
                         seats=seats, date=date,
                         time=TimeBooking.objects.get(time=datetime.time(hour=int(time[0]), minute=int(time[1]))))
        obj_bk.save()

        return Response({'bk_id':obj_bk.id}, status=201)

class RestaurantBookingView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = BookingSerializer
    queryset = Booking.objects.all()

    def get_queryset(self):
        return self.queryset.filter(restaurant_id=self.kwargs.get('id'))

class UpdateBookingStatusView(generics.UpdateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def put(self, request, *args, **kwargs):
        if 'booking_id' not in request.POST.keys() or request.POST['booking_id'] == "":
            return Response({'error': 'booking_id is empty!'}, status=400)
        if 'status' not in request.POST.keys() or request.POST['status'] == "":
            return Response({'error': 'status is empty!'}, status=400)

        booking_id = request.POST['booking_id']
        status = request.POST['status']

        obj_bk = Booking.objects.get(id=booking_id)
        obj_bk.status = status
        obj_bk.save()

        return Response(status=201)

class RestaurantOrderUserView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = OrderSerializer
    queryset = Order.objects.all()

    def get_queryset(self):
        return self.queryset.filter(user_id=self.kwargs.get('user_id'), restaurant_id=self.kwargs.get('restaurant_id'))

class RestaurantClientsView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = UserSerializer
    queryset = User.objects.all()

    def get_queryset(self):
        obj_ord = Order.objects.filter(restaurant_id=self.kwargs.get('id')).only('user_id')
        obj_bk = Booking.objects.filter(restaurant_id=self.kwargs.get('id')).only('user_id')

        set_ord = set([x.user_id for x in obj_ord])
        set_bk = set([x.user_id for x in obj_bk])

        set_all = set_bk | set_ord

        return UserSerializer(User.objects.filter(id__in=set_all), many=True).data

class UpdateRestaurantDescriptionView(generics.UpdateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def put(self, request, *args, **kwargs):
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'restaurant_id is empty!'}, status=400)
        if 'description' not in request.POST.keys() or request.POST['description'] == "":
            return Response({'error': 'description is empty!'}, status=400)

        restaurant_id = request.POST['restaurant_id']
        description = request.POST['description']

        obj = Restaurant.objects.get(id=restaurant_id)
        obj.description = description
        obj.save()

        return Response(status=201)

class UpdateRestaurantRegimeView(generics.UpdateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def put(self, request, *args, **kwargs):
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'restaurant_id is empty!'}, status=400)
        if 'regime' not in request.POST.keys() or request.POST['regime'] == "":
            return Response({'error': 'regime is empty!'}, status=400)

        restaurant_id = request.POST['restaurant_id']
        regime = request.POST['regime']

        obj = Restaurant.objects.get(id=restaurant_id)
        obj.regime = regime
        obj.save()

        return Response(status=201)

class UpdateRestaurantCoordsView(generics.UpdateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def put(self, request, *args, **kwargs):
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'restaurant_id is empty!'}, status=400)
        if 'coords' not in request.POST.keys() or request.POST['coords'] == "":
            return Response({'error': 'coords is empty!'}, status=400)

        restaurant_id = request.POST['restaurant_id']
        coords = request.POST['coords']

        obj = Restaurant.objects.get(id=restaurant_id)
        obj.coords = coords
        obj.save()

        return Response(status=201)

class UpdateRestaurantSeatsView(generics.UpdateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def put(self, request, *args, **kwargs):
        if 'restaurant_id' not in request.POST.keys() or request.POST['restaurant_id'] == "":
            return Response({'error': 'restaurant_id is empty!'}, status=400)
        if 'seats' not in request.POST.keys() or request.POST['seats'] == "":
            return Response({'error': 'seats is empty!'}, status=400)

        restaurant_id = request.POST['restaurant_id']
        seats = request.POST['seats']

        obj = Restaurant.objects.get(id=restaurant_id)
        obj.seats = seats
        obj.save()

        return Response(status=201)

class RestaurantBookingPreviousView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = BookingSerializer
    queryset = Booking.objects.all()

    def get_queryset(self):
        lst = []
        today_date = datetime.date.today()
        obj = self.queryset.filter(restaurant_id=self.kwargs.get('id'))
        for x in obj:
            day, month, year = x.date.split('.')
            date = datetime.date(year=int(year), month=int(month), day=int(day))
            if date < today_date:
                lst.append(x)
        return BookingSerializer(lst, many=True).data

class RestaurantBookingTodayView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = BookingSerializer
    queryset = Booking.objects.all()

    def get_queryset(self):
        lst = []
        today_date = datetime.date.today()
        obj = self.queryset.filter(restaurant_id=self.kwargs.get('id'))
        for x in obj:
            day, month, year = x.date.split('.')
            date = datetime.date(year=int(year), month=int(month), day=int(day))
            if date == today_date:
                lst.append(x)
        return BookingSerializer(lst, many=True).data

class RestaurantBookingFutureView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = BookingSerializer
    queryset = Booking.objects.all()

    def get_queryset(self):
        lst = []
        today_date = datetime.date.today()
        obj = self.queryset.filter(restaurant_id=self.kwargs.get('id'))
        for x in obj:
            day, month, year = x.date.split('.')
            date = datetime.date(year=int(year), month=int(month), day=int(day))
            if date > today_date:
                lst.append(x)
        return BookingSerializer(lst, many=True).data

class AddIngridientToTableView(generics.CreateAPIView):

    def post(self, request, *args, **kwargs):
        file = open('BorschApi/data/ingridients.json')
        text = file.read()
        j = json.loads(text)
        for i in j.keys():
            obj = Ingridient.objects.create(name=i)
            obj.save()
        return Response(status=201)

class RestaurantListDishesNewUserRSView(generics.ListAPIView):
    serializer_class = DishSerializer
    queryset = Dish.objects.all()

    def get(self, request, *args, **kwargs):
        restaurant_id = self.request.GET['restaurant_id']

        obj_ord = Order.objects.filter(restaurant_id=restaurant_id)
        lst = []
        dict = {}
        for o in obj_ord:
            dish = OrderDishes.objects.filter(order_id=o.id)
            for id in dish:
                if id.id in dict.keys():
                    dict[id.id] += id.amount
                else:
                    dict[id.id] = id.amount
        for i in dict.keys():
            return Response(DishSerializer(Dish.objects.get(id=i)).data)
        return Response({})

"""
class RestaurantListDishesUserRSView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = DishSerializer
    queryset = Dish.objects.all()

    def get_queryset(self):
        user_id = self.request.GET['user_id']
        restaurant_id = self.request.GET['restaurant_id']

        st = set()
        obj_ord = OrderDishes.objects.filter(user_id=user_id)
        st.add([x.dish_id for x in obj_ord])
        lst = list(st)

        obj_ord = Order.objects.filter(restaurant_id=restaurant_id)
        dict = {}
        for o in obj_ord:
            dish = OrderDishes.objects.filter(order_id=o.id)
            if dish.id in dict.keys():
                dict[dish.id] += dish.amount
            else:
                dict[dish.id] = dish.amount

        return

class RestaurantListDishesRSView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = DishSerializer
    queryset = Dish.objects.all()

    def get_queryset(self):
        dish_id = self.request.GET['dish_id']
        restaurant_id = self.request.GET['restaurant_id']

        dish = Dish.objects.get(id=dish_id)

        dishes = Dish.objects.all()

        obj_ord = Order.objects.filter(restaurant_id=restaurant_id)
        dict = {}
        for o in obj_ord:
            dish = OrderDishes.objects.filter(order_id=o.id)
            if dish.id in dict.keys():
                dict[dish.id] += dish.amount
            else:
                dict[dish.id] = dish.amount


        return
"""
def getNearestDishes(dish_id):
    st = set()
    obj_ord = OrderDishes.objects.filter(dish_id=dish_id)
    lst_ord = [x.order_id for x in obj_ord]
    a = OrderDishes.objects.filter(order_id__in=lst_ord)
    lst_dish = [i.dish_id for i in a]
    return list(set(lst_dish))

class AddRestaurantToTableView(generics.CreateAPIView):
    serializer_class = RestaurantSerializer

    def post(self, request, *args, **kwargs):
        file = open('BorschApi/data/restaurant.json')
        text = file.read()
        j = json.loads(text)
        for i in j:
            obj = Restaurant(name=i['name'], description=i['description'], regime=i['regime'],
                                            coords=i['coords'], seats=i['seats'], phone_number=i['phone_number'],
                                            check_sum=i['check_sum'])
            obj.save()
        return Response(status=201)

class AddUserToTableView(generics.CreateAPIView):
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        file = open('BorschApi/data/user.json')
        text = file.read()
        j = json.loads(text)
        for i in j:
            obj = User(first_name=i['first_name'], last_name=i['last_name'], email=i['email'],
                                            password=i['password'], phone_number=i['phone_number'])
            obj.save()
        return Response(status=201)


class AddOrdersToTableView(generics.CreateAPIView):
    serializer_class = OrderSerializer

    def post(self, request, *args, **kwargs):
        file = open('BorschApi/data/orders.json')
        text = file.read()
        j = json.loads(text)
        for i in j:
            obj = Order.objects.create(user_id=i['user_id'], restaurant_id=i['restaurant_id'], is_paid=i['is_paid'],
                                        total_price=i['total_price'])
            obj.save()
        return Response(status=201)

class AddOrderDishesToTableView(generics.CreateAPIView):
    serializer_class = OrderSerializer

    def post(self, request, *args, **kwargs):
        file = open('BorschApi/data/orderDishes.json')
        text = file.read()
        j = json.loads(text)
        for i in j:
            obj = OrderDishes.objects.create(order_id=i['order_id'], dish_id=i['dish_id'], amount=i['amount'])
            obj.save()
        return Response(status=201)

class AddDishesToTableView(generics.CreateAPIView):
    serializer_class = OrderSerializer

    def post(self, request, *args, **kwargs):
        file = open('BorschApi/data/dish.json')
        text = file.read()
        j = json.loads(text)
        for i in j:
            key_exists = 'name' in i
            if (key_exists == False):
                i.update({'name': 'pizza'})
            obj = Dish.objects.create(price=random.randint(500, 2300), name=i['name'], type=i['category'], cuisine=i['cuisine'])
            obj.save()

            for x in i['ingredients']:
                a = IngridientsDishes(dish=obj, ingridient=Ingridient.objects.get(name=x[0]))# ,amount=x[1])
                a.save()
        return Response(status=201)


def llogin(request):
    return render_to_response('j_login.html', {})


def rregister(request):
    return render_to_response('j_register.html', {})


def rrest(request):
    return render_to_response('j_restaurant.html', {})    


def bbooking(request):
    return render_to_response('j_booking.html', {})                   