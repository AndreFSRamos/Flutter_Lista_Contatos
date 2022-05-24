import 'package:flutter/material.dart';
import 'package:lista_de_contatos/helpers/contact_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper contactHelper = ContactHelper();

  @override
  void initState() {
    super.initState();

    Contact c = Contact();

    c.name = "André";
    c.email = "andre@teste.com";
    c.phone = "5465465465";
    c.image = "imgTeste";

    contactHelper.saveContact(c);

    contactHelper.getAllContacts().then((list) {
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
