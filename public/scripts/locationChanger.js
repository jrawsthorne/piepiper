$(function (){
  $('#locationChanger').on("change", function() {
    document.querySelector("main").style.opacity = "0.5";
    document.querySelector("body").classList.add("spinner");
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
    document.querySelector("main").style.opacity = "0.5";
    document.querySelector("body").classList.add("spinner");
    const city = $(this).val()
    fetch('/get-location', {
      credentials: "same-origin",
      method: 'POST',
      body: JSON.stringify({city}),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then(() => {
      setTimeout(() => {
        document.querySelector("main").style.opacity = "1";
        document.querySelector("body").classList.remove("spinner");
      }, 500)
    })
  })
})