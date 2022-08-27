import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String? email, name, phone, status, type, username,city,uid,photo;
  GeoPoint? location;
  int? price;

  ClientModel({email, location, name, phone, status, type,photo, username,city,price,uid});

  ClientModel.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'],
        location = json['location'],
        name = json['name'],
        phone = json['phone'],
        status = json['status'],
        type = json['type'],
        city = json['city'],
        price = json['price'] != null ? int.parse(json['price'].toString()) : 0,
        uid = json['uid'],
        photo = json['photo'],
        username = json['username'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "email": email,
        "location": location,
        "name": name,
        "phone": phone,
        "status": status,
        "type": type,
        "username": username,
        "city": city,
        "price": price,
        "photo": photo,
        "uid": uid,
      };
}
