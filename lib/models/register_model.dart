// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    String? data;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        data: null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": null,
    };
}