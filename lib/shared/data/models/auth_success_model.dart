import 'package:flutter_movie_rating/shared/domain/entities/auth_success_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_success_model.g.dart';

@JsonSerializable()
class AuthSuccessModel {
  final String token;
  final String email;

  const AuthSuccessModel({required this.token, required this.email});

  factory AuthSuccessModel.fromJson(Map<String, dynamic> json) => _$AuthSuccessModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSuccessModelToJson(this);
}

extension AuthSuccessModelX on AuthSuccessModel {
  AuthSuccessEntity toEntity() {
    return AuthSuccessEntity(token: token, email: email);
  }
}
