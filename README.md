Perfect ✅ — a polished **README** can really impress reviewers because it shows clarity and professionalism.

Here’s a draft you can drop into your **GitHub README.md**:

---

# 🎬 Movie App 

A Flutter application showcasing movies using **The Movie Database (TMDb) API**.
The app supports online/offline viewing, bookmarking movies, search functionality, and **deep links** to directly open a specific movie.

---

## 🚀 Features

* ✅ Fetch Trending & Now Playing movies from TMDb API
* ✅ View detailed movie information
* ✅ Search movies with debounce support
* ✅ Bookmark movies (saved in local SQLite DB)
* ✅ Offline support with cached data
* ✅ Deep link support (`https://movies.com/movie/{id}` opens directly in app)
* ✅ APK ready for testing

---

## 📱 APK Download

https://drive.google.com/file/d/1ZA11QWtp6qTO0QIuF1dGlOC9FaOyF5Wu/view?usp=sharing

---

## ▶️ Demo Video

https://drive.google.com/file/d/1AUYrMQ3TT5awArZQ2pKtlQigjnd-b6gr/view?usp=sharing

---

## 🛠️ Setup & Run

### 1. Clone the Repository

```bash
git clone https://github.com/hanishk/movie_app.git
cd movie_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

---

## 🔗 Deep Link Guide

To test deep links on Android:

1. Install the APK on your device.
2. Go to:
   **Settings → Apps → Default apps → Opening links**
3. Find and select **movies.com**
4. Ensure it is set to open with this app.
5. Try opening a link in Whatsapp or Messaging app or chrome:

   ```
   https://movies.com/movie/1355666
   ```

   → It will open directly in the app’s Movie Details page.

---

## 🌐 API Connectivity Fix (if movies not loading)

On some networks, DNS resolution may block TMDb API requests.
If movies do not load:

1. Go to:
   **Settings → Network & Internet → Private DNS**
2. Set DNS provider to:

   ```
   dns.google
   ```
3. Save and reopen the app.

---

## 📦 Tech Stack

* **Flutter** (State Management: BLoC + Cubit)
* **http** (API calls)
* **SQLite (sqflite)** for offline storage
* **GoRouter** for navigation + deep links
* **GetIt** for dependency injection
* **CachedNetworkImage** for image caching
* **Share Plus** for sharing movie links

---
