from __future__ import unicode_literals
from django.db import models
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.base_user import AbstractBaseUser
from django.utils.translation import ugettext_lazy as _
from django.core.mail import send_mail
from django.utils import timezone
from .user_manager import UserManager
import uuid
import os
import datetime

def get_file_path_restaurant(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('images/restaurants', filename)

def get_file_path_dish(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('images/dishes', filename)

class Dish(models.Model):
    class Meta:
        db_table = 'dish'
        verbose_name = 'Блюдо'
        verbose_name_plural = 'Блюда'

    price = models.FloatField()
    name = models.CharField(max_length=15)
    type = models.CharField(max_length=20, blank=True)
    cuisine = models.CharField(max_length=20, blank=True)
    photo = models.ImageField(upload_to=get_file_path_dish, blank=True)

class Restaurant(models.Model):
    class Meta:
        db_table = 'restaurant'
        verbose_name = 'Ресторан'
        verbose_name_plural = 'Рестораны'

    name = models.CharField(max_length=15, default="")
    description = models.TextField(blank=True)
    regime = models.CharField(max_length=15)
    coords = models.CharField(max_length=19)
    dishes = models.ManyToManyField(Dish, related_name='restaurants', blank=True)
    seats = models.IntegerField(default=1)
    check_sum = models.FloatField(default=0)
    phone_number = models.CharField(max_length=11)

class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(_('email address'))
    phone_number = models.CharField(_('phone number'), max_length=11,unique=True)
    first_name = models.CharField(_('first name'), max_length=30)
    last_name = models.CharField(_('last name'), max_length=30, blank=True)
    date_joined = models.DateTimeField(_('date joined'), default=timezone.now)
    is_staff = models.BooleanField(
        _('staff status'),
        default=False,
        help_text=_('Designates whether the user can log into this admin site.'),
    )
    is_active = models.BooleanField(
        _('active'),
        default=True,
        help_text=_(
            'Designates whether this user should be treated as active. '
            'Unselect this instead of deleting accounts.'
        ),
    )
    restaurant_name = models.CharField(_('restaurant name'), max_length=30, blank=True)
    is_admin_restaurant = models.BooleanField(
        _('admin restaurant'),
        default=False,
    )
    is_waiter = models.BooleanField(
        _('waiter restaurant'),
        default=False,
    )
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, related_name='admins', null=True)
    #avatar = models.ImageField(upload_to='avatars/', null=True, blank=True)

    objects = UserManager()

    USERNAME_FIELD = 'phone_number'
    REQUIRED_FIELDS = ['email', 'first_name']

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')

    def get_full_name(self):
        '''
        Returns the first_name plus the last_name, with a space in between.
        '''
        full_name = '%s %s' % (self.first_name, self.last_name)
        return full_name.strip()

    def get_short_name(self):
        '''
        Returns the short name for the user.
        '''
        return self.first_name

    def email_user(self, subject, message, from_email=None, **kwargs):
        '''
        Sends an email to this User.
        '''
        send_mail(subject, message, from_email, [self.email], **kwargs)

class Order(models.Model):
    class Meta:
        db_table = 'order'
        verbose_name = 'Заказ'
        verbose_name_plural = 'Заказы'

    total_price = models.FloatField()
    creation_date = models.DateTimeField(auto_now_add=True)
    payment_date = models.DateTimeField(auto_now_add=True)
    is_paid = models.BooleanField(default=False)
    user = models.ForeignKey(User,on_delete=models.CASCADE, related_name='orders')
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, related_name='orders')
    dishes = models.ManyToManyField(Dish, through='OrderDishes', blank=True, related_name='orders')

class PhotoRestaurant(models.Model):
    class Meta:
        db_table = 'photo_restaurant'
        verbose_name = 'Фотографии ресторанов'
        verbose_name_plural = 'Фотография'

    photo = models.ImageField(upload_to=get_file_path_restaurant)
    restaurant = models.ForeignKey(Restaurant, related_name='photos')

class OrderDishes(models.Model):
    class Meta:
        db_table = 'order_dishes'

    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    dish = models.ForeignKey(Dish, on_delete=models.CASCADE, related_name='order_dishes')
    amount = models.IntegerField(default=1)

class Category(models.Model):#пока нет в базе
    class Meta:
        db_table = 'category'
        verbose_name = 'Категория'
        verbose_name_plural = 'Категории'

    name = models.CharField(max_length=15)

class Feedback(models.Model):
    class Meta:
        db_table = 'feedback'
        verbose_name = 'Отзывы'
        verbose_name_plural = 'Отзыв'

    text = models.TextField()
    restaurant = models.ForeignKey(Restaurant, related_name='feedbacks')

class TimeBooking(models.Model):
    class Meta:
        db_table = 'time_booking'
        verbose_name = 'Время брони'
        verbose_name_plural = 'Время брони'

    time = models.TimeField()

class Booking(models.Model):
    class Meta:
        db_table = 'booking'
        verbose_name = 'Бронирование'
        verbose_name_plural = 'Бронь'

    date = models.TextField(max_length=8, blank=True)
    user = models.ForeignKey(User, related_name='reservations')
    restaurant = models.ForeignKey(Restaurant, related_name='reservations')
    seats = models.IntegerField(default=1)
    time = models.ForeignKey(TimeBooking, related_name='booking', blank=True, default=0)
    status = models.BooleanField(default=False)
    time_created = models.DateTimeField(default=datetime.datetime.now(), blank=True)

class Ingridient(models.Model):
    class Meta:
        db_table = 'ingridients'
        verbose_name = 'Ингредиенты'
        verbose_name_plural = 'Ингредиент'

    name = models.TextField(max_length=20, blank=True)
    dishes = models.ManyToManyField(Dish, through='IngridientsDishes', blank=True, related_name='ingridients_dishes')

class IngridientsDishes(models.Model):
    class Meta:
        db_table = 'ingridients_dishes'

    dish = models.ForeignKey(Dish, on_delete=models.CASCADE)
    ingridient = models.ForeignKey(Ingridient, on_delete=models.CASCADE, related_name='ingridient')
    amount = models.FloatField(default=0)