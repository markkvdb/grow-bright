import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleSubmit(event) {
    if (event.detail.success) {
      // Clear any file inputs
      this.element.querySelectorAll('input[type="file"]').forEach(input => {
        input.value = ''
      })
    }
  }
} 