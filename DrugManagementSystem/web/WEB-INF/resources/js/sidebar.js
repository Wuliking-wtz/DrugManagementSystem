$(function(){
  $(".sidebar-submenu").slideUp(200);
  $('.sidebar-dropdown > a').click(function () {
    // $(".sidebar-submenu").slideUp(200);
    if($(this).parent().hasClass('active')) {
      $(this).parent().removeClass('active');
      $(this).next(".sidebar-submenu").slideUp(200);
    }else {
      // $(".sidebar-dropdown").removeClass("active");
      $(this).next(".sidebar-submenu").slideDown(200);
      $(this).parent().addClass('active');
    }
  });
  
})