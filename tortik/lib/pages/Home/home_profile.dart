import 'package:flutter/material.dart';
import 'package:tortik/Services/auth.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 200)),
          TextButton(style: TextButton.styleFrom(
            disabledForegroundColor: Colors.deepPurple.withOpacity(0.38),
          ),onPressed: () {
            _authService.signOut();
            Navigator.pushNamedAndRemoveUntil(context, "/logger", (r) => false);
          },child: const Text("Выйти",
            style: TextStyle(fontSize: 25, fontFamily: 'Roboto', color: Colors.black),
          ),),
        ],
      ),
    );
  }
}