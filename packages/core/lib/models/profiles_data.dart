import 'dart:convert';

import 'package:core/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ProfilesData {
  final Map<String, Profile> profiles;
  ProfilesData({@required this.profiles});

  factory ProfilesData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ProfilesData(
        profiles: map.map((key, value) => MapEntry<String, Profile>(
              key,
              Profile.fromJson(value),
            )));
  }

  String toJson() => json.encode(profiles);

  factory ProfilesData.fromJson(String source) =>
      ProfilesData.fromMap(json.decode(source));

  @override
  String toString() => 'Profiles(profiles: $profiles)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return o is ProfilesData && mapEquals(o.profiles, profiles);
  }

  @override
  int get hashCode => profiles.hashCode;
}
