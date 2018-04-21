function accountTypeChange(userId){
  select = document.getElementById(userId+"AccountType";
  if(select).value == "Admin"){
    if(!confirm("Are you sure you want to grant this user administrator priviliges?")){
      value = (User.find(userId)).account_type.name
      var options = select.options;
      for(var option, index = 0; option = options[index]; index++){
        if(option.value == value){
          sel.selectedIndex = index;
        }
      }
    }
  }
}
