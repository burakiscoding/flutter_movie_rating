import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_rating/features/movie_detail/page/movie_detail_page.dart';
import 'package:flutter_movie_rating/features/movies/bloc/movies_bloc.dart';
import 'package:flutter_movie_rating/features/profile/page/profile_page.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/presentation/error_view.dart';

part 'movie_list_tile.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (context) =>
          MoviesBloc(movieRepository: getIt<MovieRepository>())
            ..add(MoviesGetAllStarted()),
      child: const MoviesView(),
    );
  }
}

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () => _pushProfile(context),
            icon: const Icon(Icons.person_2),
          ),
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.failure != null) {
            return ErrorView(failure: state.failure!);
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.separated(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];

              return _MovieListTile(
                movie: movie,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(id: movie.id),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
    );
  }

  void _pushProfile(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}
