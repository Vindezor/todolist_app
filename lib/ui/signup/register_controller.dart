import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/routes/routes.dart';

import '../../services/login_service.dart';
import '../../services/register_service.dart';
import '../../widgets/global_alert.dart';

class RegisterController extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  RegExp usernameRegExp = RegExp(r'^[A-Za-z0-9]{5,}$');
  RegExp passwordRegExp = RegExp(
    r'^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[\.,!@#$%^&*])[\w\.,!@#$%^&*]{8,}$'
  );
  RegExp emailRegExp = RegExp(
    r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])'''
  );

  bool hidePassword = true;
  
  String? validateEmail(String? email){
    notifyListeners();
    if(email != null){
      if(emailRegExp.hasMatch(email)){
        return null;
      }
    } 
    return "Correo invalido";
  }

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

  Future<void> register(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false,
    );
    final response = await RegisterService(Dio()).register(
      emailController.text,
      usernameController.text,
      passwordController.text,
    );
    if(response.status == "ERROR"){
      Navigator.of(context).pop();
      globalAlert(context, msg: response.message, title: "Importante");
    }else{
      Navigator.of(context).pop();
      globalAlert(
        context,
        msg: response.message,
        title: "Importante",
        closeOnPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      );
    }
  }
}