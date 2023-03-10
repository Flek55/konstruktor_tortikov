import 'package:firebase_auth/firebase_auth.dart';
import 'package:tortik/Services/AppUser.dart';

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
      return AppUser(user);
    }catch(e){
      return null;
    }
  }

  Future logOut() async{
    await _fAuth.signOut();
  }

  Stream<AppUser?> get currentUser{
    return _fAuth.authStateChanges().map((User? user) => 
    user != null ? AppUser(user) : null);
  }
}