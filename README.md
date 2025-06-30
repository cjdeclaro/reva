# Reva: Guest Review Explorer

<img width="1569" alt="image" src="https://github.com/user-attachments/assets/cbac65aa-9e00-48b2-9df1-dcdd9ef9f733" />
<img width="1680" alt="image" src="https://github.com/user-attachments/assets/bc91cd3d-a6c9-4885-9f99-c529a814a5f2" />
<img width="1524" alt="image" src="https://github.com/user-attachments/assets/bc81e62b-bfaa-4906-b24a-2e847e60c1c6" />

Reva helps property-management companies track, explore, and act on guest review data from multiple platforms like Airbnb, Booking, and Google.
It includes a CSV importer, an interactive browser-based review explorer, and a daily Net Promoter Score (NPS) tracker.

---

## 🚀 Setup

### Install

```bash
git clone https://github.com/yourname/reva.git
cd reva

bundle install
rails db:create db:migrate
```

### TailwindCSS

Tailwind is installed using `tailwindcss-rails`.

```bash
rails tailwindcss:build
```

### Sidekiq

Sidekiq is used for background jobs (no Redis config required in repo):

```bash
bundle exec sidekiq
```

In development, you must have Redis running:

```bash
brew install redis
brew services start redis
```

---

## 📄 CSV Sample Line & Mapping

A typical line in your CSV:

```csv
company_name,channel,rating,date,title,description
CJ Co,Airbnb,5,2025-06-30,Amazing stay,Very clean and quiet
```

### Mapped to `Review` model:

| CSV Column    | Review Attribute                  |
| ------------- | --------------------------------- |
| company\_name | company\_name                     |
| channel       | channel                           |
| rating        | rating (integer 1–5)              |
| date          | review\_date (parsed as ISO date) |
| title         | title                             |
| description   | description                       |

---

## 🛠 Usage

### Run the Importer

You can import the CSV with:

```bash
rake reviews:import
```

CSV located in /public

This task is **idempotent**: you can re-run it without creating duplicates. It uses a combination of company, channel, rating, date, and title for uniqueness.

---

### Explore Reviews (UI)

Visit [`http://localhost:3000`](http://localhost:3000) for the landing page.

Click **"See Reviews"** to open the explorer (`/reviews`), where you can:

* Filter by ratings, channel, company
* Search by full-text in description
* Select date ranges
* See paginated results (Pagy)
* View filters persist in the URL
* Instant updates via Hotwire (Turbo + Stimulus)

---

### Run the NPS Background Job

NPS (Net Promoter Score) is calculated daily

You can run it manually:
```bash
rails c
NpsRollupJob.perform_now
```

Each company gets a score breakdown (promoters, passives, detractors) based on yesterday’s reviews:

* **Promoters**: 5⭐
* **Passives**: 4⭐
* **Detractors**: 1–3⭐

Results are displayed as a chart on the reviews page.

---

## 📊 Tests

Run all tests:

```bash
rails test
```

---

## 🤖 AI Assistance

To be more productive, I used AI tools to help scaffold the initial structure of the Rails app, generate boilerplate code, and draft early ideas for the review explorer. This allowed me to focus my time and effort on building reliable, real-world business logic and ensuring clean architecture.

I focused my efforts on refining the business logic, ensuring correct NPS classification, review filtering, and idempotent CSV import behavior. I also focused on UI usability and practical constraints for property managers.

---

## 🤔 Design Decisions & Trade-offs

### 1. **Idempotent Importer**

* The import task uses `find_or_initialize_by` with multiple identifying fields to avoid duplication.
* This assumes each review is uniquely identifiable by a combo of `company_name`, `channel`, `rating`, `review_date`, and `title`.

### 2. **Daily NPS Calculation**

* We use a background job (`NpsRollupJob`) to avoid on-the-fly calculations, improving UI speed.
* Raw counts (promoters, passives, detractors) are stored to support multiple visualizations.

### 3. **Hotwire UI Design**

* Filters are inside a sticky sidebar for better UX.
* Filtering does not require full-page reload thanks to Turbo Frames.
* Query parameters are persisted in the URL to allow shareable views.

### 4. **Full-text Search**

* We use `ILIKE` queries for simplicity.
* In production, switching to full-text search with PostgreSQL or ElasticSearch would scale better.

---

## 🔮 Future Work

* ✅ Full-text indexing via PostgreSQL `tsvector`
* 📊 Enhanced NPS visualizations (e.g., trends over time)
* 💡 Test coverage for importer edge cases
* 📅 Optional CSV upload via UI
* 📱 Responsive mobile design improvements
* 🔐 Basic auth or login for multi-tenant support

---

## 📁 Directory Highlights

* `app/models/review.rb`: core model with filters
* `lib/tasks/reviews.rake`: CSV import logic
* `app/javascript/controllers/nps_chart_controller.js`: renders Chart.js bar graph

---

## 👋 About

Built with ❤️ using Vanilla Rails, Turbo, Stimulus, TailwindCSS, and Pagy.
