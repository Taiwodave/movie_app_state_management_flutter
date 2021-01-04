import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_state_management_flutter/models/tmdb_movie_basic.dart';

part 'tmdb_movies_response.g.dart';

@JsonSerializable()
class TMDBMoviesResponse extends Object
    with _$TMDBMoviesResponseSerializerMixin {
  int page;
  List<TMDBMovieBasic> results;
  @JsonKey(name: "total_results")
  int totalResults;
  @JsonKey(name: "total_pages")
  int totalPages;
  @JsonKey(name: "errors")
  List<String> errors;

  TMDBMoviesResponse(
      {this.page,
      this.totalResults,
      this.totalPages,
      this.results,
      this.errors});

  bool get isEmpty => !hasResults();

  bool hasResults() {
    return results != null && results.length > 0;
  }

  bool hasErrors() {
    return errors != null && errors.length > 0;
  }

  factory TMDBMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$TMDBMoviesResponseFromJson(json);
}
