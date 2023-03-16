// movies category list
List<String> category = [
  'All',
  '3D',
  'Horror',
  'Comedy',
  'Action',
];

enum FilterOptions { Date, Title, Rating, Download }

enum SortByOption { ascending, descending }

extension SortType on SortByOption {
  String get sortByOptionUrl {
    switch (this) {
      case SortByOption.ascending:
        return 'list_movies.json?order_by=asc&limit=10';

      case SortByOption.descending:
        return 'list_movies.json?order_by=desc&limit=10';

      default:
        return 'list_movies.json?order_by=desc&limit=10';
    }
  }
}

enum MovieCategoryOption { allMovies, threeDMovie, horror, action, comedy }

extension CategoryType on MovieCategoryOption {
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

      default:
        return 'All Movies';
    }
  }

  String get categoryUrl {
    switch (this) {
      case MovieCategoryOption.allMovies:
        return 'list_movies.json?limit=10';

      case MovieCategoryOption.threeDMovie:
        return 'list_movies.json?quality=3D&limit=10';

      case MovieCategoryOption.horror:
        return 'list_movies.json?genre=horror&limit=10';

      case MovieCategoryOption.action:
        return 'list_movies.json?genre=action&limit=10';

      case MovieCategoryOption.comedy:
        return 'list_movies.json?genre=comdey&limit=10';

      default:
        return 'list_movies.json?limit=10';
    }
  }
}
