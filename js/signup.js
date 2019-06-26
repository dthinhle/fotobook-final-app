$(function(){
  $("#signin-form").collapse("show")
  $("#collapse-toggle-signup").click(function () {
    $("#title").text("Sign up")
    $("#signin-form").collapse("toggle")
    $("#signup-form").collapse("toggle")
  })
  $("#collapse-toggle-signin").click(function () {
    $("#title").text("Sign in")
    $("#signin-form").collapse("toggle")
    $("#signup-form").collapse("toggle")
  })

})