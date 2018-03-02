$(function (){    
    var availableItems = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: itemsArray
    });
  $('.typeahead').typeahead({
    hint: true,
    minLength: 1,
    highlight: true,
    classNames: {
      menu : 'dropdown-menu tt-menu',
      suggestion: 'dropdown-item tt-suggestion',
    }
  },
  {
    name: 'items',
    source: availableItems
  });
  
  var num = 0;
  
  $("#add button").click(function(){
    $('<li class="list-group-item"><input placeholder="Search for an item..." required name="item[]" class="form-control typeahead-'+num+'" type="text"></li>').insertBefore($(this).parent());
    $('.typeahead-'+num).typeahead({
      hint: true,
      minLength: 1,
      highlight: true,
      classNames: {
        menu : 'dropdown-menu tt-menu',
        suggestion: 'dropdown-item tt-suggestion',
      }
    },
    {
      name: 'items',
      source: availableItems
    });
    num += 1;
  });
  
  $("form[id='new-order']").submit(function(e){
    var isValid = true
    e.preventDefault();
    $("input[name='item[]']").each(function() {
      if ($(this).val() == "" || $.inArray($(this).val(), itemsArray) == -1) {
            isValid = false;
            $(this).addClass('is-invalid');
      } else {
          $(this).addClass('is-valid');
          $(this).removeClass('is-invalid');
      }
    })
    if(isValid) {
      this.submit();
    }  
  });
});