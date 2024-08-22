import 'package:contact_book/constants/strings.dart';
import 'package:contact_book/controllers/route-controllers/route_controllers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ContactBookApp());

class ContactBookApp extends StatelessWidget {
  const ContactBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteController.onGenerateRoute,
      initialRoute: StringConstants.splashRoute,
    );
  }
}
