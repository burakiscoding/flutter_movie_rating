import 'package:flutter_movie_rating/shared/domain/entities/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String firstName;
  final String lastName;
  final String aboutMe;

  const ProfileModel({required this.firstName, required this.lastName, required this.aboutMe});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

extension ProfileModelX on ProfileModel {
  ProfileEntity toEntity() {
    return ProfileEntity(firstName: firstName, lastName: lastName, aboutMe: aboutMe);
  }
}
