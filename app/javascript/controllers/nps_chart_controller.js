import {
  Controller
} from "@hotwired/stimulus"
import "chart.js"

export default class extends Controller {
  static values = {
    data: Object
  }

  connect() {
    const labels = Object.keys(this.dataValue)
    const promoters = labels.map(c => this.dataValue[c].promoters)
    const passives = labels.map(c => this.dataValue[c].passives)
    const detractors = labels.map(c => this.dataValue[c].detractors)

    new Chart(this.element, {
      type: "bar",
      data: {
        labels: labels,
        datasets: [{
            label: "Promoters",
            data: promoters,
            backgroundColor: "#22c55e" // green
          },
          {
            label: "Passives",
            data: passives,
            backgroundColor: "#facc15" // yellow
          },
          {
            label: "Detractors",
            data: detractors,
            backgroundColor: "#ef4444" // red
          }
        ]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "top"
          },
          title: {
            display: true,
            text: "Daily NPS Breakdown per Company"
          }
        }
      }
    })
  }
}