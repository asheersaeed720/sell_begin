class Chat {
  Chat({
    this.id,
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.status,
    // this.fromUser,
  });

  String? id;
  String? from;
  String? to;
  String? message;
  DateTime? createdAt;
  String? status;
  // FromUser? fromUser;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        // fromUser: FromUser.fromJson(json["From_User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        // "From_User": fromUser?.toJson(),
      };
}

class FromUser {
  FromUser({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.userImage,
    this.status,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? phone;
  String? email;
  String? userImage;
  String? status;
  String? password;
  String? createdAt;
  DateTime? updatedAt;

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        userImage: json["userImage"],
        status: json["status"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "userImage": userImage,
        "status": status,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
