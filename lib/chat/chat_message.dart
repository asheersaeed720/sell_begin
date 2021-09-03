class ChatMessage {
  ChatMessage({
    this.id,
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.status,
  });

  String? id;
  String? from;
  String? to;
  String? message;
  DateTime? createdAt;
  String? status;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
      };
}
