import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "entries", "addButton", "select"]
  static values = {
    availableCaregivers: Array
  }

  connect() {
    // Initialize available caregivers from data attribute
    this.updateAvailableCaregivers()
  }

  add(event) {
    event.preventDefault()
    
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.entriesTarget.insertAdjacentHTML('beforeend', content)

    // Get the newly added select
    const newSelect = this.entriesTarget.lastElementChild.querySelector('select[name*="[caregiver_id]"]')
    if (newSelect) {
      this.selectTargets.push(newSelect)
    }
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest('[data-new-record]')
    const select = wrapper.querySelector('select[name*="[caregiver_id]"]')
    
    if (wrapper.dataset.newRecord === "true") {
      // For new records, just remove the element
      if (select) {
        this.addCaregiverToAvailable(select.value)
      }
      wrapper.remove()
    } else {
      // For existing records, hide and mark for destruction
      if (select) {
        this.addCaregiverToAvailable(select.value)
      }
      wrapper.style.display = 'none'
      wrapper.innerHTML += '<input type="hidden" name="_destroy" value="1" />'
    }

    this.updateSelects()
  }

  caregiverSelected(event) {
    const select = event.target
    const previousValue = select.dataset.previousValue
    
    // Add the previously selected value back to available (if it exists)
    if (previousValue) {
      this.addCaregiverToAvailable(previousValue)
    }
    
    // Remove the newly selected value from available
    this.removeCaregiverFromAvailable(select.value)
    
    // Store the current value for next change
    select.dataset.previousValue = select.value
    
    this.updateSelects()
  }

  // Private methods

  addCaregiverToAvailable(caregiverId) {
    if (!caregiverId) return
    
    const caregiver = this.findCaregiver(caregiverId)
    if (caregiver && !this.availableCaregiversValue.find(c => c.id === caregiver.id)) {
      this.availableCaregiversValue = [...this.availableCaregiversValue, caregiver]
    }
  }

  removeCaregiverFromAvailable(caregiverId) {
    if (!caregiverId) return
    
    this.availableCaregiversValue = this.availableCaregiversValue
      .filter(c => c.id !== parseInt(caregiverId))
  }

  updateSelects() {
    // Update all selects with current available options
    this.selectTargets.forEach(select => {
      const currentValue = select.value
      
      // Keep only the current value and add available caregivers
      const options = this.availableCaregiversValue.map(caregiver => 
        `<option value="${caregiver.id}">${caregiver.name}</option>`
      )
      
      if (currentValue) {
        const selectedOption = select.querySelector(`option[value="${currentValue}"]`)
        options.unshift(selectedOption.outerHTML)
      }
      
      select.innerHTML = `<option value="">Select a caregiver</option>${options.join('')}`
      select.value = currentValue
    })

    // Show/hide add button based on available caregivers
    if (this.hasAddButtonTarget) {
      this.addButtonTarget.style.display = 
        this.availableCaregiversValue.length > 0 ? 'block' : 'none'
    }
  }

  findCaregiver(id) {
    const parsedId = parseInt(id)
    return this.availableCaregiversValue.find(c => c.id === parsedId)
  }
} 