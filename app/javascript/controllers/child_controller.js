import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "entries", "addButton"]

  add(event) {
    event.preventDefault()
    
    const content = this.templateContent()
    this.entriesTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.preventDefault()

    const wrapper = event.target.closest('[data-new-record]')
    
    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'
      wrapper.querySelector('input[name*="_destroy"]').value = "true"
    }
  }

  // Private methods

  templateContent() {
    return this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
  }
} 