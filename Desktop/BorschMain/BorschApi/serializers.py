from rest_framework import serializers
from .models import User,Restaurant, Dish, PhotoRestaurant, Feedback, TimeBooking, Order, OrderDishes, Booking
from .models import Category

class PhotoRestaurantSerializer(serializers.ModelSerializer):

    class Meta:
        model = PhotoRestaurant
        fields = ('id', 'photo')

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('id', 'phone_number', 'first_name', 'last_name', 'email','is_admin_restaurant','is_waiter', 'restaurant_name', 'restaurant')

class DishSerializer(serializers.ModelSerializer):

    class Meta:
        model = Dish
        fields = ('id', 'price', 'name', 'photo', 'type', 'cuisine')

class DishOrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = Dish
        fields = ('id', 'price', 'name', 'type', 'cuisine')

class OrderDishesSerializer(serializers.ModelSerializer):
    dish = serializers.SerializerMethodField()

    class Meta:
        model = OrderDishes
        fields = ('id', 'dish', 'amount')

    def get_dish(self, obj):
        return DishOrderSerializer(Dish.objects.get(id=obj.dish_id)).data

class DishOrderRsSerializer(serializers.ModelSerializer):

    class Meta:
        model = Dish
        fields = ('id', 'price', 'name', 'type', 'cuisine')

class OrderDishesRsSerializer(serializers.ModelSerializer):
    dish = serializers.SerializerMethodField()

    class Meta:
        model = OrderDishes
        fields = ('id', 'dish', 'amount')

    def get_dish(self, obj):
        return DishOrderSerializer(Dish.objects.get(id=obj.dish_id)).data

class RestaurantSerializer(serializers.ModelSerializer):
    dishes = DishSerializer(required=False, many=True)
    photos = PhotoRestaurantSerializer(many=True)

    class Meta:
        model = Restaurant
        fields = ('id', 'description', 'regime', 'coords', 'name', 'dishes', 'photos', 'seats')

class RestaurantOrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = Restaurant
        fields = ('id', 'description', 'regime', 'coords', 'name', 'seats')

class RestaurantListSerializer(serializers.ModelSerializer):
    photos = PhotoRestaurantSerializer(many=True)

    class Meta:
        model = Restaurant
        fields = ('id', 'description', 'regime', 'coords', 'name', 'photos')

class OrderSerializer(serializers.ModelSerializer):
    dishes = serializers.SerializerMethodField()
    creation_date = serializers.DateTimeField(format='%d %B %Y %X')
    payment_date = serializers.DateTimeField(format='%d %B %Y %X')
    user = UserSerializer(required=False)
    restaurant = RestaurantOrderSerializer(required=False)

    class Meta:
        model = Order
        fields = ('id', 'total_price', 'creation_date', 'payment_date', 'is_paid', 'dishes', 'user', 'restaurant')

    def get_dishes(self, obj):
        return OrderDishesSerializer(OrderDishes.objects.filter(order_id=obj.id), many=True).data

class FeedbackSerializer(serializers.ModelSerializer):

    class Meta:
        model = Feedback
        fields = ('id', 'text')

class TimeBookingSerializer(serializers.ModelSerializer):
    time = serializers.TimeField(format="%H:%M")

    class Meta:
        model = TimeBooking
        fields = ('id', 'time')

class BookingSerializer(serializers.ModelSerializer):
    user = UserSerializer(required=False)
    time = TimeBookingSerializer(required=False)
    time_created = serializers.DateTimeField(format="%d-%m-%Y %H:%M")

    class Meta:
        model = Booking
        fields = ('id', 'user', 'date', 'time', 'seats', 'status', 'time_created')

class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = Category
        fields = ('id', 'name')