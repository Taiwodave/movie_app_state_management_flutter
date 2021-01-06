// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'profile.freezed.dart';

// @freezed
// abstract class Profile with _$Profile {
//   const factory Profile(String name, String id) = _Data;

//   factory Profile.fromJson(Map<String, dynamic> json) =>
//       _$ProfileFromJson(json);
// }

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class Profile {
  final String id;
  final String name;
  Profile({
    @required this.id,
    @required this.name,
  });

  Profile copyWith({
    String id,
    String name,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Profile(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() => 'Profile(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Profile && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Profiles {
  final Map<String, Profile> values;
  Profiles({@required this.values});

  factory Profiles.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Profiles(
        values: map.map((key, value) => MapEntry<String, Profile>(
              key,
              Profile.fromJson(value),
            )));
  }

  String toJson() => json.encode(values);

  factory Profiles.fromJson(String source) =>
      Profiles.fromMap(json.decode(source));

  @override
  String toString() => 'Profiles(values: $values)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return o is Profiles && mapEquals(o.values, values);
  }

  @override
  int get hashCode => values.hashCode;
}
