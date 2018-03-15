$(function (){
  $(".tell-user-signup").click(function() {
    var in_reply_to = $(this).data("tweet")
    var user = $(this).data("user")
    var text = "Please signup before ordering https://pie-piper.me/signup";
    $.ajax({
      url: "/send-tweet",
      data: { 'tweet': text, 'user': user, 'in_reply_to': in_reply_to },
      dataType: "json",
      type: "POST",
      success: function() {
        clicked_button.html('Sent');
      }
    });
    $(this).html('Sent');
    $(this).attr("disabled", true);
  });
});