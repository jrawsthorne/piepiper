$(function (){
  $('#locationChanger').on("change", function() {
    const city = $(this).val()
    fetch('/get-location', {
      credentials: "same-origin",
      method: 'POST',
      body: JSON.stringify({city}),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then(() => window.location.href = "?location="+city)
  })
  $('#locationChangerReload').on("change", function() {
    const city = $(this).val()
    fetch('/get-location', {
      credentials: "same-origin",
      method: 'POST',
      body: JSON.stringify({city}),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
  })
})