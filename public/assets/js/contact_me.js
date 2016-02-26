$(document).on('ready', function(){

 $('#contactForm').on('submit', function(){

   event.preventDefault(); // prevent default submit behaviour

   // get values from FORM
   var name = $("input#name").val(),
    dogname = $("input#dogname").val(),
       email = $("input#email").val(),
       phone = $("input#phone").val(),
       message = $("input#message").val();

   // Check for white space in name for Success/Fail message
   $.ajax({
     url: "/",
     type: "POST",
     data: {
       name: name,
       dogname: dogname,
       email: email,
       phone: phone,
       message: message
     },
     cache: false,
     success: function() {
       // Success message
       $('#success').html("<div class='alert alert-success'>");
       $('#success > .alert-success').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
           .append("</button>");
       $('#success > .alert-success')
           .append("<strong>Your information has been sent. </strong>");
       $('#success > .alert-success')
           .append('</div>');

       //clear all fields
       $('#contactForm').trigger("reset");
     },
     error: function() {
       // Fail message
       $('#success').html("<div class='alert alert-danger'>");
       $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
           .append("</button>");
       $('#success > .alert-danger').append("<strong>Sorry " + name + ", it seems that my mail server is not responding. Please try again later!");
       $('#success > .alert-danger').append('</div>');
       //clear all fields
       $('#contactForm').trigger("reset");
     }
   })
 })

});