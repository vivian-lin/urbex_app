//sets google zoom and places markers
function placeMakers(data) {
  markers = handler.addMarkers(data);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
  handler.getMap().setZoom(12);
}
// commented out the YOU position
// calls placeMakers function
function showLocations(data) {
  if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
      // Add our position to the collection of markers
      // data[data.length] = {
      //   lat: position.coords.latitude,
      //   lng: position.coords.longitude,
      //   infowindow: "You!",  
      // };
      placeMakers(data);
    });
  } else {
      alert("Geolocation is not available.");
      placeMakers(data)
  }
}
// create google map data
function createGmap(data, selector) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: selector}
    },
    function() {
      showLocations(data);
    }
  );
};

function loadAndCreateGmap() {
  // Only load map data if we have a map on the page
  if ($('#adventureMap').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var adventureId = $('#adventureMap').attr('data-adventure-id');
// '/map_location was added and the route was created'
    $.ajax({
      dataType: 'json',
      url: '/adventures/' + adventureId + '/map_location',
      method: 'GET',
      data: '',
      success: function(data) {
        createGmap(data, 'adventureMap');
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};
// Creates the json object for all locations on the adventure index
function loadAndCreateGmapForAllLocations() {
  // Only load map data if we have a map on the page
  if ($('#allAdventuresMap').length > 0) {
// '/map_location was added and the route was created'
    $.ajax({
      dataType: 'json',
      url: '/adventures/all_map_locations',
      method: 'GET',
      data: '',
      success: function(data) {
        createGmap(data, 'allAdventuresMap');
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};
// Create the map on the locations index page
$(document).on('ready',
  loadAndCreateGmapForAllLocations
);

// Create the map when the page loads the first time
$(document).on('ready', loadAndCreateGmap);
// Create the map when the contents is loaded using turbolinks
// To be 'turbolinks:load' in Rails 5
$(document).on('page:load', loadAndCreateGmap);
