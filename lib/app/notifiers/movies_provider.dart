import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/models/movies_model.dart';
import 'package:movie_app/app/services/movie_services.dart';

// notifier initialize for global use
final moviesNotifierProvider = ChangeNotifierProvider<MoviesNotifier>(
  (ref) => MoviesNotifier(),
);

// change notifier class for movies
class MoviesNotifier extends ChangeNotifier {
  MoviesNotifier() {
    getAllMoviesList();
  }

  // movie services instance
  final _movieServices = MovieServices();

  // movie category slider
  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  set selectedCategoryIndex(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  // movies list
  AsyncValue<MoviesModel> movieList = const AsyncLoading();

  void getAllMoviesList() async {
    try {
      final movieResponse = await _movieServices.fetchMovieList('list_movies.json?limit=10');
      final newResponse = MoviesModel.fromJson(movieResponse);
      movieList = AsyncValue.data(newResponse);
    } catch (e) {
      movieList = AsyncValue.error(e.toString(), StackTrace.current);
    }
    notifyListeners();
  }
}
