import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image", "currentImage"]
  static values = {
    images: Array
  }

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
      } else if (e.key === 'ArrowLeft') {
        this.previous()
      } else if (e.key === 'ArrowRight') {
        this.next()
      }
    })
  }

  open(event) {
    event.preventDefault()
    const clickedImage = event.currentTarget
    this.currentIndex = parseInt(clickedImage.dataset.index)
    this.updateImage()
    this.modalTarget.classList.remove('hidden')
    document.body.classList.add('overflow-hidden')
  }

  close() {
    this.modalTarget.classList.add('hidden')
    document.body.classList.remove('overflow-hidden')
  }

  previous() {
    if (this.currentIndex > 0) {
      this.currentIndex--
      this.updateImage()
    }
  }

  next() {
    if (this.currentIndex < this.imagesValue.length - 1) {
      this.currentIndex++
      this.updateImage()
    }
  }

  updateImage() {
    const imageUrl = this.imagesValue[this.currentIndex]
    this.imageTarget.src = imageUrl
    this.currentImageTarget.textContent = `${this.currentIndex + 1} / ${this.imagesValue.length}`
  }
} 