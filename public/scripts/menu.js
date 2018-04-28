$(function (){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(getCity, getLocation, {enableHighAccuracy: true, timeout: 1000, maximumAge: 0});
  } else {
    getLocation()
  }
  // Get the latitude and the longitude;
  function getCity(position) {
    const latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    new google.maps.Geocoder().geocode({'latLng': latlng}, (results, status) => {
      if (status == google.maps.GeocoderStatus.OK) {
        const city = results.find(result => result.types[0] === "locality").address_components[0].long_name
        getLocation(city)
      }
    });
  }
  
  function getLocation(city) {
    fetch('/get-location', {
      credentials: "same-origin",
      method: 'POST',
      body: JSON.stringify({city}),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then(() => window.location.href = "/")
  }
  
})