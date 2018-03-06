$(function (){
  var itemPrices = []
  var itemsArray = []
  var availableItems = []
  $.ajax({
    url: "/api/get-items",
    dataType: "json",
    type: "GET",
    success: function(data) {
      itemPrices = data
      for (var name in itemPrices) {
      	itemsArray.push(name)
      }
      availableItems = new Bloodhound({
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
    }
  });

  function inputChange(input) {
    var formrow = $(input).closest(".form-row")
    var iteminput = formrow.find("input[name='item[]']")
    if(iteminput.val() in itemPrices) {
      value = iteminput.val()
      price = itemPrices[value]
      quantity = formrow.find("input[name='quantity[]']").val()
      formrow.find(".price").val("£"+(price*quantity).toFixed(2))
    } else {
      $(input).closest(".form-row").find(".price").val("£0.00")
    }
    totalOrderPirceChange()
    validateItems()
    if(isValid) {
      $("button#submit").removeAttr("disabled");
    } else {
      $("#submit").attr("disabled", true);
    }
  }

  function totalOrderPirceChange() {
    total = 0
    $("#menu-items").find(".price").each(function() {
      total += (parseFloat($(this).val().replace("£","")))
    })
    $("#total-order-price").html(("Total order price: £"+total.toFixed(2)))
  }

  $("#menu-items").on('keyup keydown change click', "input, .dropdown-item", function() {
    inputChange(this)
  })

  $("#menu-items").on('click', ".remove-item", function() {
    $(this).closest(".list-group-item").remove()
    totalOrderPirceChange()
  })

  var num = 0;
  $("#add button").click(function(){
    $('<li class="list-group-item"><div class="form-row"><div class="form-group mb-0 col-sm-2"><input class="form-control disabled price" disabled type="text" value="£0.00" placeholder="£0.00"></div><div class="form-group mb-0 col-md-7"><input placeholder="Search for an item..." required name="item[]" class="form-control typeahead-'+num+'" type="text"></div><div class="form-group mb-0 col-md-2"><input name="quantity[]" class="form-control" type="number" min="1" value="1" required></div><div class="form-group mb-0 col-sm-1"><button type="button" class="remove-item btn btn-danger btn-block">-</button></div></div></li>').insertBefore($(this).parent());
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

  function validateItems() {
    isValid = true
    $("input[name='item[]']").each(function() {
      if ($(this).val() == "" || $.inArray($(this).val(), itemsArray) == -1) {
            $(this).addClass('is-invalid');
            isValid = false
      } else {
          $(this).addClass('is-valid');
          $(this).removeClass('is-invalid');
      }
    })
    $("input[name='quantity[]']").each(function() {
      if ($(this).val() == "" || parseInt($(this).val()) <= 0 || isNaN($(this).val())) {
            isValid = false
            $(this).addClass('is-invalid');
      } else {
          $(this).addClass('is-valid');
          $(this).removeClass('is-invalid');
      }
    })
    return isValid
  }

  $("form[id='order']").submit(function(e){
    e.preventDefault();
    if(validateItems()) {
      this.submit();
    }
  });
});
