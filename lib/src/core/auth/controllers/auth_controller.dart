import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  final keyLocal = "LocalAuth";

  void enableDisableLocal(bool enable) async {
    final storage = GetStorage();

    if (enable) {
      final result = await authenticate();
      if (result) storage.write(keyLocal, true);
    } else {
      storage.write(keyLocal, false);
    }
  }

  Future<bool> authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();

    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }
    try {
      final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to access the app');
      return didAuthenticate;
    } on PlatformException {
      Get.defaultDialog(title: "An error occurred");
    }

    return false;
  }
}
