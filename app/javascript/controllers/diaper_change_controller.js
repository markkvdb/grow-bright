import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["type", "solidFields"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const changeType = this.typeTarget.value
    
    // Hide solid fields by default
    this.solidFieldsTarget.classList.add("hidden")
    
    // Show solid fields for solid or both types
    if (["solid", "both"].includes(changeType)) {
      this.solidFieldsTarget.classList.remove("hidden")
    }
  }
} 