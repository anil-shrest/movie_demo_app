import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/models/movie_details_model.dart';
import 'package:movie_app/app/services/movie_services.dart';

// notifier initialize for global use
final movieDetailsNotifierProvider = ChangeNotifierProvider.family.autoDispose<MovieDetailNotifier, String>(
  (ref, movieId) => MovieDetailNotifier(movieId: movieId),
);

// change notifier class for movie details
class MovieDetailNotifier extends ChangeNotifier {
  MovieDetailNotifier({required this.movieId}) {
    getMovieDetails(movieId);
  }

  final String movieId;

  // movie services instance
  final _movieServices = MovieServices();

  // movie details
  AsyncValue<MovieDetailsModel> movieDetails = const AsyncLoading();

  void getMovieDetails(String movieId) async {
    try {
      final movieResponse = await _movieServices.fetchMovieDetails(movieId);
      final newResponse = MovieDetailsModel.fromJson(movieResponse);
      movieDetails = AsyncValue.data(newResponse);
    } catch (e) {
      movieDetails = AsyncValue.error(e.toString(), StackTrace.current);
    }
    notifyListeners();
  }
}
