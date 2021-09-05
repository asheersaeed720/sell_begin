class CountryModel {
  CountryModel({
    this.id,
    this.sortname,
    this.name,
    this.phonecode,
  });

  String? id;
  String? sortname;
  String? name;
  String? phonecode;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        sortname: json["sortname"],
        name: json["name"],
        phonecode: json["phonecode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sortname": sortname,
        "name": name,
        "phonecode": phonecode,
      };
}
