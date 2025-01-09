import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

export default class extends Controller {
  static targets = ["input", "preview", "imagesList"]
  static values = {
    url: String
  }

  connect() {
    this.inputTarget.addEventListener('change', this.handleFileSelect.bind(this))
    this.signedIds = new Set(
      this.imagesListTarget.value ? this.imagesListTarget.value.split(',') : []
    )
  }

  handleFileSelect(event) {
    Array.from(event.target.files).forEach(file => {
      this.uploadFile(file)
    })
  }

  uploadFile(file) {
    const preview = this.createPreview(file)
    const upload = new DirectUpload(file, this.urlValue, {
      directUploadWillStoreFileWithXHR: (request) => {
        request.upload.addEventListener("progress", event => {
          const progress = event.loaded / event.total * 100
          preview.querySelector(".upload-progress").style.width = `${progress}%`
        })
      }
    })

    upload.create((error, blob) => {
      if (error) {
        preview.classList.add("border-red-500")
      } else {
        this.signedIds.add(blob.signed_id)
        this.updateImagesList()
        
        preview.classList.add("border-green-500")
        preview.querySelector(".upload-progress").classList.add("bg-green-500")
        preview.dataset.activityImagesImageId = blob.signed_id
        this.addRemoveButton(preview)
      }
    })
  }

  removeImage(event) {
    const container = event.target.closest("[data-activity-images-image-id]")
    const imageId = container.dataset.activityImagesImageId
    
    this.signedIds.delete(imageId)
    this.updateImagesList()
    container.remove()
  }

  updateImagesList() {
    this.imagesListTarget.value = Array.from(this.signedIds).join(',')
  }

  createPreview(file) {
    const preview = document.createElement('div')
    preview.className = 'relative group border rounded-lg overflow-hidden'
    
    const img = document.createElement('img')
    img.className = 'w-full h-24 object-cover'
    
    const progress = document.createElement('div')
    progress.className = 'absolute bottom-0 left-0 right-0 h-1 bg-blue-500 upload-progress'
    progress.style.width = '0%'
    
    const reader = new FileReader()
    reader.onload = (e) => {
      img.src = e.target.result
    }
    reader.readAsDataURL(file)
    
    preview.appendChild(img)
    preview.appendChild(progress)
    this.previewTarget.appendChild(preview)
    
    return preview
  }

  addRemoveButton(preview) {
    const overlay = document.createElement('div')
    overlay.className = 'absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-black/50'
    
    const button = document.createElement('button')
    button.type = 'button'
    button.className = 'text-white bg-red-500 rounded-full p-1.5 hover:bg-red-600'
    button.dataset.action = 'activity-images#removeImage'
    button.innerHTML = `
      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
      </svg>
    `
    
    overlay.appendChild(button)
    preview.appendChild(overlay)
  }
} 