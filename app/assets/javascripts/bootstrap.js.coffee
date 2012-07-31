jQuery ->
  $("a[rel=popover]").popover()
  $("img[rel=popover]").popover({
    placement: 'right'
  });  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.dropdown-toggle').dropdown()
