$('#signin').click(function(event) {
    console.log(this);
    event.preventDefault();
    request = $.ajax({
        type: 'POST',
        url: '/api/auth/login/',
        data: {'phone_number': document.forms.login.elements.phone_number.value,
            'password': document.forms.login.elements.password.value
        }, xhrFields: {
            withCredentials: true,
        },
        success: function() {
            window.location.href = "/rest/";
        },
        error: function() {
            console.error('Error')
        }
    });
});
