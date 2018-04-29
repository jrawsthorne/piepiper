$("form[id='login']").submit(function(e){
  e.preventDefault();
  const form = this
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(getCity, submit, {enableHighAccuracy: true, timeout: 5000, maximumAge: 0});
  } else {
    form.submit()
  }
  // Get the latitude and the longitude;
  function getCity(position) {
    const latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    new google.maps.Geocoder().geocode({'latLng': latlng}, (results, status) => {
      if (status == google.maps.GeocoderStatus.OK) {
        if(results.find(result => result.types[0] === "locality")) {
          const city = results.find(result => result.types[0] === "locality").address_components[0].long_name
          fetch('/set-location', {
            credentials: "same-origin",
            method: 'POST',
            body: JSON.stringify({city}),
            headers: new Headers({
              'Content-Type': 'application/json'
            })
          })
          .then(() => form.submit())
        } else {
          form.submit();
        }
      } else {
        form.submit();
      }
    });
  }
  
  function submit() {
    form.submit()
  }
});