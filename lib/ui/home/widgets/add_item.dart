import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';
import '../home_controller.dart';

class AddItemWidget extends StatefulWidget {
  AddItemWidget(this.contextIn, {Key? key}) : super(key: key);

  BuildContext contextIn;

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(widget.contextIn);
    return AlertDialog(
      title: const Text("Añadir elemento"),
      content: TextField(
        onChanged: (_) => setState(() {
          
        }),
        maxLength: 20,
        controller: _textController,
        decoration: InputDecoration(
          hintText: "Introduzca el elemento",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
              width: 3.0,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar",
            style: TextStyle(
              fontSize: 18,
              color: primaryColor,
            ),
          )
        ),
        TextButton(
          onPressed: () async {
            if(_textController.text.isNotEmpty){
              Navigator.pop(context);
              controller.addItem(_textController.text, widget.contextIn);
            }
          },
          child: Text("Aceptar",
            style: TextStyle(
              fontSize: 18,
              color: _textController.text.isEmpty ? Colors.grey : primaryColor,
            ),
          )
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround
    );
  }
}