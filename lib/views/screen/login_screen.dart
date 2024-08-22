import 'package:contact/constants/strings.dart';
import 'package:contact/controller/auth-controllers/auth-controller.dart';
import 'package:contact/views/widget/buttons/custom_buttons/custom_button.dart';
import 'package:contact/views/widget/buttons/text_buttons/text_button.dart';
import 'package:contact/views/widget/inputs/custom_input.dart';
import 'package:contact/views/widget/text/header_text.dart';
import 'package:contact/views/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
padding: EdgeInsetsDirectional.all(15),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const HeaderText(title: Constants.logintitle),
              const SizedBox(
                height:20,
              ),
              const SizedBox(
                height:20,
              ),
              Obx(
                () => CustomInput(
                  labelText: 'UserName',
                  controller: ctrl.logusernameCtrl,
                  errorText: ctrl.logusernameError.value,
                ),
              ),
              const SizedBox(
                height:20,
              ),
              Obx(
                () => CustomInput(
                  labelText: 'Password',
                  controller: ctrl.logpasswordCtrl,
                  errorText: ctrl.logpasswordError.value,
                ),
              ),
              const SizedBox(
                height:30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TitleText(title: 'New User?'),
                  const SizedBox(
                    height:10,
                  ),
                  BuildTextButton(
                    text: 'Create Account',
                    onTap: () {
                      Navigator.pushNamed(context, Constants.registerRoute);
                    },
                  ),
                ],
              ),
              const SizedBox(height:40,),
              CustomButton(title: 'Login', onPressed:() {
                ctrl.validator1(context);
                ctrl.loginuser(context);

                ctrl.logusernameCtrl.clear();
                ctrl.logpasswordCtrl.clear();


              },)
            ],
          ),
        ),
      ),
    );
  }
}
