class CityModel {
  CityModel({
    this.id,
    this.name,
    this.stateId,
  });

  String? id;
  String? name;
  String? stateId;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
      };
}
