import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/models/movie_details_model.dart';
import 'package:movie_app/app/notifiers/movie_details_provider.dart';
import 'package:movie_app/app/widgets/movie_suggestion_card.dart';

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
                    children: [
                      BackgroundImageWidget(data: data),
                      MovieInteractionWidget(data: data),
                    ],
                  ),
                  const BackButtonWidget(),
                ],
              );
            },
            error: (e, stack) => Text(e.toString()),
            loading: () => const Padding(
              padding: EdgeInsets.only(top: 320),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// page back button
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

// movie interaction widget [favourite, share, like]
class MovieInteractionWidget extends StatelessWidget {
  const MovieInteractionWidget({
    super.key,
    required this.data,
  });

  final MovieDetailsModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Text(
                    ' |  ${data.data!.movie!.downloadCount}',
                    style: const TextStyle(fontSize: 14),
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
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              data.data!.movie!.title!,
              style: const TextStyle(
                fontSize: 25,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              '${data.data!.movie!.runtime} hr • ${data.data!.movie!.genres} • ${data.data!.movie!.year}',
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              data.data!.movie!.descriptionFull!,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.white12,
                    side: const BorderSide(
                      width: 1,
                      color: Colors.lightGreen,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.lightGreen,
                    size: 30,
                  ),
                  label: const Text('Watch Now',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.3,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
          ),
          MovieSuggestionWidget(
            id: data.data!.movie!.id!.toString(),
          ),
        ],
      ),
    );
  }
}

// movie background image widget
class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({
    super.key,
    required this.data,
  });
  final MovieDetailsModel data;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
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
    );
  }
}
