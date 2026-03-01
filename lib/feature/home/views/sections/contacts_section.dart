import 'package:flutter/material.dart';
import 'package:qunova/feature/home/models/data_model.dart';

class ContactsSection extends StatefulWidget {
  ContactsSection({super.key, required this.contacts});

  List<Contact>? contacts;

  @override
  State<ContactsSection> createState() => _ContactsSectionState();
}

class _ContactsSectionState extends State<ContactsSection> {
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: widget.contacts!.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final contact = widget.contacts?[index];

        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(contact!.avatarUrl.toString(),),
                fit: BoxFit.cover,
              ),
              shape: OvalBorder(),
            ),
          ),
          title: Text(
            contact!.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            contact!.phone.toString(),
            style: const TextStyle(color: Colors.black54),
          ),
          onTap: () {},
        );
      },
    );
  }
}
