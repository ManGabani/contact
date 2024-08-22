import 'dart:convert';

import 'package:contact/model/credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static SharedPreferences? sp;

  LocalStorage._();

  static Future<LocalStorage> initilize() async{
    sp=await SharedPreferences.getInstance();
    return LocalStorage._();
  }


  Future<void> saveuser({required String key, required String value}) async{
await sp!.setString(key,value);
  }


  Credential? getUser({required String key}) {
    String? strCredential =
    sp!.getString(key);

    if(strCredential!=null)
      {
        Map json=jsonDecode(strCredential);
        return Credential.fromJson(json);
      }
    return null;
  }


  void clear(){
    sp!.clear();
  }
}
