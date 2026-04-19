# Movie Explorer (TMDb iOS App)

A SwiftUI-based iOS application that integrates with The Movie Database (TMDb)
API to display popular movies, search titles, view details, play trailers, and
manage favorites.

# 📱 Features

## Movies (Home)

* Displays popular movies from TMDb
* Shows:

  * Poster
  * Title
  * Rating

* Pull-to-refresh support (native SwiftUI)
* Error handling with proper error view
* Async Images for lazy image loading


## Search

* Real-time search with debounce
* Handles:
  * Empty results → “No results found”
  * Offline → contextual message
* Smooth UX without blocking UI


## Movie Detail

* Trailer playback using WebKit : In app embedded playback
* Added youtube redirection link (intention: demo both ways of playback implementation)
* Displays:
  * Title
  * Plot
  * Genres
  * Cast
  * Runtime
  * Rating
* Pull-to-refresh supported


## Trailer Playback

* YouTube trailers supported via:

  * Embedded player (via WKWebKit)
  * Redirection: opens youtube

* Handles:
  * Missing trailer
  * Offline indicator View


## Favorites

* Mark/unmark movies
* Persisted locally using UserDefaults
* Accessible from list and detail screens
* Instant UI updates


## Image Handling

* Custom image caching using `NSCache`
* Avoids repeated network calls
* Placeholder + fallback support


## Network Handling

* Inline error states with proper error UI display

* Graceful degradation:
  * API failure → empty state + retry
* Pull-to-refresh used for retry


# Architecture

* MVVM (Model–View–ViewModel)
* SwiftUI + async/await
* Separation of concerns:

  * Views → UI only
  * ViewModels → state + logic
  * Services → networking


# 📁 Project Structure

```
MovieApp/
├── Core/
│   ├── Configuration/
│   ├── Networking/
│   ├── Persistence/
│   ├── Services/
│   └── Utils/
│
├── Features/
│   └── Movies/
│       ├── Models/
│       ├── ViewModels/
│       └── Views/
│           ├── Components/
│           └── Sections/
```


# Setup Instructions

## 1. Clone repository

```
git clone <your-repo-url>
```


## 2. TMDb API Key

Copy API key: dd3751a513fdb1c46707dc90b61b49d9

Add to config file :

```
static let apiKey = "API_KEY" // replace with api key

```


## 3. Run the project

* Open `.xcodeproj`
* Select simulator or device
* Run


# Assumptions

* API key is valid and active
* Network is available for API calls
* Some movies may not have:

  * trailers
  * cast images


# Known Limitations

## 1. YouTube Playback

* Some videos may not play inside app due to:

  * YouTube embed restrictions
  * WebKit limitations
* Alternative provided (Youtube redirection)


## 2. Network Environment Issues

* Corporate networks (e.g., SSL interception like Zscaler) may:

  * block API calls
  * block media playback
* Functionality verified via browser + alternate network


## 3. API Data Variability

* Some fields may be missing:

  * runtime (missing in Popular list response hence in Movie list card)
  * profile images
* Handled via fallback UI


## 4. Simulator Limitations

* Video playback may behave inconsistently
* Real device recommended for testing

## 5. UI Rendering

* Currently pagination is not handled as the data list is quite less

  
# Improvements / Future Enhancements

* Login authentication feature can be added
* Better retry strategy (exponential backoff)
* Pagination support for large datasets/lists
* UI polish:
  
  * skeleton loading
  * YouTube Player — preload on scroll(good user experience)
  * shimmer effects
* Localization support
* Unit testing


# Design Decisions

* Used minimal error View to keep the user informed
  
* Used AsyncImage for lazy image loading

* Custom image caching instead of third-party
  → better control and understanding

* Used WebKit over third-party packages and Safari View
  -> better user experience


# Key Highlights

* Clean MVVM architecture
* Native SwiftUI patterns (refreshable, async/await)
* Thoughtful error handling
* Performance optimizations (caching)
* User-centric UX decisions


# Conclusion

This project focuses on:

* correctness
* simplicity
* user experience
* maintainability


# References

* TMDB APIs used to build the app
   * Popular Movies: https://api.themoviedb.org/3/movie/popular?api_key={API_KEY}
   * Details: https://api.themoviedb.org/3/movie/{movie_id}?
api_key={API_KEY}
   * Trailers: https://api.themoviedb.org/3/movie/{movie_id}/videos?
api_key={API_KEY}
   * Search Movies: https://api.themoviedb.org/3/search/movie?
api_key={API_KEY}&query={QUERY}
