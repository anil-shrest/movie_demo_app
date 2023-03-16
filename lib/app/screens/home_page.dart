import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/constants/strings.dart';
import 'package:movie_app/app/constants/urls.dart';
import 'package:movie_app/app/extras/persistent_header.dart';
import 'package:movie_app/app/models/movies_model.dart';
import 'package:movie_app/app/notifiers/movies_provider.dart';
import 'package:movie_app/app/screens/movie_details_page.dart';

// Main home-page of the movie app
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(moviesNotifierProvider).movieList;

    return Scaffold(
      body: SafeArea(
        child: movies.when(
          data: (data) {
            return CustomScrollView(
              slivers: [
                const MovieAppBar(),
                const MovieSearchBar(),
                const MovieCategorySlider(),
                MoviesGridList(data: data),
              ],
            );
          },
          error: (e, stack) => Text(e.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

// Movies grid list items
class MoviesGridList extends ConsumerWidget {
  const MoviesGridList({required this.data, super.key});
  final MoviesModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(id: data.data!.movies![index].id.toString()),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      data.data?.movies?[index].mediumCoverImage ?? ApiUrls.imageNotFound,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.bottomLeft,
                      color: const Color.fromARGB(255, 85, 156, 102),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    data.data!.movies![index].title.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  data.data!.movies![index].year.toString(),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(
                              bottom: 2,
                              left: 4,
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_circle_outline_rounded,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: data.data?.movies?.length,
        ),
      ),
    );
  }
}

// Movie category slider
class MovieCategorySlider extends ConsumerWidget {
  const MovieCategorySlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesNotifier = ref.watch(moviesNotifierProvider);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: MovieCategoryOption.values.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: moviesNotifier.selectedCategoryIndex == index
                    ? () {}
                    : () {
                        moviesNotifier.selectedCategoryIndex = index;
                        moviesNotifier.getAllMoviesList();
                      },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: moviesNotifier.selectedCategoryIndex == index ? Colors.lightGreen : Colors.grey)),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        MovieCategoryOption.values[index].movieCategoryType,
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500,
                          color: moviesNotifier.selectedCategoryIndex == index ? Colors.lightGreen : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Movie search-bar
class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        widget: TextField(
          onChanged: (value) {
            if (value.isNotEmpty) {
              // ref.read(newsProvider.notifier).loadSearchNews(value);
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade700,
            contentPadding: const EdgeInsets.all(10),
            hintText: 'Search Movie',
            hintStyle: const TextStyle(
              color: Color(0xffDDDADA),
              fontSize: 15,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 21,
              color: Colors.lightGreen,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.lightGreen)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.lightGreen)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// Movie main app-bar
class MovieAppBar extends ConsumerWidget {
  const MovieAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesNotifierProvider);

    return SliverAppBar(
      title: const Text('Movie App'),
      elevation: 0,
      floating: true,
      actions: [
        IconButton(
          iconSize: 28,
          splashRadius: 23,
          onPressed: () {
            movies.isDescendingOrder = !movies.isDescendingOrder;
            movies.getAllMoviesList();
          },
          icon: movies.isDescendingOrder ? const RotatedBox(quarterTurns: 2, child: Icon(Icons.sort_rounded)) : const Icon(Icons.sort_rounded),
        ),
      ],
    );
  }
}
