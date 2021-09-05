class CountryStateModel {
  CountryStateModel({
    this.id,
    this.name,
    this.countryId,
  });

  String? id;
  String? name;
  String? countryId;

  factory CountryStateModel.fromJson(Map<String, dynamic> json) => CountryStateModel(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
      };
}
