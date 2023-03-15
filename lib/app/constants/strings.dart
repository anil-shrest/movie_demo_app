// movies category list
List<String> category = [
  'All',
  '3D',
  'Horror',
  'Comedy',
  'Action',
];

enum MovieCategoryOption { allMovies, threeDMovie, horror, action, comedy, drama }

extension Type on MovieCategoryOption {
  String get movieCategoryType {
    switch (this) {
      case MovieCategoryOption.allMovies:
        return 'All Movies';

      case MovieCategoryOption.threeDMovie:
        return '3D Movies';

      case MovieCategoryOption.horror:
        return 'Horror';

      case MovieCategoryOption.action:
        return 'Action';

      case MovieCategoryOption.comedy:
        return 'Comedy';

      case MovieCategoryOption.drama:
        return 'Drama';

      default:
        return 'All Movies';
    }
  }
}
