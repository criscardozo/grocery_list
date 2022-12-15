import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_list/src/core/auth/controllers/auth_controller.dart';
import 'package:grocery_list/src/home/pages/home_page.dart';

class LockedPage extends StatelessWidget {
  const LockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery List"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Unlock the app to enter"),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: authenticate,
            child: const Text('Unlock'),
          ),
        ]),
      ),
    );
  }

  void authenticate() async {
    final authenticated = await Get.find<AuthController>().authenticate();
    if (authenticated) {
      Get.offAll(() => const HomePage(), arguments: true);
      // Get.to(() => const HomePage());
    }
  }
}
