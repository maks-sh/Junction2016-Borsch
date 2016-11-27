from django.contrib import admin
from .models import User, Restaurant, Order, Dish, Category, Feedback, Booking

admin.site.register(User)
admin.site.register(Restaurant)
admin.site.register(Order)
admin.site.register(Dish)
admin.site.register(Category)
admin.site.register(Feedback)
admin.site.register(Booking)
