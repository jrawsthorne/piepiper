var map, map2;

function initialize() {
    // create the maps
    var myOptionsSheffield = {
        zoom: 12,
        center: new google.maps.LatLng(53.383299, -1.482869),
        scrollwheel : false,
        gestureHandling : 'none',
        zoomControl : false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    var myOptionsLeeds = {
        zoom: 12,
        center: new google.maps.LatLng(53.7942, -1.5476),
        scrollwheel : false,
        gestureHandling : 'none',
        zoomControl : false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("map_Sheffield"), myOptionsSheffield);
    map2 = new google.maps.Map(document.getElementById("map_Leeds"), myOptionsLeeds);

    initCircleShef();
    initCircleLeeds();
    }

    function initCircleShef() {
    // Define the circle
      circleShef = new google.maps.Circle({
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

    function initCircleLeeds() {
    // Define the circle
      circleLeeds = new google.maps.Circle({
      center: new google.maps.LatLng(53.7942, -1.5476),
      map: map2,
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
