import 'package:contact/constants/strings.dart';
import 'package:contact/views/widget/lottie/splash_lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../controller/auth-controllers/auth-controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    ctrl.currentUser().then((credential)   {
      if (credential == null) {
        Navigator.pushNamed(context, Constants.loginRoute);
      } else {
        Navigator.pushNamed(context, Constants.homeRoute);
      }
    });
    return const Scaffold(body: Center(child: SplashLottie()  ));
  }
}
