$(document).ready(function(){

  // Start Sidebar
  $("#menu-toggle, #close").click(function(e) {
      e.preventDefault();
      
      $("#wrapper").toggleClass("toggled");

      if($("#wrapper").hasClass("toggled")) {
        $("nav").toggle();
      } else {
        setTimeout(function() {
          $("nav").toggle();
        }, 500);
      }
  });

  $('a.page-scroll').bind('click', function(event) {
      var $anchor = $(this);
      $('html, body').stop().animate({
          scrollTop: $($anchor.attr('href')).offset().top
      }, 1500, 'easeInOutExpo');

      if($("#wrapper").hasClass("toggled")) {
        
        $("#wrapper").toggleClass("toggled");
        
        if($("#wrapper").hasClass("toggled")) {
          $("nav").toggle();
        } else {
          setTimeout(function() {
            $("nav").toggle();
          }, 500);
        }

      }
      event.preventDefault();
  });
  // End Sidebar

  // Start Typed
  $(function(){
    $(".typed").typed({
      strings: ["web developer.^1000", "technology enthusiast.^1000", "father.^1000", "husband.^1000", "career changer.^1000"],
      typeSpeed: 0,
      loop: true
    });
  });
  // End Typed

  // Carousel
  $('.carousel').carousel({
    // interval: 2000
  })

  // Contact Icon Text
  $(".contact-icon").mouseover(function() {
    var text = $(this).attr("alt");
    $("#contact-header").text(text);
  });

  $(".contact-icon").mouseleave(function() {
    $("#contact-header").text("Get in touch!");
  });

});
