var markers = [];
var map;
$(function(){
  $('body').css('background-color', '#E6E4E4');

  $(".view-station").click(function(){
    var id = $('#selected_station').val();
    $.get('/map/' + id);
    removeFromMap(markers);
  });
});


function populateInfoWindow(marker, infowindow){
  if(infowindow.marker != marker){
    infowindow.marker = marker;
    infowindow.setContent('<div>' + marker.title + '<div>');
    infowindow.open(map, marker);
    infowindow.addListener('closeclick', function(){
      infowindow.marker = null ;
    });
  }
}

function removeFromMap(markers){
  for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
  }
}
