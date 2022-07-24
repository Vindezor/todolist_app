import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:login_app/models/login_model.dart';
import 'package:login_app/services/utils/global_ip.dart';

import '../models/register_model.dart';

class RegisterService{
  final Dio _dio;

  RegisterService(this._dio);

  Future<RegisterModel> register(String email, String username, String password)async {
    try{
      final response = await _dio.post(
        "$ip/api/v1/signup",
        data: {
          "username": username,
          "password": password,
          "email": email,
        },
      );
      final resp = RegisterModel.fromJson(response.data);
      return resp;
    } on DioError catch(e){
      if(e.type == DioErrorType.connectTimeout){
        return RegisterModel(status: "ERROR", message: "Error del servidor", data: null);
      }
      if(e.type == DioErrorType.other){
        return RegisterModel(status: "ERROR", message: "Sin conexión a internet", data: null);
      }
      return RegisterModel(status: "ERROR", message: "Error $e", data: null);
    }
  }
}