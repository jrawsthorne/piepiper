var map, map2;

function initialize() {
    // create the maps
    var myOptionsSheffield = {
        zoom: 12.3,
        center: new google.maps.LatLng(53.383299, -1.482869),
        scrollwheel : false,
        gestureHandling : 'none',
        zoomControl : false,
          styles:[
      {
          "featureType": "administrative",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "off"
              }
          ]
      },
      {
          "featureType": "landscape",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              },
              {
                  "hue": "#0066ff"
              },
              {
                  "saturation": 74
              },
              {
                  "lightness": 100
              }
          ]
      },
      {
          "featureType": "poi",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              }
          ]
      },
      {
          "featureType": "road",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              }
          ]
      },
      {
          "featureType": "road.highway",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "off"
              },
              {
                  "weight": 0.6
              },
              {
                  "saturation": -85
              },
              {
                  "lightness": 61
              }
          ]
      },
      {
          "featureType": "road.highway",
          "elementType": "geometry",
          "stylers": [
              {
                  "visibility": "on"
              }
          ]
      },
      {
          "featureType": "road.arterial",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "off"
              }
          ]
      },
      {
          "featureType": "road.local",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "on"
              }
          ]
      },
      {
          "featureType": "transit",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              }
          ]
      },
      {
          "featureType": "water",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              },
              {
                  "color": "#5f94ff"
              },
              {
                  "lightness": 26
              },
              {
                  "gamma": 5.86
              }
          ]
      }
  ]

}


    var myOptionsLeeds = {
        zoom: 12.3,
        center: new google.maps.LatLng(53.7942, -1.5476),
        scrollwheel : false,
        gestureHandling : 'none',
        zoomControl : false,
        styles:
        [
      {
          "featureType": "administrative",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "off"
              }
          ]
      },
      {
          "featureType": "landscape",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              },
              {
                  "hue": "#0066ff"
              },
              {
                  "saturation": 74
              },
              {
                  "lightness": 100
              }
          ]
      },
      {
          "featureType": "poi",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              }
          ]
      },
      {
          "featureType": "road",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              }
          ]
      },
      {
          "featureType": "road.highway",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "off"
              },
              {
                  "weight": 0.6
              },
              {
                  "saturation": -85
              },
              {
                  "lightness": 61
              }
          ]
      },
      {
          "featureType": "road.highway",
          "elementType": "geometry",
          "stylers": [
              {
                  "visibility": "on"
              }
          ]
      },
      {
          "featureType": "road.arterial",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "off"
              }
          ]
      },
      {
          "featureType": "road.local",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "on"
              }
          ]
      },
      {
          "featureType": "transit",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              }
          ]
      },
      {
          "featureType": "water",
          "elementType": "all",
          "stylers": [
              {
                  "visibility": "simplified"
              },
              {
                  "color": "#5f94ff"
              },
              {
                  "lightness": 26
              },
              {
                  "gamma": 5.86
              }
          ]
      }
  ]


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
        var marker = new google.maps.Marker({
        position: new google.maps.LatLng( 53.383299, -1.482869),
        map: map
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
        var marker = new google.maps.Marker({
        position: new google.maps.LatLng(53.7942, -1.5476),
        map: map2
      });
    }
