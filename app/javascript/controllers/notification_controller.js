import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notification", "progress"]
  static values = {
    duration: { type: Number, default: 5000 }
  }

  connect() {
    // Start the progress bar animation
    requestAnimationFrame(() => {})

    // Automatically hide after duration
    this.timeout = setTimeout(() => {
      this.close()
    }, this.durationValue)
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  close() {
    this.notificationTarget.classList.add('opacity-0')
    setTimeout(() => {
      this.notificationTarget.remove()
    }, 300) // Match transition duration
  }
} 