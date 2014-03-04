# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
#  new Geocoder($('.geolocate'), $('#locationSearchText'));
  SecretMeeting.Geocoder = (->
    populateSearchText = (locationText) ->
      $("#locationSearchText").val(locationText)
      localStorage['current_location'] = locationText if Modernizr.localstorage

    parseGeoData = (data) ->
      console.log(data)
      if data.status == 'OK' and data.results
        address_components = data.results[0].address_components

        address_parts = {}
        address_components.map (component) -> address_parts[component.types[0]] = component.short_name
        console.log(address_parts)

        if address_parts.locality and address_parts.administrative_area_level_1
          populateSearchText("#{address_parts.locality}, #{address_parts.administrative_area_level_1}")
        else if address_parts.postal_code
          populateSearchText("#{address_parts.postal_code}")

    reverseGeocode = (position) ->
      console.log(position.coords.latitude + " " + position.coords.longitude)
      $.getJSON("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{position.coords.latitude},#{position.coords.longitude}&sensor=true", parseGeoData)

    if Modernizr.geolocation
      $("#locationSearchText").val(localStorage['current_location']) if Modernizr.localstorage and localStorage['current_location']
      $(".geolocate").click ->
        navigator.geolocation.getCurrentPosition(reverseGeocode)
  )()
