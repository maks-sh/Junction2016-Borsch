
$('#edit-rest-name').click(function(){
  $(this).hide();
  $(this).prev('.helper').addClass('editable');
  // $('.helper').addClass('editable');
  // $('.description__text').attr('contenteditable', 'true');
  $(this).prevAll('.helper').contents('.editable-text').attr('contenteditable', 'true');
  console.log($(this).prevAll('.helper'));
  $('#save-rest-name').show();
});

$('#save-rest-name').click(function(){
  $(this).hide();
  $(this).prevAll('.helper').removeClass('editable');
  $(this).prevAll('.helper').contents('.editable-text').removeAttr('contenteditable');
  console.log($(this).prevAll('.helper'));
  // $('.helper').removeClass('editable');
  // $('.description__text').removeAttr('contenteditable');
  $('#edit-rest-name').show();
});

$('#edit-rest-coord').click(function(){
  $(this).hide();
  $(this).prev('.helper').addClass('editable');
  // $('.helper').addClass('editable');
  // $('.description__text').attr('contenteditable', 'true');
  $(this).prevAll('.helper').contents('.editable-text').attr('contenteditable', 'true');
  console.log($(this).prevAll('.helper'));
  $('#save-rest-coord').show();
});

$('#save-rest-coord').click(function(){
  $(this).hide();
  $(this).prevAll('.helper').removeClass('editable');
  $(this).prevAll('.helper').contents('.editable-text').removeAttr('contenteditable');
  console.log($(this).prevAll('.helper'));
  // $('.helper').removeClass('editable');
  // $('.description__text').removeAttr('contenteditable');
  $('#edit-rest-coord').show();
});

$('#edit-rest-oh').click(function(){
  $(this).hide();
  $(this).prev('.helper').addClass('editable');
  // $('.helper').addClass('editable');
  // $('.description__text').attr('contenteditable', 'true');
  $(this).prevAll('.helper').contents('.editable-text').attr('contenteditable', 'true');
  console.log($(this).prevAll('.helper'));
  $('#save-rest-oh').show();
});

$('#save-rest-oh').click(function(){
  $(this).hide();
  $(this).prevAll('.helper').removeClass('editable');
  $(this).prevAll('.helper').contents('.editable-text').removeAttr('contenteditable');
  console.log($(this).prevAll('.helper'));
  // $('.helper').removeClass('editable');
  // $('.description__text').removeAttr('contenteditable');
  $('#edit-rest-oh').show();
});

$('#edit-rest-ab').click(function(){
  $(this).hide();
  $(this).prev('.helper').addClass('editable');
  // $('.helper').addClass('editable');
  // $('.description__text').attr('contenteditable', 'true');
  $(this).prevAll('.helper').contents('.editable-text').attr('contenteditable', 'true');
  console.log($(this).prevAll('.helper'));
  $('#save-rest-ab').show();
});

$('#save-rest-ab').click(function(){
  $(this).hide();
  $(this).prevAll('.helper').removeClass('editable');
  $(this).prevAll('.helper').contents('.editable-text').removeAttr('contenteditable');
  console.log($(this).prevAll('.helper'));
  // $('.helper').removeClass('editable');
  // $('.description__text').removeAttr('contenteditable');
  $('#edit-rest-ab').show();
});

$('#edit-rest-tel').click(function(){
  $(this).hide();
  $(this).prev('.helper').addClass('editable');
  // $('.helper').addClass('editable');
  // $('.description__text').attr('contenteditable', 'true');
  $(this).prevAll('.helper').contents('.editable-text').attr('contenteditable', 'true');
  console.log($(this).prevAll('.helper'));
  $('#save-rest-tel').show();
});

$('#save-rest-tel').click(function(){
  $(this).hide();
  $(this).prevAll('.helper').removeClass('editable');
  $(this).prevAll('.helper').contents('.editable-text').removeAttr('contenteditable');
  console.log($(this).prevAll('.helper'));
  // $('.helper').removeClass('editable');
  // $('.description__text').removeAttr('contenteditable');
  $('#edit-rest-tel').show();
});

$('#edit_desription').click(function(){
  $(this).hide();
  $(this).prev('.helper').addClass('editable');
  // $('.helper').addClass('editable');
  // $('.description__text').attr('contenteditable', 'true');
  $(this).prevAll('.helper').contents('.editable-text').attr('contenteditable', 'true');
  console.log($(this).prevAll('.helper'));
  $('#save_desription').show();
});

$('#save_desription').click(function(){
  $(this).hide();
  $(this).prevAll('.helper').removeClass('editable');
  $(this).prevAll('.helper').contents('.editable-text').removeAttr('contenteditable');
  console.log($(this).prevAll('.helper'));
  // $('.helper').removeClass('editable');
  // $('.description__text').removeAttr('contenteditable');
  $('#edit_desription').show();
  // $.ajax({
  //     //TOdo исправить
  //     url: "http://188.166.65.99:8080/api/update/restaurant/description" + user_data.restaurant,
  //     type: 'GET',
  //     success: function (rest_data) {
  //         $('.rest_name').text(rest_data.name);
  //     },
  //     xhrFields: {
  //         withCredentials: true,
  //     },
  // });
});



//************************ Menu ********************************
var $TABLE = $('#table');
var $BTN = $('#save-menu');
var $EXPORT = $('#export');

$('#table-add').click(function () {
  var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
  $TABLE.find('table').append($clone);
});

$('.table-remove').click(function () {
  $(this).parents('tr').detach();
});

// A few jQuery helpers for exporting only
jQuery.fn.pop = [].pop;
jQuery.fn.shift = [].shift;

$BTN.click(function () {
  var $rows = $TABLE.find('tr:not(:hidden)');
  var headers = [];
  var data = [];

  // Get the headers (add special header logic here)
  $($rows.shift()).find('th:not(Delete row)').each(function () {
    headers.push($(this).text().toLowerCase());
  });

  // Turn all existing rows into a loopable array
  $rows.each(function () {
    var $td = $(this).find('td');
    var h = {};

    // Use the headers from earlier to name our hash keys
    headers.forEach(function (header, i) {
      h[header] = $td.eq(i).text();
    });

    data.push(h);
  });

  // Output the result
  $EXPORT.text(JSON.stringify(data));
});