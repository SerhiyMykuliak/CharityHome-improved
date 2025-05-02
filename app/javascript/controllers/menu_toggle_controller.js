import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["menu"]

  toggle() {
    this.menuTarget.classList.toggle("right-0");
    this.menuTarget.classList.toggle("right-[-300px]");    
  }
}

