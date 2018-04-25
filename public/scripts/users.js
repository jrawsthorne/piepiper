$("select").on('change', function() {
  if($(this).val() == 3){
    alert("Warning: "+$(this).data('user')+" will be granted administrator priviliges with this change.")
  }
  else if ($(this).val() == 2) {
    alert("Warning: "+$(this).data('user')+" will be granted order-handler priviliges with this change.")
  }
})
