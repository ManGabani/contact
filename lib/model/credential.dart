
import 'dart:convert';

class Credential {
  int? id;
  String name;
  String email;
  String username;
  String password;

  Credential({
    this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.password,
  });

  factory Credential.fromJson(Map json) {
    return Credential(
      id: json['id']??'unknown',
      name: json['name'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      username: json['username'] ?? 'unknown',
      password: json['password'] ?? 'unknown',
    );
  }

  Map tomap(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'username':username,
      'password':password,
    };
  }

  @override
  String toString(){
return jsonEncode(tomap());
  }
}

class Addcontact{
  int? id;
  int? userid;
  String firstname;
  String lastname;
  String email;
  String phonenumber;

  Addcontact({
    this.id,
    this.userid,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phonenumber,
  });

  factory Addcontact.fromJson(Map json) {
    return Addcontact(
      id: json['id']??'unknown',
      userid: json['userid']??'unknown',
      firstname: json['firstname'] ?? 'unknown',
      lastname: json['lastname'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      phonenumber:json['phonenumber'] ?? 'unknown',
    );
  }

  Map tomap(){
    return {
      'id':id,
      'userid':userid,
      'firstname':firstname,
      'lastname':lastname,
      'email':email,
      'phonenumber':phonenumber,
    };

  }
  @override
  String toString(){
    return jsonEncode(tomap());
  }
}