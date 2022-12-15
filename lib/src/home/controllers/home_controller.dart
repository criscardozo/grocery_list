import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  final textFieldController = TextEditingController();
  final _keyItems = "Items";
  RxList items = [].obs;

  HomeController() {
    final savedIt = storage.read(_keyItems);
    items.assignAll(savedIt ?? []);
  }

  void addItem(String? item) {
    if (item != null) {
      items.add(item);
      storage.write(_keyItems, items);
      textFieldController.clear();
    }
  }

  void removeItem(int pos) {
    items.removeAt(pos);
    storage.write(_keyItems, items);
  }
}
