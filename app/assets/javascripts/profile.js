//sets google zoom and places markers
function placeMakers(data) {
  markers = handler.addMarkers(data);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
}

// calls placeMakers function
function showLocations(data) {
  placeMakers(data);
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

function loadAndCreateProfileGmap() {
  // Only load map data if we have a map on the page
  if ($('#profileMap').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var userId = $('#profileMap').attr('data-user-id');
// '/map_location was added and the route was created'
    $.ajax({
      dataType: 'json',
      url: '/profile/' + userId + '/profile_map_locations',
      method: 'GET',
      data: '',
      success: function(data) {
        createGmap(data, 'profileMap');
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

// Create the map when the page loads the first time
$(document).on('ready', loadAndCreateProfileGmap);
// Create the map when the contents is loaded using turbolinks
// To be 'turbolinks:load' in Rails 5
$(document).on('page:load', loadAndCreateProfileGmap);
