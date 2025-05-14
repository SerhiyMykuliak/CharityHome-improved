import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["flashBox"]

  connect(){
    setTimeout(() => {
      this.flashBoxTarget.remove()
    }, 4000);
  }
}

