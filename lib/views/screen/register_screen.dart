import 'package:contact/constants/strings.dart';
import 'package:contact/controller/auth-controllers/auth-controller.dart';
import 'package:contact/model/credential.dart';
import 'package:contact/views/widget/buttons/custom_buttons/custom_button.dart';
import 'package:contact/views/widget/buttons/text_buttons/text_button.dart';
import 'package:contact/views/widget/inputs/custom_input.dart';
import 'package:contact/views/widget/text/header_text.dart';
import 'package:contact/views/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/Database/database-controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();
    // databsecontroller data = databsecontroller();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.all(15),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const HeaderText(title: Constants.registertitle),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  labelText: 'Name',
                  controller: ctrl.regnameCtrl,
                  errorText: ctrl.regnameError.value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  labelText: 'Email',
                  controller: ctrl.regemailCtrl,
                  errorText: ctrl.regemailError.value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  labelText: 'UserName',
                  controller: ctrl.regusernameCtrl,
                  errorText: ctrl.regusernameError.value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  labelText: 'Password',
                  controller: ctrl.regpasswordCtrl,
                  errorText: ctrl.regpasswordError.value,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TitleText(title: 'Already have an Account?'),
                  const SizedBox(
                    height: 5,
                  ),
                  BuildTextButton(
                    text: 'Login',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                title: 'Register',
                onPressed: () {
                  print('+++++++++> ${ctrl.regnameCtrl.text.trim()}');


                  ctrl.validator(
                      context,
                      Credential(
                          name: ctrl.regnameCtrl.text.trim(),
                          email: ctrl.regemailCtrl.text.trim(),
                          username: ctrl.regusernameCtrl.text.trim(),
                          password: ctrl.regpasswordCtrl.text.trim()));

                  ctrl.logusernameCtrl.clear();
                  ctrl.logpasswordCtrl.clear();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
