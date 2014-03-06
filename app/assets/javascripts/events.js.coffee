# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  SecretMeeting.EventForm = (->

    map = null
    marker = null
    initialized = false

    initialize = ->
      console.log("initializing map and iniital marker")
      myLatlng = new google.maps.LatLng(47.61,-122.200);
      mapOptions = {
        zoom: 16,
        center: myLatlng
      }
      marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
      });
      map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
      initialized = true

    parseGeocodeData = (data) ->
      console.log(data)
      if data.status == 'OK'
        console.log(data.results[0])

        # set marker and center map
        location = data.results[0].geometry.location
        marker.setPosition(location)
        marker.setMap(map)
        map.setCenter(location)

        # show map if hidden
        $("#map-container").show()

    geocode = (address, zipCode)->
      console.log("mapping value of #{address} #{zipCode}")
      $.getJSON("https://maps.googleapis.com/maps/api/geocode/json?address=#{address} #{zipCode}&sensor=false", parseGeocodeData)

    $('#event_address').on 'blur', ->
      if not initialized
        initialize()

      address = $(this).val()
      zipCode = $("#event_zip_code").val()
      geocode(address, zipCode)

   # google.maps.event.addDomListener(window, 'load', initialize);
  )()