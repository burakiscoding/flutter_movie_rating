import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({super.key, required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Failure'),
      content: Text(failure.message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
