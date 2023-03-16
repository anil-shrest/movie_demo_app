import 'package:dio/dio.dart';
import 'package:movie_app/app/constants/urls.dart';

class MovieServices {
  // dio initialize
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      responseType: ResponseType.json,
    ),
  );

  // fetching all movie list
  fetchMovieList(String type) async {
    var response = await _dio.get(type);
    return response.data;
  }

  // fetching a single movie details
  fetchMovieDetails(String url) async {
    var response = await _dio.get(url);
    return response.data;
  }
}
