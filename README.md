## Flutter State Management: Movie App with Provider, Riverpod, flutter_bloc 

This is a reference project showing how to implement a (Netflix-inspired) movie app with different state management techniques in Flutter:

![Movie app preview](media/app-screenshots.png)

The project uses the [TMDB API](https://www.themoviedb.org/documentation/api) to fetch a list of currently playing movies, and includes features such as pagination and local storage.

## Features

- Now Playing movies (with pagination)
- Save favourites to watch list
- Multiple profiles (like Netflix)
- Local data persistence (movies, favourites, profiles) with Sembast

## Supported state management solutions

- [x] Riverpod (using `StateNotifier`)
- [x] flutter_bloc (using `Cubit`)
- [ ] Provider

## Getting a TMDB API key

This project uses the TMDB API to get the latest movies data.

Before running the app you need to [sign up on the TMDB website](https://www.themoviedb.org/signup), then obtain an API key on the [settings API page](https://www.themoviedb.org/settings/api).

Once you have this, create an `api_keys.dart` file inside `packages/core/lib/api`, and add your key:

```dart
// api_keys.dart
String tmdbApiKey = "your-api-key";
```

Once you have done that, you're good to go.

## Note: Loading images from insecure HTTP endpoints

The data returned by the TMBD API points to image URLs using http rather than https. In order for images to load correctly, the following changes have been made:

### Android

Created a file at `android/app/src/main/res/xml/network_security_config.xml` with these contents:

```
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true" />
</network-security-config>
```

Added this to the application tag in the `AndroidManifest.xml`:

```
android:networkSecurityConfig="@xml/network_security_config"
```

### iOS

Add the following to `ios/Runner/info.pList`:

```
  <key>NSAppTransportSecurity</key>
  <dict>
      <key>NSAllowsArbitraryLoads</key>
      <true/>
  </dict>
```

More information here:

- [Insecure HTTP connections are disabled by default on iOS and Android.](https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android)
