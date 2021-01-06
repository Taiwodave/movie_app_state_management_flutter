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

