$(function (){
  $("form[class='new-order']").submit(function(e){
    //this happens if form is submitted
    //prevent the default behavior of a form (it should do nothing in our case)
    e.preventDefault();
    
    const id = $(this)[0].id;
    const tweet_id = id.replace('new-order-','');
    
    var isValid = true;
    
    $("form[id='"+id+"'] input[name*='item']").each(function() {
            if ($(this).val() == "" || $.inArray($(this).val(), itemsArray) == -1) {
                  isValid = false;
                  $(this).addClass('is-invalid');
                  $(this).parent().children().last().html('Invalid item');
            } else {
                $(this).addClass('is-valid');
                $(this).removeClass('is-invalid');
            }
      });
      
    var result = []
      
    if(isValid) {
      $("form[id='"+id+"'] input[name*='item']").each(function() {
        result.push($(this).val());
      });
      var dataToSend = {'items': result, 'tweet_id': tweet_id};
    }

    if(isValid) {
        //send an ajax request to our action
      $.ajax({
        url: "/new-order",
        data: dataToSend,
        //the type of data we are expecting back from server (json)
        dataType: "json",
        type: "POST",
        success: function(data) {
          //if our ajax request is successful
          $("a[id='tweet-to-sort-"+tweet_id+"']").remove();
          $("#tweet-"+tweet_id).remove();
          if(!($("#nav-tabContent").children().length)) {
            $("#order-forms").remove();
          } else {
            $("#tweets a").first().tab('show');
          }
          
          $("#created-orders").append("<li class='list-group-item'></li>");
        
          var listOfItems = "";
        
          $.each(data.items, function(i, item) {
            listOfItems += item;
            if(i+1 < data.items.length) {
              listOfItems += ", "
            }
          });
          
          $('#created-orders').children().last().html("Order of "+listOfItems+" for "+data.username);
        }
      });
    }
  });
  var itemsArray = [
      "Pork pie",
      "Lamb shank pie",
      "Lemon Meringue pie",
      "Mushy peas",
      "Mash",
      "Coke",
      "Chocolate milkshake",
      "Cider"
    ];
    
    var availableItems = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: itemsArray
    });
    
    $("button.remove").click(function(e){
      const id = $(this).attr("data-id");
      const form_id = "#new-order-"+id;
      $(form_id+" div:first-child span").last().remove();
    });
    
    var num = 1;
    
    $("button.add").click(function(e){
      const id = $(this).attr("data-id");
      $("form[id='new-order-"+id+"'] .menu-inputs").append('<input type="text" class="form-control search-menu-items typeahead-'+num+'" name="item-'+num+'" placeholder="Search for an item..." required>');
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
      $('.typeahead-'+num).parent().append('<div class="invalid-feedback"></div>');
      num += 1;
    });
    
});