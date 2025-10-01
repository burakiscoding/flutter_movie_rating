// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_success_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSuccessModel _$AuthSuccessModelFromJson(Map<String, dynamic> json) =>
    AuthSuccessModel(
      token: json['token'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$AuthSuccessModelToJson(AuthSuccessModel instance) =>
    <String, dynamic>{'token': instance.token, 'email': instance.email};
