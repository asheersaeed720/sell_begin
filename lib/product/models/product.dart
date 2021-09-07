class Product {
  Product({
    this.id,
    this.title,
    this.description,
    this.condition,
    this.userId,
    this.subCategoryId,
    this.cityId,
    this.price,
    this.createdAt,
    this.user,
    this.subCategory,
  });

  String? id;
  String? title;
  String? description;
  String? condition;
  String? userId;
  String? subCategoryId;
  String? cityId;
  String? price;
  DateTime? createdAt;
  ProductUser? user;
  ProductSubCategory? subCategory;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        condition: json["condition"],
        userId: json["User_id"],
        subCategoryId: json["Sub_Category_id"],
        cityId: json["city_id"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        user: ProductUser.fromJson(json["user"]),
        subCategory: ProductSubCategory.fromJson(json["sub_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "condition": condition,
        "User_id": userId,
        "Sub_Category_id": subCategoryId,
        "city_id": cityId,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "user": user?.toJson(),
        "sub_category": subCategory?.toJson(),
      };
}

class ProductSubCategory {
  ProductSubCategory({
    this.id,
    this.name,
    this.categoryId,
    this.createdAt,
  });

  String? id;
  String? name;
  String? categoryId;
  DateTime? createdAt;

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) => ProductSubCategory(
        id: json["id"],
        name: json["name"],
        categoryId: json["Category_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
      };
}

class ProductUser {
  ProductUser({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.userImage,
    this.status,
    this.password,
    this.lastLogin,
    this.createdAt,
  });

  String? id;
  String? name;
  String? phone;
  String? email;
  String? userImage;
  String? status;
  String? password;
  DateTime? lastLogin;
  String? createdAt;

  factory ProductUser.fromJson(Map<String, dynamic> json) => ProductUser(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        userImage: json["userImage"],
        status: json["status"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "userImage": userImage,
        "status": status,
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "created_at": createdAt,
      };
}
