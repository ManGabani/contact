import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/credential.dart';

class ContactWidget extends StatelessWidget {
  final Addcontact contact;
  final void Function()? onUpdate;
  final void Function()? onDelete;

  ContactWidget(
      {super.key,
      required this.contact,
      required this.onDelete,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: PopupMenuButton(
        onSelected: (value) {
          if (value == 1 && onUpdate != null) {
            onUpdate!();
          } else if (onDelete != null) {
            onDelete!();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text("Update"),
            value: 1,
          ),
          PopupMenuItem(
            child: Text("Delete"),
            value: 2,
          ),
        ],
      ),
      title: Text(contact.firstname,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
      subtitle: Text(contact.phonenumber,
          style: const TextStyle(fontSize: 12, color: Colors.black)),
    );
  }
}
