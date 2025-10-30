// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserEntity {
  int? type;

  /// 1 => Cridentials
  /// 2 => Google
  String? name;
  String? email;
  String? avatar;
  String? openId;
  String? createdAt;

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
    return UserEntity(
      type: map['type'] != null ? map['type'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      openId: map['openId'] != null ? map['openId'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
