import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_rating/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';
import 'package:flutter_movie_rating/shared/domain/entities/profile_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/user_movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/user_repository.dart';
import 'package:flutter_movie_rating/shared/extensions/context_x.dart';
import 'package:flutter_movie_rating/shared/helpers/form_validation.dart';
import 'package:flutter_movie_rating/shared/presentation/custom_elevated_button.dart';
import 'package:flutter_movie_rating/shared/presentation/custom_text_field.dart';
import 'package:flutter_movie_rating/shared/presentation/error_view.dart';

part 'form.dart';
part 'ratings_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) =>
          ProfileBloc(userRepository: getIt<UserRepository>())
            ..add(ProfileGetStarted()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.showRatingView) {
            _showBottomSheet(context, state);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state.getFailure != null) {
            return ErrorView(failure: state.getFailure!);
          }

          final profile = state.profile;
          if (profile == null) {
            return const SizedBox();
          }

          return Column(
            children: [
              _Form(isLoading: state.isUpdating, profile: profile),
              CustomElevatedButton(
                onPressed: () {
                  BlocProvider.of<ProfileBloc>(
                    context,
                  ).add(ProfileGetRatingsPressed());
                },
                text: 'See your movie ratings',
                isLoading: state.isRatingsLoading,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showBottomSheet(
    BuildContext context,
    ProfileState state,
  ) async {
    await context.showCustomBottomSheet(
      (context) => _RatingsBottomSheet(ratings: state.ratings),
    );
    if (context.mounted) {
      BlocProvider.of<ProfileBloc>(context).add(ProfileRatingViewClosed());
    }
  }
}
