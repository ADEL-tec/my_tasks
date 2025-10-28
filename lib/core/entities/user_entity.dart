class UserEntity {
  int? type;

  /// 1 => Cridentials
  /// 2 => Google
  String? name;
  String? email;
  String? avatar;
  String? openId;

  UserEntity({this.type, this.name, this.email, this.avatar, this.openId});

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "email": email,
    "avatar": avatar,
    "open_id": openId,
  };
}
