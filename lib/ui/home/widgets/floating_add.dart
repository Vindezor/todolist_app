import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'add_item.dart';

class FloatingAdd extends StatelessWidget {
  const FloatingAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(context: context, builder: (_) => AddItemWidget(context));
      },
    );
  }
}