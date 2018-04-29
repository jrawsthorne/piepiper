$(function (){
  $("#submit_order").attr("disabled", true);
  var itemPrices = []
  var itemsArray = []
  var availableItems = []
  const userLocation = $("#userLocation").val()
  $.ajax({
    url: "/api/get-items?location="+userLocation,
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
  }

  function totalOrderPirceChange() {
    total = 0
    $("#menu-items").find(".price").each(function() {
      total += (parseFloat($(this).val().replace("£","")))
    })

    $("#total-order-price").html(("Total order price: £"+calculateDiscount(total).toFixed(2)))

  }

  $("#menu-items").on('keyup keydown change click', "input, .dropdown-item", function() {
    inputChange(this)
  })
    
   $(".change_order_state").on('change', function() {
       console.log("Change")
    inputChange(this)
  })

  $("#menu-items").on('click', ".remove-item", function() {
    $(this).closest(".list-group-item").remove()
    totalOrderPirceChange();
    validateItems();
  })
  function calculateDiscount(order_price) {
    discount_percent = $("input[name='reward']:checked").data('discount')
    console.log(discount_percent)
    if(discount_percent) {
      if(discount_percent != 100 || null){
        return order_price - (order_price * discount_percent / 100)
      //the cheapest item is free
      } else if(discount_percent == 100){
        const prices = $(".price")
        const values = []
        
        for (index = 0; index < prices.length; ++index) {
          values.push(prices[index].value.replace("£",""))
        }

        const min_val = Math.min.apply(Math, values)
        return order_price - min_val

    }
  } else {
      return order_price
  }
  }
  $("input[name='reward']").on('click', function() {
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
    validateItems();
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
    if(isValid) {
      $("button#submit_order").removeAttr("disabled");
    } else {
      $("#submit_order").attr("disabled", true);
    }
    return isValid
  }

  $("form[id='order']").submit(function(e){
    e.preventDefault();
    if(validateItems()) {
      this.submit();
    }
  });
  
  $("#reply-send").click(function() {
    var in_reply_to = $(this).data("tweet")
    var user = $(this).data("user")
    var text = $("#message-text").val();
    var data = { 'tweet': text, 'user': user, 'in_reply_to': in_reply_to };
    fetch('/send-tweet', {
      credentials: "same-origin",
      method: 'POST',
      body: JSON.stringify(data),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then((response) => {
      response.json()
      .then((tweet) => {
        if(response.status !== 200) {
          alert(tweet.error)
        } else {
          $("#reply").modal('toggle');
          $("#message-text").val("");
          $('#tweets').append('<li class="list-group-item"><div class="d-flex w-100"><div class="profile-image mr-3"><img src="'+tweet.user.profile_image_url+'" /></div><div class="profile"><h5 class="mb-1">'+tweet.user.full_name+' <span>'+tweet.created_at+'</span></h5><p class="mb-1">'+tweet.tweet_text+'</p></div></div></li>')
        }
      })
      .catch((err) => console.error(err))
    }
  )
  .catch((err) => console.error(err))
});
  
var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var current_time = new Date()
$(".form_datetime").datetimepicker({
      format: "dd MM yyyy - hh:ii"
  });
  
  function minutes_with_leading_zeros(dt) { 
    return (dt.getMinutes() < 10 ? '0' : '') + dt.getMinutes();
  }
  
$(".form_datetime input").val(current_time.getDate() + " " + months[current_time.getMonth()] + " " + current_time.getFullYear() + " - " + current_time.getHours() + ":" + minutes_with_leading_zeros(current_time))
  
});