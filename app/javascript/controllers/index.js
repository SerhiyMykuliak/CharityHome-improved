// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import MenuToggleController from "./menu_toggle_controller"
application.register("menu-toggle", MenuToggleController)

import CausesProgressBarController from "./causes_progress_bar"
application.register("progress-bar", CausesProgressBarController)

