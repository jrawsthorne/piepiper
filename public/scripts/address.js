$(function () {
    $('#address_checker').hide();
 });
$('.modal-opener-btn').one('click', function(){
  initialize();
  });
function initialize() {
  initMap();
  initAutocomplete();
  initCircle();
}

  var map, marker;
  function initMap() {

      map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 53.383299, lng: -1.482869},
        zoom: 13
      });
    }

  function initCircle() {
  // Define the circle
circle = new google.maps.Circle({
   center: new google.maps.LatLng( 53.383299, -1.482869),
    map: map,
    clickable: false,
    // metres
    radius: 3218.69,
    fillColor: '#FF0000',
    fillOpacity: .1,
    strokeColor: '#FF0000',
    strokeOpacity: .4,
    strokeWeight: .2
    });
  }


  var placeSearch, autocomplete;
  var componentForm = {
    postal_code: 'short_name',
    street_number: 'short_name',
    route: 'long_name',

  };

  function initAutocomplete() {
    // Create the autocomplete object, restricting the search to geographical
    // location types.
    autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */
      (document.getElementById('autocomplete')), {
        types: ['geocode']
      });

    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
    autocomplete.addListener('place_changed', fillInAddress);
  }

  function fillInAddress() {
    // Get the place details from the autocomplete object.
    var place = autocomplete.getPlace();
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(13);
    }
    if (!marker) {
      marker = new google.maps.Marker;({
        map: map,
        anchorPoint: new google.maps.Point(0, -29)
      });
    } else marker.setMap(null);
    marker.setOptions({
      position: place.geometry.location,
      map: map,
    })
  if (!circle.getBounds().contains(marker.getPosition())) {
      $("#address_checker").show();
  }  else {
    $('#save').removeAttr('disabled');
    $("#address_checker").hide();
  }

     for (var component in componentForm) {
       document.getElementById(component).value = '';
       document.getElementById(component).disabled = false;
     }

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
        var val = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = val;
      }
    }
  }

  // Bias the autocomplete object to the user's geographical location,
  // as supplied by the browser's 'navigator.geolocation' object.
  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }
  }

  $("#map_modal").on("shown.bs.modal", function () {
    google.maps.event.trigger(map, "resize");
});
