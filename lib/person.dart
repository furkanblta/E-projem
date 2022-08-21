import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testproject/components/header.dart';

class PersonPage extends StatefulWidget {
  //const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        header('Sayfam', context),
        Text(user.email!),
      ],
    ));
  }
}
