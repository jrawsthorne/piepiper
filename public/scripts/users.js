$("select").on('change', function() {
  if($(this).val() == 3) {
    if(!confirm("Warning: User with ID number: "+$(this).data('user')+" will be granted administrator priviliges with this change. Are you sure you want to make this change?")) {
      resetForm("select"+$(this).data('user'), $(this).data('default'))
    }
  }
  else if ($(this).val() == 2) {
    if(!confirm("Warning: User with ID number: "+$(this).data('user')+" will be granted order-handler priviliges with this change. Are you sure you want to make this change?")) {
      resetForm("select"+$(this).data('user'), $(this).data('default'))
    }
  }
})

function resetForm(id, defaultVal) {
  for(var index = 0; index < (document.getElementById(id).options.length); index++ ){
    if( document.getElementById(id).options[index].value == defaultVal ){
      document.getElementById(id).selectedIndex = index;
      break;
    }
  }
}
