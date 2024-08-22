import 'package:contact/constants/colors.dart';
import 'package:contact/constants/strings.dart';
import 'package:contact/controller/auth-controllers/auth-controller.dart';
import 'package:contact/controller/contact_controller.dart';
import 'package:contact/controller/local-stroage-controller/local_storage_controller.dart';
import 'package:contact/model/Lisrstroage.dart';
import 'package:contact/model/credential.dart';
import 'package:contact/views/widget/buttons/custom_buttons/savebutton.dart';
import 'package:contact/views/widget/form/contact_form.dart';
import 'package:contact/views/widget/inputs/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grouped_list/grouped_list.dart';

import '../widget/contact_widget/Contact_Widget.dart';

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
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          var keyboard =
                              MediaQuery.of(context).viewInsets.bottom;
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  15, 50, 15, 15 + keyboard),
                              child: Column(
                                children: [
                                  Text(
                                    'ADD CONTACT',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomInput(
                                    labelText: 'First Name',
                                    controller: ctrl.firstnameCtrl,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomInput(
                                    labelText: 'Last Name',
                                    controller: ctrl.lastnamedCtrl,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomInput(
                                    labelText: 'Email',
                                    controller: ctrl.emailCtrl,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomInput(
                                    labelText: 'Phone Number',
                                    controller: ctrl.phonenumberCtrl,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      addbutton(
                                        title: 'Cancle',
                                        onPressed: () => Text('Cancle'),
                                      ),
                                      addbutton(
                                        title: 'Save',
                                        onPressed: () {
                                          conctrl.addContacts(
                                            Addcontact(
                                                firstname: ctrl
                                                    .firstnameCtrl.text
                                                    .trim(),
                                                lastname: ctrl
                                                    .lastnamedCtrl.text
                                                    .trim(),
                                                email:
                                                    ctrl.emailCtrl.text.trim(),
                                                phonenumber: ctrl
                                                    .phonenumberCtrl.text
                                                    .trim()),
                                          );

                                          ctrl.firstnameCtrl.clear();
                                          ctrl.lastnamedCtrl.clear();
                                          ctrl.emailCtrl.clear();
                                          ctrl.phonenumberCtrl.clear();


                                          Navigator.pushReplacementNamed(
                                              context, Constants.homeRoute);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add)),
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
      body: Obx(
        () => GroupedListView<Addcontact, String>(
            shrinkWrap: true,
            sort: true,
            elements: conctrl.contacts.value,
            groupBy: (contact) => contact.firstname[0].toUpperCase(),
            groupSeparatorBuilder: (String groupByvalue) {
              return ListTile(
                title: Text(groupByvalue, style: const TextStyle(fontSize: 15)),
              );
            },
            itemBuilder: (context, contact) {
              int index = conctrl.contacts.indexOf(contact);
              return ContactWidget(
                contact: contact,
                onUpdate: () {
                  ctrl.firstnameCtrl.text = conctrl.contacts[index].firstname;
                  ctrl.phonenumberCtrl.text =
                      conctrl.contacts[index].phonenumber;



                  contactform(context, onSave: (contact) {
                    contact!.id = conctrl.contacts[index].id;
                    conctrl.updateContact(contact).then((_) {
                      conctrl.contacts[index] = contact;
                    });
                  });
                },
                onDelete: () => conctrl.deleteContact(index: index),
              );
            }),
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
