// To parse this JSON data, do
//
//     final favouriteModels = favouriteModelsFromJson(jsonString);

import 'dart:convert';

List<FavouriteModels> favouriteModelsFromJson(String str) =>
    List<FavouriteModels>.from(
        json.decode(str).map((x) => FavouriteModels.fromJson(x)));

String favouriteModelsToJson(List<FavouriteModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteModels {
  FavouriteModels({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  dynamic? backdropPath;
  List<dynamic>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory FavouriteModels.fromJson(Map<String, dynamic> json) =>
      FavouriteModels(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<dynamic>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
