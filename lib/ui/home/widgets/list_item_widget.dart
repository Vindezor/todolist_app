import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/home/home_controller.dart';
import 'package:login_app/ui/home/widgets/edit_item.dart';
import 'package:login_app/widgets/global_alert.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem(
    {
      Key? key,
      required this.id,
      required this.text
    }
  ) : super(key: key);

  final String text;
  final String id;

  @override
  Widget build(BuildContext context) {
    //final controller = Provider.of<HomeController>(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            spreadRadius: 0.1,
          )
        ],
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(5.0))
      ),
      margin: const EdgeInsets.only(top: 8, left: 5, right: 5),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20
            ),
          ),
          Row(
            children: [
              CupertinoButton(
                child: const Icon(
                  Icons.edit,
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => EditItem(this, context)
                ),
              ),
              CupertinoButton(
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () => 
                  globalAlert(
                    context,
                    msg: "¿Desea eliminar este item?",
                    title: "Importante",
                    acceptOnPressed: () {
                      Provider.of<HomeController>(context, listen: false).deleteItem(id, context);
                      Navigator.pop(context);
                    }
                  )//controller.deleteItem(this, context),
              ),
            ],
          )
        ],
      ),
    );
  }
}