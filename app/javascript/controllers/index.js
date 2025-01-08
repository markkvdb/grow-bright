// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

eagerLoadControllersFrom("controllers", application)
