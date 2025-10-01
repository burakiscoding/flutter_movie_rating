import 'package:flutter/material.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/failure_dialog.dart';
import 'package:flutter_movie_rating/shared/presentation/success_dialog.dart';

extension BuildContextX on BuildContext {
  Future<T?> showFailureDialog<T>(Failure f) async {
    return showDialog<T>(
      context: this,
      builder: (ctx) => FailureDialog(failure: f),
    );
  }

  Future<T?> showSuccessDialog<T>(SuccessEntity s) async {
    return showDialog<T>(
      context: this,
      builder: (ctx) => SuccessDialog(success: s),
    );
  }

  Future<T?> showCustomBottomSheet<T>(
    Widget Function(BuildContext context) builder,
  ) {
    return showModalBottomSheet<T>(
      enableDrag: true,
      isScrollControlled: true,
      useSafeArea: true,
      context: this,
      builder: builder,
    );
  }
}
