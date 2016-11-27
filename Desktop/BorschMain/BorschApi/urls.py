from django.conf.urls import url, include
from .views import *


app_name = 'BorschApi'

auth_urls = [
    url(r'^login/$', LoginView.as_view()),
    url(r'^logout/$', LogoutView.as_view())
]

get_info_urls = [
    url(r'^users/$', UserList.as_view()),
    url(r'^user/$', UserAuth.as_view()),
    url(r'^user/(?P<id>\d+)/order$', OrderUserView.as_view()),
    url(r'^restaurants/$', RestaurantList.as_view()),
    url(r'^restaurants/coords$', RestaurantNearastView.as_view()),
    url(r'^restaurant/(?P<pk>\d+)$', RestaurantDetail.as_view()),
    url(r'^restaurant/(?P<id>\d+)/feedback$', RestaurantFeedBackView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/order$', OrderRestaurantView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/clients$', RestaurantClientsView.as_view()),
    url(r'^restaurant/(?P<restaurant_id>\d+)/user/(?P<user_id>\d+)/orders$', RestaurantOrderUserView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/order/last$', OrderRestaurantLastView.as_view()),
    url(r'^search/restaurants/$', RestaurantSearchList.as_view()),
    url(r'^booking/time/$', TimeBookingFreeView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/booking$', RestaurantBookingView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/booking/prev$', RestaurantBookingPreviousView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/booking/today$', RestaurantBookingTodayView.as_view()),
    url(r'^restaurant/(?P<id>\d+)/booking/future$', RestaurantBookingFutureView.as_view()),
]

add_urls = [
    url(r'^restaurant/$', AddRestaurantView.as_view()),
    url(r'^feedback/$', AddFeedBackView.as_view()),
    url(r'^dish/$', AddDishView.as_view()),
    url(r'^order/$', AddOrderView.as_view()),
    url(r'^restaurant/photo$', AddPhotoRestaurantView.as_view()),
    url(r'^booking/$', AddBookingView.as_view()),
]

update_urls = [
    url(r'^booking/status$', UpdateBookingStatusView.as_view()),
    url(r'^restaurant/description$', UpdateRestaurantDescriptionView.as_view()),
    url(r'^restaurant/regime$', UpdateRestaurantRegimeView.as_view()),
    url(r'^restaurant/coords$', UpdateRestaurantCoordsView.as_view()),
    url(r'^restaurant/seats$', UpdateRestaurantSeatsView.as_view()),
]

urlpatterns = [
    url(r'^auth/', include(auth_urls)),
    url(r'^add/', include(add_urls)),
    url(r'^get/', include(get_info_urls)),
    url(r'^update/', include(update_urls)),
    url(r'^register/$', RegisterView.as_view()),
]
