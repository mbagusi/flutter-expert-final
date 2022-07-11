import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final String firstAirDate;

  const TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
        voteCount,
        firstAirDate,
      ];
}
