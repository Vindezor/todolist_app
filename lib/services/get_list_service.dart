import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/services/utils/global_ip.dart';

import '../models/lista_model.dart';

class GetListService{
  final Dio _dio;

  GetListService(this._dio);

  Future<ListaModel?> getLista() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    try {
      final response = await _dio.get(
        '$ip/api/v1/lista',
        options: Options(
          headers: {
            "Authorization": token
          }
        )

      );
      
      if(response.statusCode == 200){
        return ListaModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }  
}
