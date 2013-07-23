var nowTemp = new Date();
var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
 
var checkin = $('#dpd1').datepicker({
  format: 'yyyy-mm-dd'
}).on('changeDate', function(ev) {
    var newDate = new Date(ev.date)
    newDate.setDate(newDate.getDate() + 30);
    checkout.setValue(newDate);
  checkin.hide();
  $('#dpd2')[0].focus();
}).data('datepicker');
var checkout = $('#dpd2').datepicker({
  format: 'yyyy-mm-dd',
  onRender: function(date) {
    return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
  }
}).on('changeDate', function(ev) {
  checkout.hide(); 
  window.location= "?start_date=" + $('#dpd1').val() + '&' + "end_date=" + ev.date.getFullYear() + '-' + (ev.date.getMonth() + 1) + '-' + ev.date.getDate();
}).data('datepicker');