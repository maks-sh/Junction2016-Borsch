$(document).ready(function() {
    $.ajax({
        url: "/api/get/user/",
        type: 'GET',
        success: function (data_user) {

            var user_data = data_user[0];
            console.log(user_data);
            $('#user-info').text(user_data.first_name + ' ' + (user_data.last_name == '' ? user_data.first_name : ''));
            console.log(user_data.first_name);
            $.ajax({
                url: "/api/get/restaurant/" + user_data.restaurant,
                type: 'GET',
                success: function (rest_data) {
                    // $('.el__ref').click(function() {
                    //     $('.el__ref__active').removeClass('el__ref__active');
                    //     $(this).addClass('el__ref__active');
                    // });


                    $('.rest_name').text(rest_data.name);
                    console.log(rest_data.coords, rest_data.name);
                    if (/rest/i.test(window.location.pathname)) {
                        console.log(rest_data.coords);
                        $.ajax({
                            url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + rest_data.coords + "&key=AIzaSyAMciCzTf0qkhZ_irsqOgUUuLSBcQaNIqc&language=en",
                            type: 'GET',
                            success: function(address) {
                                $('#address').text(address.results['0'].formatted_address);
                            },

                        });
                        $('.rest_regime').text(rest_data.regime);
                        $('.rest_coord').text(rest_data.coords);
                        $('.rest_descp').text(rest_data.description);
                    }
                    if (/book/i.test(window.location.pathname)) {
                        var date = new Date();
                        $('#weekday').text(getWeekDay(date));
                        $('#day').text(date.toLocaleString("en-US", { year: 'numeric', month: 'long', day: 'numeric'}));
                        $.ajax({
                            url: "/api/get/restaurant/" + user_data.restaurant + "/booking/today/",
                            type: 'GET',
                            success: function(data_today) {
                                fetch(data_today);
                                $('#counter').text(data_today.length + ' reservations')
                            },
                            xhrFields: {
                                withCredentials: true,
                            },
                            error: function() {
                                window.location.href = "/login/";
                                data = {
                                    'msg': 'To look this page you should be sign in'
                                }
                            }
                        });
                    }
                    function getWeekDay(date) {
                        var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                        return days[date.getDay()];
                    }
                },
                xhrFields: {
                    withCredentials: true,
                },
            });
            $('#signout').click(function(event) {
                event.preventDefault();
                $.ajax({
                    headers: {
                        "X-CSRFToken": getCookie('csrftoken')
                    },
                    type: 'DELETE',
                    url: '/api/auth/logout/',
                    xhrFields: {
                        withCredentials: true,
                    },
                    success: function () {
                        window.location.href = "/login/";
                    }
                });
            });
            $('#prev').click(function() {
                $.ajax({
                    type: 'GET',
                    url: "/api/get/restaurant/" + user_data.restaurant + "/booking/prev",
                    xhrFields: {
                        withCredentials: true,
                    },
                    success: function(data_prev) {
                        $('#counter').text(data_prev.length + ' reservations')
                        fetch(data_prev, true)
                    },
                });
            });
            $('#next').click(function() {
                $.ajax({
                    type: 'GET',
                    url: "/api/get/restaurant/" + user_data.restaurant + "/booking/future",
                    xhrFields: {
                        withCredentials: true,
                    },
                    success: function(data_next) {
                        $('#counter').text(data_next.length + ' reservations')
                        fetch(data_next, false)
                    },
                });
            });
            $('#today').click(function() {
                $.ajax({
                    type: 'GET',
                    url: "/api/get/restaurant/" + user_data.restaurant + "/booking/today/",
                    xhrFields: {
                        withCredentials: true,
                    },
                    success: function(data_today) {
                        $('#counter').text(data_today.length + ' reservations')
                        fetch(data_today, false)
                    },
                });
            });
            $('.el').click(function() {
                $('.active').removeClass('active');
                $(this).addClass('active');
            });

        },
        xhrFields: {
            withCredentials: true,
        },
        error: function() {
            window.location.href = "/login/";
            data = {
                'msg': 'To look this page you should be sign in'
            }
        }
    });

});


function fetch(data, previous) {
    console.log(data);
    if (data.length == 0) {
        $('#books').text('There is no reservation')
        } 
    else {
	       	console.log(data);
	        var html = '';
            data.forEach(function(item, i, arr) {
	            html += book(item.user.first_name, item.user.last_name,  item.user.phone_number, item.user.email, item.date, item.time.time, item.seats, previous);   
        	});
			$('#books').html(html);
    }
}

    function book(name, lastname, phone, email, date, time, seats, previous){
        html = '<div class="book">' +
                        '<div class="book__icon-add"></div>' +
                        '<div class="book__text">' +
                            '<p class="book_field field__name bold">' + name + ' ' + lastname +'</p>' +
                            // '<p class="book_field field__time">' 15 minutes ago</p>
                            '<p class="book_field field__contacts bold">Contacts:</p>' +
                            '<ul>' +
                                '<li class="book_field"><a href="tel: ' + phone + '">' +
                                    '<img class="small__icon" src="/static/img/phone.svg" alt="tel" width="15px" height="15px">' +
                                    phone +
                                '</a></li>';
        if (email) {
            html += '<li class="book_field"><a href="mailto:' + email + '">' +
                        '<img class="small__icon" src="/static/img/mail.svg" alt="email" width="15px" height="15px">' +
                        email + '</a></li></ul>';
        }
        html += '<p class="book_field field__date"><span class="bold">Reservation date: </span>' +
                    time + ' ' + date + '</p>' +
                '<p class="book_field field__seats"><span class="bold">Seats: </span>' +
                    seats + '</p>' +
                '<p class="book_field confirmed bold">Confirmed: </p>' +
                '<div id="switch" class="switcher ';
        if (previous==true) {
	        html += 'hover'
        }
        html += '" onclick="confirmed(this)"><div id="toggle"></div></div></div></div>'
        return html;
    }

function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie != '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) == (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
