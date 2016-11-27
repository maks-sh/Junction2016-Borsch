
function confirmed(elem) {
    elem.classList.toggle('hover');
    $(elem).parent().prev().toggleClass('book__icon-confirmed');
    $(elem).parent().parent().toggleClass('book-border');
    elem.value ^= 1;
    console.log(elem.value);
    $.ajax({
        url: 'http://188.166.65.99:8080/api/update/booking/status',
        type: 'PUT',
        success: function(data_today) {
            fetch(data_today);
        },
        xhrFields: {
            withCredentials: true,
        },
    });
}