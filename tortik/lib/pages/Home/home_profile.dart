import 'package:flutter/material.dart';
import 'package:tortik/Services/auth.dart';
import 'package:tortik/Services/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tortik/main.dart';
import 'package:fluttertoast/fluttertoast.dart';




class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {

  final AuthService _authService = AuthService();
  bool showEmailField = false;
  bool showNameField = false;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            children: const [
              Padding(padding: EdgeInsets.only(left: 40)),
              Text("Профиль",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 60)),
          Row(children: const [
            Padding(padding: EdgeInsets.only(left: 40)),
            Text("Имя",
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 40)),
              Text(CurrentUserData.name,style: const TextStyle(
                fontSize: 25,
              ),),
              IconButton(onPressed: (){
                setState(() {
                  showNameField = !showNameField;
                });
              }, icon: const Icon(Icons.edit),
                splashRadius: 22,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 360,
                height: 50,
                child: showNameField ?(_getDisplayNameField(context,_nameController)):Container(),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(children: const [
            Padding(padding: EdgeInsets.only(left: 40)),
            Text("Email",
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ],
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 40)),
              Text(CurrentUserData.email,
                style: const TextStyle(fontSize: 18,),),
              IconButton(onPressed: (){
                setState(() {
                  showEmailField = !showEmailField;
                });
              }, icon: const Icon(Icons.edit),
                splashRadius: 22,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 360,
                height: 50,
                child: showEmailField ?(_getEmailField(context,_emailController)):Container(),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 33)),
              SizedBox(
                height: 40,child: _getChangePasswordButton(context),
              )
            ],
          ),

          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 33)),
              SizedBox(height: 40,child: _getLogOutButton(context),)
            ],
          ),

        ],
      ),
    );
  }

  _getDisplayNameField(context, displayNameController){
    return TextFormField(
      controller: displayNameController,
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed:() async {
          if (_nameController.text.trim() != "" && _nameController.text.length >= 2) {
            _authService.assignName(_nameController.text.trim());
            setState(() {
              CurrentUserData.name = _nameController.text.trim();
              showNameField = false;
            });
            _nameController.clear();
          }
        } , icon: const Icon(Icons.arrow_forward),style: IconButton.styleFrom(
          hoverColor: const Color(0xFF5B2C6F),
        ),splashRadius: 1,),
        border: const OutlineInputBorder(),
        hintText: "Ваше имя",
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Color(0xFF5B2C6F)),
        ),
      ),

    );
  }

  _getLogOutButton(context){
    return TextButton(
    onPressed: () async{
      _authService.signOut();
      SharedPreferences sp = await SharedPreferences.getInstance();
      LocalDataAnalyse _LDA = LocalDataAnalyse(sp: sp);
      _LDA.setLoginStatus("0","","");
      CurrentUserData.name = "Имя не задано";
      Navigator.pushNamedAndRemoveUntil(context, "/logger", (r) => false);
    },child: const Text("Выйти из профиля",
      style: TextStyle(fontSize: 15, fontFamily: 'Roboto', color: Colors.red),
    ),);
  }

  _getChangePasswordButton(context){
    return TextButton(
      onPressed: () {
        _authService.resetPassword(CurrentUserData.email);
        Fluttertoast.showToast(
            msg: "Письмо на эл.почту отправлено!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFF5B2C6F),
            textColor: Colors.white,
            fontSize: 16.0);
      },
      child: const Text("Сменить пароль",
      style: TextStyle(fontSize: 15, fontFamily: 'Roboto', color: Colors.black45),
    ),);
  }

  _getEmailField(context, emailController){
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed:() async {
          if (_emailController.text.trim() != "" && _emailController.text.length >= 4) {
            String res = await _authService.updateEmail(_emailController.text.trim());
            Fluttertoast.showToast(
                msg: res,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.deepOrange,
                textColor: Colors.white,
                fontSize: 16.0);
            if (res == "Ваша почта изменена!") {
              setState(() {
                CurrentUserData.email = _emailController.text.trim();
                showEmailField = false;
              });
              SharedPreferences sp = await SharedPreferences.getInstance();
              LocalDataAnalyse _LDA = LocalDataAnalyse(sp: sp);
              _LDA.setLoginStatus("1", _emailController.text.trim(),CurrentUserData.pass);
            }
            _emailController.clear();
          }
        } , icon: const Icon(Icons.arrow_forward),style: IconButton.styleFrom(
          hoverColor: const Color(0xFF5B2C6F),
        ),splashRadius: 1,),
        border: const OutlineInputBorder(),
        hintText: "Новый email",
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Color(0xFF5B2C6F)),
        ),
      ),

    );
  }
}