// To parse this JSON data, do
//
//     final listaModel = listaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ListaModel listaModelFromJson(String str) => ListaModel.fromJson(json.decode(str));

String listaModelToJson(ListaModel data) => json.encode(data.toJson());

class ListaModel {
    ListaModel({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data? data;

    factory ListaModel.fromJson(Map<String, dynamic> json) => ListaModel(
        status: json["status"],
        message: json["message"],
        data: (json["data"] == null) ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": (data == null) ? null : data!.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.lista,
    });

    String id;
    List<Lista> lista;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        lista: List<Lista>.from(json["lista"].map((x) => Lista.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lista": List<dynamic>.from(lista.map((x) => x.toJson())),
    };
}

class Lista {
    Lista({
        this.id,
        required this.data,
    });

    String? id;
    String data;

    factory Lista.fromJson(Map<String, dynamic> json) => Lista(
        id: json["id"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": data,
    };
}
