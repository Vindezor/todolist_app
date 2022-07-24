// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data? data;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        required this.token,
        required this.refreshToken,
        required this.id,
    });

    String token;
    String refreshToken; 
    String id;
    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        refreshToken: json["refreshToken"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "refreshToken": refreshToken,
        "id": id,
    };
}
