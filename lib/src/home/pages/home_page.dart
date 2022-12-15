import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_list/src/core/auth/controllers/auth_controller.dart';
import 'package:grocery_list/src/home/controllers/home_controller.dart';
import 'package:grocery_list/src/locked/locked_page.dart';
import 'package:grocery_list/src/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();
  final fromLocked = Get.arguments ?? false;

  @override
  void initState() {
    super.initState();
    if (!fromLocked) {
      checkLocal();
    }
  }

  void checkLocal() async {
    final localAuth = GetStorage().read("LocalAuth") ?? false;
    bool authenticated = false;

    if (localAuth) {
      authenticated = await Get.find<AuthController>().authenticate();
    }

    if (localAuth && !authenticated) {
      Get.offAll(() => const LockedPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery List"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(() => const SettingsPage());
            },
          )
        ],
      ),
      body: Obx(
        () => homeController.items.isEmpty
            ? const Center(
                child: Text("No Items!"),
              )
            : ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: homeController.items.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(homeController.items[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => homeController.removeItem(index),
                    ),
                  ));
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newItem,
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _newItem() async => homeController.addItem(await _showTextInputDialog(context));

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Item'),
            content: TextField(
              controller: homeController.textFieldController,
              decoration: const InputDecoration(hintText: "What do you need to buy?"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  homeController.textFieldController.clear();
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () => Navigator.pop(context, homeController.textFieldController.text),
              ),
            ],
          );
        });
  }
}
