import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register_controller.dart';

class RegisterCamps extends StatefulWidget {
  const RegisterCamps({ Key? key }) : super(key: key);

  @override
  State<RegisterCamps> createState() => _RegisterCampsState();
}

class _RegisterCampsState extends State<RegisterCamps> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TapGestureRecognizer tapGesture = TapGestureRecognizer();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RegisterController>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                maxLength: 254,
                controller: controller.emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  label: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
                validator: controller.validateEmail,
                onChanged: (_) => _formKey.currentState!.validate(),
              ),
            ],
          ),
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
              "Register",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: (controller.enableButton())
            ? () async {
                await controller.register(context);
            }
            : null,
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "¿Ya tienes cuenta? ",
                  style: TextStyle(
                    color: Colors.black
                  )
                ),
                TextSpan(
                  text: "Inicia sesión aquí",
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline
                  ),
                  recognizer: tapGesture..onTap =() {
                    Navigator.of(context).pop();
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