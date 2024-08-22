import 'package:contact/controller/Database/database-controller.dart';
import 'package:contact/model/credential.dart';
import 'package:get/get.dart';

import 'auth-controllers/auth-controller.dart';

class ContactController extends GetxController {
  RxList<Addcontact> contacts = <Addcontact>[].obs;
  RxList<Addcontact> _mainContacts = <Addcontact>[].obs;
  final RxBool _searching = false.obs;

  set searching(bool value) {
    _searching.value = value;
  }

  bool get searching => _searching.value;
  final authCtrl = Get.find<AuthController>();

  @override
  void onInit() {
    viewContact();
    super.onInit();
  }

  Future<void> addContacts(Addcontact? addCredetial) async {
    if (addCredetial != null) {
      Databsecontroller contactDatabase  =
          await Databsecontroller.databasescreate();
      contactDatabase.addcontact(con: addCredetial, userid: authCtrl.user!.id);
      contacts.add(addCredetial);
      _mainContacts.add(addCredetial);
    }
  }

  Future<void> viewContact() async {
    Databsecontroller contactDatabase =
        await Databsecontroller.databasescreate();
    var contactsJson = await contactDatabase.viewContacts(authCtrl.user!.id!);
    contacts.value = contactsJson
        .map((contact) => Addcontact.fromJson(contact.tomap()))
        .toList();

    _mainContacts.addAll(contacts);
  }

  Future<void> updateContact(Addcontact? contact) async {
    Databsecontroller contactDatabase =
        await Databsecontroller.databasescreate();
    contactDatabase.updateContact(contact!);
  }

  Future<void> deleteContact({required int index}) async {
    // Databsecontroller contactDatabase =
    //     await Databsecontroller.databasescreate();

    contacts.removeAt(index);

    // int? ContctsId = contacts[index].id;
    //
    // if (ContctsId != null) {
    //   contactDatabase.deleteContact(ContctsId).then((_) {
    //     contacts.removeAt(index);
    //     _mainContacts.removeAt(index);
    //   });
    // }
  }

  void searchContact(String value) {
    contacts.clear();
    if (value.isNotEmpty) {
      contacts.addAll(_mainContacts.where((contact) =>
          contact.firstname.toLowerCase().contains(value.toLowerCase())));
    }
  }

  void resetContacts() {
    contacts.addAll(_mainContacts);
  }
}
