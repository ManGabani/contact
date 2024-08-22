import 'package:contact/model/credential.dart';
import 'package:contact/views/screen/home_screen.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

  class Databsecontroller {
   static Database? _database;

   Databsecontroller._();



   static Future<Databsecontroller> databasescreate() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE contact(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,username TEXT,password TEXT)');
      await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT,userid INTEGER,firstname TEXT,lastname TEXT,email TEXT,phonenumber TEXT)');
    });
    return Databsecontroller._();
  }

  Future<void> registeruser(Credential credential) async {
    String sql =
        "INSERT INTO contact(name,email,username,password) VALUES('${credential.name}','${credential.email}','${credential.username}','${credential.password}')";
    _database!.execute(sql);

    print(sql);
  }



  Future<Credential?> loginuser(
      {required String username, required String password}) async {
    String sql =
        "SELECT * FROM contact WHERE username='$username' AND password='$password'";
    List<Map<String, Object?>> data = await _database!.rawQuery(sql);

    if (data.isNotEmpty) {
      return Credential.fromJson(data[0]);
    }
  }

   Future<void> addcontact({required Addcontact con,required int? userid})async {
    String sql="INSERT INTO user(userid,firstname,lastname,email,phonenumber) VALUES('${userid}','${con.firstname}','${con.lastname}','${con.email}','${con.phonenumber}')";
    await _database!.execute(sql);
  }

   Future<int> updateContact(Addcontact con) {
     String sql="UPDATE user SET firstname='${con.firstname}',phonenumber='${con.phonenumber}' WHERE id='${con.id}'";
     return  _database!.rawUpdate(sql);
   }



   Future<void> deleteContact(int id) {
     String sql = "DELETE FROM user WHERE id = '$id'";
     return _database!.execute(sql);
   }







  Future<List<Addcontact>> viewContacts(int userid) async {
    String sql = "SELECT * FROM user   WHERE userid = '$userid'";
    List<Map> contacts= await _database!.rawQuery(sql);

    if(contacts.isNotEmpty)
      {
        return contacts.map((e) => Addcontact.fromJson(e)).toList();
      }
    else
      {
        return [];
      }

  }

}
