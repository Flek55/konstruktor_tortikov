import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 150)),
          Center(
            child: TextButton(onPressed: (){
              Navigator.pushNamed(context, '/login');
            },
                child: const Text("Назад",style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),)),
          ),
        ],
      ),
    );
  }
}
