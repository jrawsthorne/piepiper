$(function (){
  $('#locationChanger').on("change", function() {
    window.location.href = "/?location="+$(this).val()
  })
})