import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    goalAmount: Number,
    collectedAmount: Number
  }

  static targets = ["percentage", "progress"]

  connect(){
    
    document.addEventListener("turbo:load", () => {
      const targetPercentage = this.calculateProgress()
      this.progressTarget.style.width = `0%`
      this.percentageTarget.style.left = `-15px`

      requestAnimationFrame(() => {
        this.progressTarget.style.transition = 'width 2s ease-out'
        this.progressTarget.style.width = `${targetPercentage}%`
    
        this.percentageTarget.innerText = `${targetPercentage}%`

        this.percentageTarget.style.transition = 'left 2s ease-out'
        this.percentageTarget.style.left = `calc(${targetPercentage}% - 17px)`

      })
    })
  }

  calculateProgress() {
    if (this.goalAmountValue === 0) return 0
    return Math.min(100, ((this.collectedAmountValue / this.goalAmountValue) * 100).toFixed(0))
  }
}

