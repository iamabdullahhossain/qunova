// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  final String? status;
  final String? message;
  final Data? data;

  DataModel({
    this.status,
    this.message,
    this.data,
  });

  DataModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      DataModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final List<Category>? categories;
  final List<Contact>? contacts;

  Data({
    this.categories,
    this.contacts,
  });

  Data copyWith({
    List<Category>? categories,
    List<Contact>? contacts,
  }) =>
      Data(
        categories: categories ?? this.categories,
        contacts: contacts ?? this.contacts,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"]!.map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "contacts": contacts == null ? [] : List<dynamic>.from(contacts!.map((x) => x.toJson())),
  };
}

class Category {
  final String? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  Category copyWith({
    String? id,
    String? name,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Contact {
  final String? id;
  final bool? isEmpty;
  final String? name;
  final String? phone;
  final String? categoryId;
  final String? avatarUrl;
  final String? subtitle;
  final String? status;
  final String? createdAt;

  Contact({
    this.id,
    this.isEmpty,
    this.name,
    this.phone,
    this.categoryId,
    this.avatarUrl,
    this.subtitle,
    this.status,
    this.createdAt,
  });

  Contact copyWith({
    String? id,
    bool? isEmpty,
    String? name,
    String? phone,
    String? categoryId,
    String? avatarUrl,
    String? subtitle,
    String? status,
    String? createdAt,
  }) =>
      Contact(
        id: id ?? this.id,
        isEmpty: isEmpty ?? this.isEmpty,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        categoryId: categoryId ?? this.categoryId,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        subtitle: subtitle ?? this.subtitle,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    isEmpty: json["isEmpty"],
    name: json["name"],
    phone: json["phone"],
    categoryId: json["categoryId"],
    avatarUrl: json["avatarUrl"],
    subtitle: json["subtitle"],
    status: json["status"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isEmpty": isEmpty,
    "name": name,
    "phone": phone,
    "categoryId": categoryId,
    "avatarUrl": avatarUrl,
    "subtitle": subtitle,
    "status": status,
    "createdAt": createdAt,
  };
}
