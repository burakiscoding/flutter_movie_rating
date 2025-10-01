import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';

class SuccessModel {
  final String message;

  const SuccessModel({required this.message});

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(message: json["message"] as String);
  }
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

extension SuccesModelX on SuccessModel {
  SuccessEntity toEntity() {
    return SuccessEntity(message: message);
  }
}
