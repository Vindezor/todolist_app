import 'package:flutter/material.dart';
import 'package:login_app/ui/home/widgets/list_item_widget.dart';
import 'package:login_app/widgets/global_loading.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';
import '../home_controller.dart';

class EditItem extends StatefulWidget {
  const EditItem(this.item, this.contextIn, { Key? key }) : super(key: key);
  final ListItem item;
  final BuildContext contextIn;
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final TextEditingController _textController = TextEditingController();
  late String text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text = widget.item.text;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(widget.contextIn);
    return AlertDialog(
      title: const Text("Editar elemento"),
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
          onPressed: () {
            if(_textController.text.isNotEmpty){
              Navigator.pop(context);
              controller.editItem(
                widget.item.id,
                _textController.text,
                controller.toDoList.indexOf(widget.item),
                widget.contextIn,
              );
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

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    super.dispose();
  }
}