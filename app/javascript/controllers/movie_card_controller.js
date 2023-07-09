import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-card"
export default class extends Controller {
  static targets = ["overview"]

  connect() {
  }

  more() {
    this.overviewTarget.classList.toggle("overview-open")
    console.log("hello")
  }
}
