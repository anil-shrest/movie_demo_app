// movies category list
List<String> category = [
  'All Movies',
  '3D Movies',
  'Top Seeds',
  'Upcoming',
  'Action',
];

enum MovieCategoryOption { allMovies, threeDMovie, topSeeds, upcoming }

extension Type on MovieCategoryOption {
  String get movieCategoryType {
    switch (this) {
      case MovieCategoryOption.allMovies:
        return 'All Movies';

      case MovieCategoryOption.threeDMovie:
        return '3D Movies';

      case MovieCategoryOption.topSeeds:
        return 'Top Seeds';

      case MovieCategoryOption.upcoming:
        return 'Upcoming';

      default:
        return 'All Movies';
    }
  }
}
