$(".account_select").on('change', function() {
  var userId = $(this).data('user');
  var defaultVal = $(this).data('default');
  var selectElement = document.getElementById("select"+userId);

  if( ( ($(this).val()==3) || ($(this).val()==2) )
      &&
      (!confirm("Warning: User with ID number: "+userId+" will be granted " + selectElement.options[selectElement.selectedIndex].text + " priviliges with this change. Are you sure you want to make this change?")) )
      {
        resetForm("select"+userId, defaultVal)
      }
      else
      {
        changeUserType(userId, selectElement.value);
      }
})

function resetForm(id, defaultVal) {
  for(var index = 0; index < (document.getElementById(id).options.length); index++ ){
    if( document.getElementById(id).options[index].text == defaultVal ){
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
