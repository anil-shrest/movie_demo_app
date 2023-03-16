import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/constants/strings.dart';
import 'package:movie_app/app/notifiers/movies_provider.dart';
import 'package:movie_app/app/screens/movie_details_page.dart';

class FilterMoviePage extends ConsumerWidget {
  const FilterMoviePage({required this.filterOption, super.key});
  final FilterOptions filterOption;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesNotifierProvider(filterOption.filterOptionType)).movieList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Movie By ${filterOption.name}'),
      ),
      body: movies.when(
        data: (data) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.data!.movies!.length,
            itemBuilder: (BuildContext ctx, index) {
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
                        data.data!.movies![index].mediumCoverImage!,
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
          );
        },
        error: (e, stack) => Text(e.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
