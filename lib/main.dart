import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/strings.dart';
import 'controller/route-controller/routh_controller.dart';

void main() => runApp(const ContactBookApp());

class ContactBookApp extends StatelessWidget {
  const ContactBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteController.onGenerateRoute,
      initialRoute: Constants.splashRoute,
    );
  }
}
