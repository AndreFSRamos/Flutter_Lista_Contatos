import 'package:flutter/material.dart';
import 'package:lista_de_contatos/helpers/contact_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper contactHelper = ContactHelper();
  List<Contact> listContact = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      contactHelper.getAllContacts().then((value) {
        listContact = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
    );
  }

  contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
