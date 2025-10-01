import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_rating/features/add_rating/cubit/add_rating_cubit.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/extensions/context_x.dart';
import 'package:flutter_movie_rating/shared/helpers/form_validation.dart';
import 'package:flutter_movie_rating/shared/presentation/custom_elevated_button.dart';
import 'package:flutter_movie_rating/shared/presentation/custom_text_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

part 'form.dart';

class AddRatingPage extends StatelessWidget {
  const AddRatingPage({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddRatingCubit>(
      create: (context) => AddRatingCubit(
        movieRepository: getIt<MovieRepository>(),
        movieId: movieId,
      ),
      child: const AddRatingView(),
    );
  }
}

class AddRatingView extends StatelessWidget {
  const AddRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Rating')),
      body: BlocConsumer<AddRatingCubit, AddRatingState>(
        listener: (context, state) {
          if (state.failure != null) {
            context.showFailureDialog(state.failure!);
          } else if (state.succes != null) {
            context.showSuccessDialog(state.succes!);
          }
        },
        builder: (context, state) {
          return _Form(isLoading: state.isLoading);
        },
      ),
    );
  }
}
