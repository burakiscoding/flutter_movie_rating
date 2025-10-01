import 'package:flutter/material.dart';
import 'package:flutter_movie_rating/features/sign_in/page/sign_in_page.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    if (failure is AuthenticationFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(failure.message),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Error code: ${failure.code}'), Text(failure.message)],
      ),
    );
  }
}
