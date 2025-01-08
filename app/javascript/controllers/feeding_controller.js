import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["type", "volumeFields", "weightFields", "sideField"]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const feedingType = this.typeTarget.value

    // Hide all fields first
    this.volumeFieldsTarget.classList.add("hidden")
    this.weightFieldsTarget.classList.add("hidden")
    this.sideFieldTarget.classList.add("hidden")

    // Show relevant fields based on feeding type
    switch(feedingType) {
      case "bottle":
        this.volumeFieldsTarget.classList.remove("hidden")
        break
      case "solid":
        this.weightFieldsTarget.classList.remove("hidden")
        break
      case "breast":
        this.sideFieldTarget.classList.remove("hidden")
        break
    }
  }
} 