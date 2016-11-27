from django.conf.urls import url, include
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from BorschApi.views import GenerationTimeView #Генерация таблицы со временем
from BorschApi.views import AddIngridientToTableView #Генерация таблицы ингридиенты
from BorschApi.views import AddRestaurantToTableView
from BorschApi.views import AddUserToTableView
from BorschApi.views import AddOrdersToTableView
from BorschApi.views import AddOrderDishesToTableView
from BorschApi.views import AddDishesToTableView
from BorschApi.views import RestaurantListDishesNewUserRSView
from BorschApi.views import llogin, rrest, rregister, bbooking



urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^api/', include('BorschApi.urls')),
    url(r'^generate/ingridients/', AddIngridientToTableView.as_view()),#Генерация таблицы ингридиенты
    url(r'^rs/', RestaurantListDishesNewUserRSView.as_view()),
    url(r'^generate/dish/', AddDishesToTableView.as_view()),#Генерация таблицы пользователи
    url(r'^login/$', llogin, name='j'),
    url(r'^rest/$', rrest, name='j'),
    url(r'^register/$', rregister, name='j'),
    url(r'^booking/$', bbooking, name='j'),
    # url(r'^generate/users/', AddUserToTableView.as_view()),#Генерация таблицы пользователи
    # url(r'^generate/restaurants/', AddRestaurantToTableView.as_view()),#Генерация таблицы ресторанов
    # url(r'^generate/orders/', AddOrdersToTableView.as_view()),#Генерация таблицы заказов
    # url(r'^generate/orderdishes/', AddOrderDishesToTableView.as_view()),#Генерация таблицы
    # url(r'^time/', GenerationTimeView.as_view()), #Генерация таблицы со временем
]

if settings.DEBUG:
    urlpatterns = urlpatterns + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
