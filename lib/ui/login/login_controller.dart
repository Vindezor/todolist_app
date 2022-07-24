import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/routes/routes.dart';
import 'package:login_app/widgets/global_loading.dart';

import '../../services/login_service.dart';
import '../../widgets/global_alert.dart';

class LoginController extends ChangeNotifier{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  RegExp usernameRegExp = RegExp(r'^[A-Za-z0-9]{5,}$');
  RegExp passwordRegExp = RegExp(
    r'^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[\.,!@#$%^&*])[\w\.,!@#$%^&*]{8,}$'
  );

  bool hidePassword = true;
  
  String? validateUsername(String? username){
    notifyListeners();
    if(username != null){
      if(usernameRegExp.hasMatch(username)){
        return null;
      }
    } 
    return "Usuario invalido";
  }

  String? validatePassword(String? password){
    notifyListeners();
    if(password != null){
      if(passwordRegExp.hasMatch(password)){
        return null;
      }
    } 
    return "Clave invalida";
  }

  void changeHidePassword(){
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool enableButton(){
    if(usernameRegExp.hasMatch(usernameController.text) && 
      passwordRegExp.hasMatch(passwordController.text)){
      
      return true;
    }
    return false;
  }

  Future<void> login(BuildContext context) async {
    globalLoading(context);
    final response = await LoginService(Dio()).login(
      usernameController.text,
      passwordController.text,
    );
    if(response.status == "ERROR"){
      Navigator.of(context).pop();
      globalAlert(context, msg: response.message, title: "Importante");
    }else{
      await storage.write(key: 'username', value: usernameController.text);
      await storage.write(key: 'token', value: response.data!.token);
      await storage.write(key: 'refreshToken', value: response.data!.refreshToken);
      await storage.write(key: 'id', value: response.data!.id);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.home);
    }
  }
}