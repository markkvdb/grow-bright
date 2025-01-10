import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
  }

  switchChild(event) {
    window.location.href = event.target.value
  }
} 