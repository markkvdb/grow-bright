import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image"]

  connect() {
    // Close modal when clicking outside
    this.modalTarget.addEventListener('click', (e) => {
      if (e.target === this.modalTarget) {
        this.close()
      }
    })

    // Close modal when pressing escape
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        this.close()
      }
    })
  }

  open(event) {
    event.preventDefault()
    const imageUrl = event.currentTarget.getAttribute('href')
    this.imageTarget.src = imageUrl
    this.modalTarget.classList.remove('hidden')
    document.body.classList.add('overflow-hidden')
  }

  close() {
    this.modalTarget.classList.add('hidden')
    document.body.classList.remove('overflow-hidden')
  }
} 