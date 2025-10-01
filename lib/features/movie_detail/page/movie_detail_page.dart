import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_rating/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie_rating/features/movie_detail/page/image_carousel_page.dart';
import 'package:flutter_movie_rating/features/movie_ratings/pages/movie_ratings_page.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/helpers/debouncer.dart';
import 'package:video_player/video_player.dart';

part 'app_bar.dart';
part 'mini_image_carousel.dart';
part 'custom_video_player.dart';

class MovieDetailPage extends StatelessWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailBloc>(
      create: (context) =>
          MovieDetailBloc(movieRepository: getIt<MovieRepository>(), id: id)
            ..add(MovieDetailGetStarted()),
      child: const MovieDetailView(),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state.failure != null) {
            return Center(child: Text(state.failure!.message));
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final movie = state.movieDetail;
          if (movie == null) {
            return Container();
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _AppBar(
                name: movie.name,
                duration: movie.durationString,
                rating: movie.ratingString,
                id: movie.id,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  // Image carousel
                  _MiniImageCarousel(images: movie.images),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ImageCarouselPage(
                              movieName: movie.name,
                              images: movie.images,
                            ),
                          ),
                        );
                      },
                      child: Text('See all images (${movie.images.length})'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Video player
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: _VideoPlayer(url: movie.trailer),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('See all videos (${movie.videos.length})'),
                    ),
                  ),

                  const Divider(),

                  // Description text
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(movie.description),
                  ),

                  const Divider(),

                  // Actors wrap
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Actors:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 8),
                        ...List.generate(movie.actors.length, (index) {
                          return Chip(
                            label: Text(movie.actors[index].fullName),
                          );
                        }),
                      ],
                    ),
                  ),

                  const Divider(),

                  // Genres wrap
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Genres:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 8),
                        ...List.generate(movie.genres.length, (index) {
                          return Chip(label: Text(movie.genres[index].name));
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
