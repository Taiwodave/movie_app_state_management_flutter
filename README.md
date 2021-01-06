## Flutter State Management: Movie App with Provider, Riverpod, flutter_bloc 

Title
tmdb_flutter_bloc_demo

movie_app_demo_flutter_bloc
movie_app_demo_riverpod
movie_app_demo_provider

- [x] flutter_bloc project
- [x] pagination
- [x] freezed for models
- [x] freezed for cubit states
- [x] User profiles
- [x] Selected user profile
- [x] Bottom tabs
- [x] Move all models to core package
- [ ] Create riverpod project (work out shared parts)

## Supported state management solutions

- [x] Riverpod
- [x] flutter_bloc (cubit actually)
- [ ] Provider

## Features

// https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android

### User profiles

When app starts: Default profile

Can be done with a grid

Profile has a 
- name
- ID

Storage:
- list of profiles
- list of movies

Each time a movie is favourited:

- Store it with its id
- Add to the list of movie IDs for that user

This IS relational

Query:

- Show current favourites for given user
- SELECT * FROM movies WHERE id IN userFavorites

Saved movies can be serialized to JSON and saved to disk

- And need to be queried by ID


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
