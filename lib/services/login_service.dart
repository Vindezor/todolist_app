import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:login_app/models/login_model.dart';
import 'package:login_app/services/utils/global_ip.dart';

class LoginService{
  final Dio _dio;

  LoginService(this._dio);

  Future<LoginModel> login(String username, String password)async {
    try{
      final response = await _dio.post(
        "$ip/api/v1/login",
        data: {
          "username": username,
          "password": password
        },
      );
      final resp = LoginModel.fromJson(response.data);
      return resp;
    } on DioError catch(e){
      if(e.type == DioErrorType.connectTimeout){
        return LoginModel(status: "ERROR", message: "Error del servidor", data: null);
      }
      if(e.type == DioErrorType.other){
        return LoginModel(status: "ERROR", message: "Sin conexión a internet", data: null);
      }
      return LoginModel(status: "ERROR", message: "Error $e", data: null);
    }
  }
}