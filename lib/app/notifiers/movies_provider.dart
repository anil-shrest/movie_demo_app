import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/constants/strings.dart';
import 'package:movie_app/app/models/movies_model.dart';
import 'package:movie_app/app/services/movie_services.dart';

// notifier initialize for global use
final moviesNotifierProvider = ChangeNotifierProvider.family<MoviesNotifier, String>(
  (ref, url) => MoviesNotifier(url: url),
);

// change notifier class for movies
class MoviesNotifier extends ChangeNotifier {
  MoviesNotifier({required this.url}) {
    getAllMoviesList(url);
  }

  final String url;

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

  void getAllMoviesList(String url) async {
    try {
      // final movieResponse = await _movieServices.fetchMovieList(isDescendingOrder == true
      //     ? '${MovieCategoryOption.values[selectedCategoryIndex].categoryUrl}&order_by=desc'
      //     : '${MovieCategoryOption.values[selectedCategoryIndex].categoryUrl}&order_by=asc');
      final movieResponse = await _movieServices.fetchMovieList(url);
      final newResponse = MoviesModel.fromJson(movieResponse);
      movieList = AsyncValue.data(newResponse);
    } catch (e) {
      movieList = AsyncValue.error(e.toString(), StackTrace.current);
    }
    notifyListeners();
  }

  // movie sort
  bool _isDescendingOrder = true;

  bool get isDescendingOrder => _isDescendingOrder;

  set isDescendingOrder(bool value) {
    _isDescendingOrder = value;
    notifyListeners();
  }

  // movie filter with type
  FilterOptions _filterType = FilterOptions.Date;

  FilterOptions get filterType => _filterType;

  set filterType(FilterOptions value) {
    _filterType = value;
    notifyListeners();
  }
}
