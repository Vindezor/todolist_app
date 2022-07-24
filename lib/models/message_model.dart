// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    MessageModel({
        required this.status,
        required this.message,
    });

    String status;
    String message;

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
