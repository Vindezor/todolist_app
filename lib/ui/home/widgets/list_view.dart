import 'package:flutter/material.dart';
import 'package:login_app/ui/home/home_controller.dart';
import 'package:provider/provider.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({ Key? key }) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return (controller.isLoading)
        ? const Center(
            child: CircularProgressIndicator(
              //color: primaryColor,
            ),
          )
        : (controller.isError)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Error de conexion",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  TextButton(
                    onPressed: () => controller.loadList(), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Reitentar",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.refresh),
                      ],
                    ),
                  )
                ],
              ),
            )
          : (controller.toDoList.isNotEmpty)
            ? Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 70),
                children: List<Widget>.from(controller.toDoList),
              ),
            )
            : const Center(
                child: Text(
                  "La lista esta vacia",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              );
  }
}