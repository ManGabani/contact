import 'package:contact/model/credential.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen/home_screen.dart';
import '../buttons/custom_buttons/custom_button.dart';
import '../inputs/custom_input.dart';

class Contactform extends StatelessWidget {
  final void Function(Addcontact? contact) onSave;
  final TextEditingController firstnameCtrl;
  final TextEditingController phonenumberCtrl;

  const Contactform({super.key, required this.onSave,
    required this.firstnameCtrl,
    required this.phonenumberCtrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        CustomInput(
          labelText: 'Name',
          controller:firstnameCtrl,
        ),
        SizedBox(height: 15,),
        CustomInput(
          labelText: 'Contact',
          controller:phonenumberCtrl,
        ),
        SizedBox(height: 15,),
        CustomButton(
          title: 'Add Contact',
          onPressed: () {
            Addcontact contact = Addcontact(
              firstname:firstnameCtrl.text,
            lastname:ctrl.lastnamedCtrl.text,
            email: ctrl.emailCtrl.text,
            phonenumber:phonenumberCtrl.text,
            );
                onSave(contact);
            Get.back();
          },
        )
      ],
    );
  }
}
