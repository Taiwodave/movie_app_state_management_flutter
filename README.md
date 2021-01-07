## Flutter State Management: Movie App with Provider, Riverpod, flutter_bloc 



## Features

- Now Playing movies (with pagination)
- Save favourites to watch list
- Multiple profiles (like Netflix)
- Local data persistence (movies, favourites, profiles) with Sembast

## Bugs

- List reloads from top after a page is added

## Supported state management solutions

- [x] Riverpod (using `StateNotifier`)
- [x] flutter_bloc (using `Cubit`)
- [ ] Provider



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
