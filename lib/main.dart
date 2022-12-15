import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_list/initial_bindings.dart';

import 'src/home/pages/home_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const GroceryListApp());
}

class GroceryListApp extends StatelessWidget {
  const GroceryListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialBinding: InitialBindings(),
      home: const HomePage(),
    );
  }
}
