$('#signin').click(function(event) {
    console.log(this);
    event.preventDefault();
    request = $.ajax({
        type: 'POST',
        url: 'http://188.166.65.99:8080/api/auth/login/',
        data: {'phone_number': document.forms.login.elements.phone_number.value,
            'password': document.forms.login.elements.password.value
        }, xhrFields: {
            withCredentials: true,
        },
        success: function() {
            window.location.href = "http://188.166.65.99:8080/rest/";
        },
        error: function() {

        }
    });
});
