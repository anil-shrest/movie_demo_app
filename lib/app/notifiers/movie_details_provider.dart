import 'package:blurhash/blurhash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/models/movie_details_model.dart';
import 'package:movie_app/app/models/movies_model.dart';
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
  AsyncValue<MoviesModel> movieSuggestions = const AsyncLoading();

  void getMovieDetails(String movieId) async {
    try {
      final movieResponse = await _movieServices.fetchMovieDetails('movie_details.json?movie_id=$movieId');
      final newResponse = MovieDetailsModel.fromJson(movieResponse);
      movieDetails = AsyncValue.data(newResponse);
      getMovieSuggestions('movie_suggestions.json?movie_id=$movieId');
    } catch (e) {
      movieDetails = AsyncValue.error(e.toString(), StackTrace.current);
    }
    createBlurHash(movieDetails.value!.data!.movie!.mediumCoverImage.toString());
    notifyListeners();
  }

  // movie suggestions
  void getMovieSuggestions(String movieId) async {
    try {
      final movieResponse = await _movieServices.fetchMovieDetails(movieId);
      final newResponse = MoviesModel.fromJson(movieResponse);
      movieSuggestions = AsyncValue.data(newResponse);
    } catch (e) {
      movieSuggestions = AsyncValue.error(e.toString(), StackTrace.current);
    }
    notifyListeners();
  }

  // hash blur
  String _decodedBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

  String get decodedBlurHash => _decodedBlurHash;

  set setDecodedBlurHash(String value) {
    _decodedBlurHash = value;
    notifyListeners();
  }

  createBlurHash(String imageUrl) async {
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl)).buffer.asUint8List();
    // debugPrint(bytes.toString());
    String blurHash = await BlurHash.encode(bytes, 4, 3);
    // debugPrint(blurHash);
    setDecodedBlurHash = blurHash;
  }
}
