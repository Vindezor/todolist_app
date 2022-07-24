import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_app/routes/routes.dart';
import 'package:login_app/ui/login/login_controller.dart';
import 'package:login_app/widgets/global_alert.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/login_service.dart';

class LoginCamps extends StatefulWidget {
  const LoginCamps({ Key? key }) : super(key: key);

  @override
  State<LoginCamps> createState() => _LoginCampsState();
}

class _LoginCampsState extends State<LoginCamps> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TapGestureRecognizer tapGesture = TapGestureRecognizer();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            maxLength: 15,
            controller: controller.usernameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              border: OutlineInputBorder(),
              label: Text(
                "Username",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            validator: controller.validateUsername,
            onChanged: (_) => _formKey.currentState!.validate(),
          ),
          TextFormField(
            obscureText: controller.hidePassword,
            maxLength: 18,
            controller: controller.passwordController,
            decoration: InputDecoration(
              icon: const Icon(Icons.password),
              border: const OutlineInputBorder(),
              label: const Text(
                "Password",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              suffixIcon: IconButton(
                onPressed: controller.changeHidePassword,
                icon: const Icon(Icons.remove_red_eye)
              ),
            ),
            validator: controller.validatePassword,
            onChanged: (_) => _formKey.currentState!.validate(),
          ),
          CupertinoButton(
            disabledColor: Colors.grey,
            color: Colors.blue,
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: (controller.enableButton())
            ? () async {
                await controller.login(context);
            }
            : null,
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "¿No tienes cuenta? ",
                  style: TextStyle(
                    color: Colors.black
                  )
                ),
                TextSpan(
                  text: "Registrate aquí",
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline
                  ),
                  recognizer: tapGesture..onTap = () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pushNamed(Routes.register);
                  }
                )
              ]
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tapGesture.dispose();
  }
}