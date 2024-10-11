  import 'package:contact/constants/colors.dart';
  import 'package:contact/constants/strings.dart';
  import 'package:contact/controller/auth-controllers/auth-controller.dart';
  import 'package:contact/controller/contact_controller.dart';
  import 'package:contact/controller/local-stroage-controller/local_storage_controller.dart';
  import 'package:contact/model/Lisrstroage.dart';
  import 'package:contact/model/credential.dart';
  import 'package:contact/views/widget/form/contact_form.dart';
  import 'package:contact/views/widget/inputs/custom_input.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';


  class HomeScreen extends StatelessWidget with Lists {
    HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final AuthController ctrl = Get.find<AuthController>();

      final ContactController conctrl = Get.put(ContactController());

      LocalStorage? storage;

      return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            if (conctrl.searching) {
              return TextField(
                autofocus: true,
                onChanged: conctrl.searchContact,
                decoration: InputDecoration(
                    hintText: 'Search Contacts',
                    suffix: IconButton(
                      onPressed: () {
                        conctrl.resetContacts();
                        conctrl.searching = false;
                      },
                      icon: Icon(Icons.close),
                    )),
              );
            } else {
              return Text('Contact Book');
            }
          }),
          actions: [
            Obx(() => Visibility(
                visible: !conctrl.searching,
                child: IconButton(
                    onPressed: () {
                      conctrl.contacts.clear();
                      conctrl.searching = true;
                    },
                    icon: Icon(Icons.search)))),
            Obx(() => Visibility(
              visible: !conctrl.searching,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          'Add Contact',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomInput(
                                labelText: 'First Name',
                                controller: ctrl.firstnameCtrl,
                              ),
                              SizedBox(height: 15),
                              CustomInput(
                                labelText: 'Last Name',
                                controller: ctrl.lastnamedCtrl,
                              ),
                              SizedBox(height: 15),
                              CustomInput(
                                labelText: 'Email',
                                controller: ctrl.emailCtrl,
                              ),
                              SizedBox(height: 15),
                              CustomInput(
                                labelText: 'Phone Number',
                                controller: ctrl.phonenumberCtrl,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Cancel', style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () {
                              conctrl.addContacts(
                                Addcontact(
                                  firstname: ctrl.firstnameCtrl.text.trim(),
                                  lastname: ctrl.lastnamedCtrl.text.trim(),
                                  email: ctrl.emailCtrl.text.trim(),
                                  phonenumber: ctrl.phonenumberCtrl.text.trim(),
                                ),
                              );
                              Navigator.of(context).pop(); // Close dialog after saving

                            },
                            child: Text('Save', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      );
                    },
                  );
                  ctrl.firstnameCtrl.clear();
                  ctrl.lastnamedCtrl.clear();
                  ctrl.emailCtrl.clear();
                  ctrl.phonenumberCtrl.clear();
                  },

                icon: Icon(Icons.add),
              ),
            )),

            SizedBox(
              width: 20,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'User Detail',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  'ID : ${ctrl.user!.id}',
                  style: TextStyle(color: ColorConst.textColor, fontSize: 20),
                )),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  'User : ${ctrl.user!.name}',
                  style: TextStyle(color: ColorConst.textColor, fontSize: 20),
                )),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  'Username : ${ctrl.user!.username}',
                  style: TextStyle(color: ColorConst.textColor, fontSize: 20),
                )),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  'Email : ${ctrl.user!.email}',
                  style: TextStyle(color: ColorConst.textColor, fontSize: 20),
                )),
              ),
              ListTile(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, Constants.ScreenRoute, (route) => false),
                title: Center(
                    child: Text(
                  'Log Out',
                  style: TextStyle(color: ColorConst.textColor, fontSize: 20),
                )),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              height: double.infinity,
              width: double.infinity,
              'asset/image/back.png',
              fit: BoxFit.cover,
            ),
            Obx(() => ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                  ),
                  itemCount: conctrl.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = conctrl.contacts[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: () {
                          _callNumber(contact.phonenumber);
                        },
                        leading: CircleAvatar(
                          child: Text(
                            contact.firstname[0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        title: Text(
                          contact.firstname,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          contact.phonenumber,
                          style: TextStyle(color: Colors.black),
                        ),

                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              showEditContactDialog(context, conctrl, ctrl, index);
                            } else if (value == 'delete') {
                              conctrl.deleteContact(index: index);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.black),
                                  SizedBox(width: 10),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.black),
                                  SizedBox(width: 10),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );


                  },
                )),
          ],
        ),
      );
    }
  }

  final AuthController ctrl = Get.find<AuthController>();

  void contactform(BuildContext context,
      {required void Function(Addcontact? contact) onSave}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Contactform(
          onSave: onSave,
          firstnameCtrl: ctrl.firstnameCtrl,
          phonenumberCtrl: ctrl.phonenumberCtrl),
    );
  }

  class Contact {
    final String name;
    final String number;
    int? id;

    Contact({required this.name, required this.number, this.id = -1});

    factory Contact.fromJson(Map<String, dynamic> json) {
      return Contact(
        name: json['name'] ?? 'unknown',
        number: json['number'] ?? 'unknown',
        id: json['id'] ?? -1,
      );
    }
  }

  void showEditContactDialog(BuildContext context, ContactController conctrl, AuthController ctrl, int index) {
    ctrl.firstnameCtrl.text = conctrl.contacts[index].firstname;
    ctrl.phonenumberCtrl.text = conctrl.contacts[index].phonenumber;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Edit Contact',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                labelText: 'First Name',
                controller: ctrl.firstnameCtrl,
              ),
              SizedBox(height: 15),
              CustomInput(
                labelText: 'Phone Number',
                controller: ctrl.phonenumberCtrl,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Addcontact updatedContact = Addcontact(
                  firstname: ctrl.firstnameCtrl.text.trim(),
                  phonenumber: ctrl.phonenumberCtrl.text.trim(),
                  lastname: ctrl.lastnamedCtrl.text.trim(),
                  email: ctrl.emailCtrl.text.trim(),
                );
                updatedContact.id = conctrl.contacts[index].id;

                conctrl.updateContact(updatedContact).then((_) {
                  conctrl.contacts[index] = updatedContact;
                  Navigator.of(context).pop();
                });
              },
              child: Text('Save', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
    _callNumber(String phoneNumber) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (res == null || !res) {
      print('Call failed');
    } else {
      print('Call successful');
    }
  }

