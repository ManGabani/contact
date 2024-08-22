import 'package:contact/constants/strings.dart';
import 'package:contact/controller/Database/database-controller.dart';
import 'package:contact/controller/local-stroage-controller/local_storage_controller.dart';
import 'package:contact/model/credential.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AuthController extends GetxController {


  var logusernameError = Rx<String?>(null);
  var logpasswordError = Rx<String?>(null);
  final logusernameCtrl = TextEditingController();
  final logpasswordCtrl = TextEditingController();


  final regnameCtrl = TextEditingController();
  final regemailCtrl = TextEditingController();
  final regusernameCtrl = TextEditingController();
  final regpasswordCtrl = TextEditingController();


  final firstnameCtrl = TextEditingController();
  final lastnamedCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phonenumberCtrl = TextEditingController();

  var regnameError = Rx<String?>(null);
  var regemailError = Rx<String?>(null);
  var regusernameError = Rx<String?>(null);
  var regpasswordError = Rx<String?>(null);

  Database? database;
   Databsecontroller? data;
  Credential? user;
  LocalStorage? storage;

  Future<Credential?> currentUser() async{
    storage = await LocalStorage.initilize();
    // storage!.clear();
    user=storage!.getUser(key: 'user');
    return user;
  }

  @override
  void onInit(){
    super.onInit();
    initilize();
  }


  Future<void> validator(context, Credential crd) async {
    if (regusernameCtrl.text
        .trim()
        .isEmpty) {
      regnameError.value = Constants.emptyFilledError;
    }
    else {
      regnameError.value = null;
    }


    if (regemailCtrl.text
        .trim()
        .isEmpty) {
      regemailError.value = Constants.emptyFilledError;
    }
    else {
      regemailError.value = null;
    }


    if (regusernameCtrl.text
        .trim()
        .isEmpty) {
      regusernameError.value = Constants.emptyFilledError;
    }
    else {
      regusernameError.value = null;
    }


    if (regpasswordCtrl.text
        .trim()
        .isEmpty) {
      regpasswordError.value = Constants.emptyFilledError;
    } else {
      regpasswordError.value = null;
    }

    if (regnameError.value == null || regemailError.value == null ||
        regusernameError.value == null || regpasswordError.value == null) {
      await data?.registeruser(crd);

      //  print(data.registeruser(crd));
      Navigator.pushNamed(context, Constants.loginRoute);
    }

    regnameCtrl.clear();
    regemailCtrl.clear();
    regusernameCtrl.clear();
    regpasswordCtrl.clear();
  }


  validator1(context) {
    if (logusernameCtrl.text
        .trim()
        .isEmpty) {
      logusernameError.value = Constants.emptyFilledError;
    }
    else {
      logusernameError.value = null;
    }


    if (logpasswordCtrl.text
        .trim()
        .isEmpty) {
      logpasswordError.value = Constants.emptyFilledError;
    } else {
      logpasswordError.value = null;
    }
  }


  @override
  Future<void> initilize() async{
     data=await Databsecontroller.databasescreate();
  }


  void loginuser(context) async {
    if (logusernameError.value == null || logpasswordError.value == null) {
      user = await data?.loginuser(username: logusernameCtrl.text.trim(),
          password: logpasswordCtrl.text.trim());


      if (user != null) {
        String strCredential = user.toString();
        storage!.saveuser(key: 'user', value: strCredential).then((_) =>
            Navigator.pushNamedAndRemoveUntil(
                context, Constants.homeRoute, (route) => false));
        // Navigator.pushNamed(context, Constants.homeRoute);
      }
      else {
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
            title: Text(
              'Something Went Wrong', style: TextStyle(color: Colors.red),),
            content: Text('Invalid Username and Password'),
          );
        },);
      }
    }
  }


}