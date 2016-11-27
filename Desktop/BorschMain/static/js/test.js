$('#register').click(function(event) {
    console.log(this);
    console.log(document.forms.register.elements.phone_number);
    event.preventDefault();
    data={'phone_number': document.forms.register.elements.phone_number.value,
                'first_name': document.forms.register.elements.first_name.value,
                'last_name': document.forms.register.elements.last_name.value,
                'email': document.forms.register.elements.email.value,
                'password': document.forms.register.elements.password.value,
                'is_admin_restaurant': 'False',
                'is_waiter': 'False'};
        $.ajax({
            type: 'POST',
            url: 'http://188.166.65.99:8080/api/register/',
            data: data,
            xhrFields: {
                withCredentials: true,
            },
            success: function () {
                $.ajax({
                    type: 'POST',
                    url: 'http://188.166.65.99:8080/api/auth/login/',
                    data: {
                        'phone_number': data.phone_number,
                        'password': data.password
                    }, xhrFields: {
                        withCredentials: true,
                    },
                    success: function () {
                        window.location.href = "http://188.166.65.99:8080/rest/";


                    }
                })
        }
        // todo добавить визуализацию ошибок, например, такой пользователь уже существует
    }) });



$(document).ready(function(){
 $("input#is_admin").change(function(){
  console.log($("input#is_admin"));
  console.log(this);

  if ($(this).prop("checked")) {
      $('#next_step').text('Next step');
      $('#hide').fadeIn().show();
      $('#link_to_terms').attr('hidden', 'true');

      return;
  } else {
      $('#hide').fadeOut(300);
      $('#next_step').text('Get started');
      $('#link_to_terms').attr('hidden', 'false');
  }

 });
});