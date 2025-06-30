import { Application } from "@hotwired/stimulus"
import NpsChartController from "nps_chart_controller"

const application = Application.start()
application.register("nps-chart", NpsChartController)

application.debug = false
window.Stimulus = application

export { application }
