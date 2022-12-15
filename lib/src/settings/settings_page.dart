import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_list/src/core/auth/controllers/auth_controller.dart';
import 'package:grocery_list/src/locked/locked_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final authController = Get.find<AuthController>();

  bool isSwitched = GetStorage().read(AuthController().keyLocal) ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: isSwitched,
            title: const Text("Enable biometric authentication"),
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                authController.enableDisableLocal(value);
              });
            },
          ),
          ElevatedButton(
            onPressed: () => {
              Get.offAll(() => const LockedPage()),
            },
            child: const Text('Lock App'),
          ),
        ],
      ),
    );
  }
}
