///Connection with FireBaseAuth and all the auth methods
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tortik/Services/app_user.dart';


class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return AppUser(user);
    }catch(e){
      return null;
    }
  }

  Future<AppUser?> registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      assignName("Имя не задано");
      return AppUser(user);
    }catch(e){
      return null;
    }
  }

  Future<String> getUserDisplayName() async{
    String? ans = _fAuth.currentUser?.displayName.toString();
    if (ans == null || ans == "null"){
      return "Имя не задано";
    }else{
      return ans;
    }
  }

  Future signOut() async{
    await _fAuth.signOut();
  }

  Stream<AppUser?> get currentUser{
    return _fAuth.authStateChanges().map((User? user) => 
    user != null ? AppUser(user) : null);
  }

  void resetPassword(email) async{
    try{
      _fAuth.sendPasswordResetEmail(email: email);
    }catch(e){
      return null;
    }
  }

  void assignName(name) async{
    try {
      User? user = _fAuth.currentUser;
      await user?.updateDisplayName(name);
    }on FirebaseAuthException catch (error){
      switch (error.code){
        default:
          print("чзх");
      }
    }
  }

  Future<String> updateEmail(email) async{
    String errorMessage = "";
    try {
      User? user = _fAuth.currentUser;
      await user?.updateEmail(email);
    }on FirebaseAuthException catch (error){
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "email-already-in-use":
          errorMessage = "Эл.почта занята!";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != "") {
      return errorMessage;
    }
    return "Ваша почта изменена!";
  }
}