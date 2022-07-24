import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/routes/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({ Key? key }) : super(key: key);

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5)).then(
      (_) async {
        final String? username = await storage.read(key: 'username');
        final String? id = await storage.read(key: 'id');

        if(username != null && id != null){
          Navigator.of(context).pushReplacementNamed(Routes.home);
        } else {
          Navigator.of(context).pushReplacementNamed(Routes.login);
        }
      }
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text("Login App"),
            ],
          ),
        ),
      ),
    );
  }
}