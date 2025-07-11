# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.js"
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
pin "nps_chart_controller", to: "controllers/nps_chart_controller.js"
pin "filter_controller", to: "controllers/filter_controller.js"
