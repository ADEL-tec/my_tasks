// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  int? type;

  /// 1 => Cridentials
  /// 2 => Google
  String? name;
  String? email;
  String? avatar;
  String? openId;
  DateTime? createdAt;

  UserEntity({
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.openId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'email': email,
      'avatar': avatar,
      'openId': openId,
      'createdAt': createdAt,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    var createdAtValue = map['createdAt'];
    if (createdAtValue != null) {
      if (createdAtValue is Timestamp) {
        createdAtValue = createdAtValue.toDate();
      } else if (createdAtValue is String) {
        createdAtValue = DateTime.tryParse(createdAtValue);
      }
    }
    return UserEntity(
      type: map['type'] != null ? map['type'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      openId: map['openId'] != null ? map['openId'] as String : null,
      createdAt: createdAtValue,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
