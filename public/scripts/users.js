$("select").on('change', function() {
  if($(this).val() == 3) {
    if(!confirm("Warning: User with ID number: "+$(this).data('user')+" will be granted administrator priviliges with this change. Are you sure you want to make this change?")) {
      resetForm("select"+$(this).data('user'), $(this).data('default'))
    }
    else {
      changeUserType($(this).data('user'), document.getElementById("select"+$(this).data('user')).value);
    }
  }
  else if ($(this).val() == 2) {
    if(!confirm("Warning: User with ID number: "+$(this).data('user')+" will be granted order-handler priviliges with this change. Are you sure you want to make this change?")) {
      resetForm("select"+$(this).data('user'), $(this).data('default'))
    }
    else{
      changeUserType($(this).data('user'), document.getElementById("select"+$(this).data('user')).value);
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

function changeUserType(userId, accountTypeId) {
  var data = { 'userId': userId, 'accountTypeId': accountTypeId };
  fetch('/change-user-type', {
    credentials: "same-origin",
    method: 'POST',
    body: JSON.stringify(data),
    headers: new Headers({
      'Content-Type': 'application/json'
    })
  })
};
