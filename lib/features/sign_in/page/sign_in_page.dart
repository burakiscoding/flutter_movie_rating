import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_rating/features/movies/page/movies_page.dart';
import 'package:flutter_movie_rating/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/user_repository.dart';
import 'package:flutter_movie_rating/shared/extensions/context_x.dart';
import 'package:flutter_movie_rating/shared/helpers/form_validation.dart';
import 'package:flutter_movie_rating/shared/presentation/custom_elevated_button.dart';
import 'package:flutter_movie_rating/shared/presentation/custom_text_field.dart';
import 'package:flutter_movie_rating/shared/presentation/password_text_field.dart';

part 'form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(userRepository: getIt<UserRepository>()),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.failure != null) {
            context.showFailureDialog(state.failure!);
          } else if (state.authSuccess != null) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const MoviesPage()));
          }
        },
        builder: (context, state) {
          return _Form(isLoading: state.isLoading);
        },
      ),
    );
  }
}
