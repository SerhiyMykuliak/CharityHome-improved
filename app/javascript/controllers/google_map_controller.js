import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    lat: Number,
    lng: Number
  }

  connect() {
    this.initMap()
  }

  initMap() {
    const location = { lat: this.latValue, lng: this.lngValue }

    const map = new google.maps.Map(this.element, {
      center: location,
      zoom: 15,
      mapTypeControl: true,
      streetViewControl: false,
      scrollwheel: true,  
      draggable: true, 
      maxZoom: 20,                          
      minZoom: 10,
      mapId: "Map_id"
    })

    new google.maps.marker.AdvancedMarkerElement({
      map,
      position: location,
      title: "Our Company Is Here!"
    })
  }
}
