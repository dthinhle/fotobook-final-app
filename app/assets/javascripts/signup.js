$(function(){
  $("#signin-form").collapse("show")
  $("#collapse-toggle-signup").click(function (e) {
    e.preventDefault();
    $("#title").text("Sign up")
    $("#signin-form").collapse("toggle")
    $("#signup-form").collapse("toggle")
  })
  $("#collapse-toggle-signin").click(function (e) {
    e.preventDefault();
    $("#title").text("Sign in")
    $("#signin-form").collapse("toggle")
    $("#signup-form").collapse("toggle")
  })

})