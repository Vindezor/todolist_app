import 'package:flutter/material.dart';
import 'package:login_app/ui/home/home_controller.dart';
import 'package:login_app/ui/home/widgets/add_item.dart';
import 'package:login_app/ui/home/widgets/floating_add.dart';
import 'package:login_app/ui/home/widgets/list_view.dart';
import 'package:login_app/utils/logout.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (_) {
            final controller = HomeController();
            controller.loadList();
            return controller;
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          logout(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              IconButton(
                onPressed: () => logout(context),
                icon: const Icon(Icons.logout)
              )
            ],
          ),
          body: const ListViewPage(),
          floatingActionButton: const FloatingAdd()
        ),
      ),
    );
  }
}