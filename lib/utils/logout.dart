import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/routes/routes.dart';
import 'package:login_app/widgets/global_alert.dart';

void logout(BuildContext context){
  const FlutterSecureStorage storage = FlutterSecureStorage();
  globalAlert(
    context,
    msg: "¿Seguro que desea cerrar sesión?",
    title: "Importante",
    acceptOnPressed: () async {
      await storage.delete(key: 'username');
      await storage.delete(key: 'token');
      await storage.delete(key: 'refreshToken');
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false
      );
    }
  );
}