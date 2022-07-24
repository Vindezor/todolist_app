import 'package:flutter/material.dart';

void globalLoading(BuildContext context){
  showDialog(
    context: context,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
    barrierDismissible: false,
  );
}