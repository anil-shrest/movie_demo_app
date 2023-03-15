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
      String reqUrl = 'list_movies.json?limit=10';
      if (selectedCategoryIndex == 0) {
        reqUrl = 'list_movies.json?limit=10';
      } else if (selectedCategoryIndex == 1) {
        reqUrl = 'list_movies.json?quality=3D';
        notifyListeners();
      } else if (selectedCategoryIndex == 2) {
        reqUrl = 'list_movies.json?genre=horror&limit=10';
        notifyListeners();
      } else if (selectedCategoryIndex == 3) {
        reqUrl = 'list_movies.json?genre=action&limit=10';
        notifyListeners();
      } else if (selectedCategoryIndex == 4) {
        reqUrl = 'list_movies.json?genre=Comedy&limit=10';
        notifyListeners();
      }
      final movieResponse = await _movieServices.fetchMovieList(reqUrl);
      final newResponse = MoviesModel.fromJson(movieResponse);
      movieList = AsyncValue.data(newResponse);
    } catch (e) {
      movieList = AsyncValue.error(e.toString(), StackTrace.current);
    }
    notifyListeners();
  }
}
