import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, required this.success});

  final SuccessEntity success;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Success'),
      content: Text(success.message),
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
