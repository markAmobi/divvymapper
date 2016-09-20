var map;
function initMap(){
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 41.8725614, lng: -87.6245382},
    zoom: 13,
    mapTypeControl: false
  });
}
