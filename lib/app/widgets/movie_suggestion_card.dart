import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/notifiers/movie_details_provider.dart';

// movie suggestions card
class MovieSuggestionWidget extends ConsumerWidget {
  const MovieSuggestionWidget({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(movieDetailsNotifierProvider(id)).movieSuggestions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Similar Movies',
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        movie.when(
          data: (data) {
            return SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.data!.movies!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(data.data!.movies![index].mediumCoverImage!),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const SizedBox(
                          height: 120,
                          width: 100,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text(
                          data.data!.movies![index].title!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          error: (e, stack) => Text(e.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
