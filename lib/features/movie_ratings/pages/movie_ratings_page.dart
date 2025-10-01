import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_rating/features/add_rating/page/add_rating_page.dart';
import 'package:flutter_movie_rating/features/movie_ratings/cubit/movie_ratings_cubit.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';

class MovieRatingsPage extends StatelessWidget {
  const MovieRatingsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieRatingsCubit>(
      create: (context) =>
          MovieRatingsCubit(movieRepository: getIt<MovieRepository>(), id: id),
      child: MovieRatingsView(id: id),
    );
  }
}

class MovieRatingsView extends StatelessWidget {
  const MovieRatingsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ratings')),
      body: BlocBuilder<MovieRatingsCubit, MovieRatingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.failure != null) {
            return Center(child: Text(state.failure!.message));
          }
          return ListView.separated(
            itemCount: state.ratings.length,
            itemBuilder: (context, index) {
              final data = state.ratings[index];
              return ListTile(
                title: Text(data.comment),
                subtitle: Text(data.fullNameOfPerson),
                trailing: Column(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(data.rating.toStringAsFixed(2)),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddRatingPage(movieId: id)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
