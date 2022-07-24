import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/models/message_model.dart';
import 'package:login_app/services/utils/global_ip.dart';

import '../models/lista_model.dart';

class UpdateListService{
  final Dio _dio;

  UpdateListService(this._dio);

  Future<MessageModel> updateList(Data data) async {
    try {
      final lista = data.toJson();
      const FlutterSecureStorage storage = FlutterSecureStorage();
      String? token = await storage.read(key: "token");
      final response = await _dio.put(
        '$ip/api/v1/lista',
        options: Options(
          headers: {
            "Authorization": token
          }
        ),
        data: lista
      );
      if(response.statusCode == 200){
        return MessageModel.fromJson(response.data);
      }
      return MessageModel(status: "ERROR", message: "Error de json");
    } on DioError catch(e){
      if(e.type == DioErrorType.connectTimeout){
        return MessageModel(status: "ERROR", message: "Error del servidor");
      }
      if(e.type == DioErrorType.other){
        return MessageModel(status: "ERROR", message: "Sin conexión a internet");
      }
      return MessageModel(status: "ERROR", message: "Error $e");
    } catch (e){
      return MessageModel(status: "ERROR", message: "Error $e");
    }
  }
}