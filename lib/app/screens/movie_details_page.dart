import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/notifiers/movie_details_provider.dart';

// movie details page
class MovieDetailsPage extends ConsumerWidget {
  const MovieDetailsPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(movieDetailsNotifierProvider(id)).movieDetails;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: movie.when(
            data: (data) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.darken,
                        child: SizedBox(
                          height: 380,
                          width: double.infinity,
                          child: Image.network(
                            data.data!.movie!.largeCoverImage!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              Text(
                                ' |  ${data.data!.movie!.downloadCount}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(Icons.share_outlined),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_border),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        data.data!.movie!.title!,
                        style: const TextStyle(
                          fontSize: 25,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${data.data!.movie!.runtime} • ${data.data!.movie!.genres} • ${data.data!.movie!.year}',
                        style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                      ),
                      Text(
                        data.data!.movie!.descriptionFull!,
                        style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white24,
                        elevation: 1,
                        side: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: const Text(''),
                    ),
                  ),
                ],
              );
            },
            error: (e, stack) => Text(e.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
