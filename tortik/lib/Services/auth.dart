///Connection with FireBaseAuth and all the auth methods
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tortik/Services/app_user.dart';
import 'package:tortik/main.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fData = FirebaseFirestore.instance;

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      CurrentUserData.name = await getUserDisplayName();
      final data = {"username": email};
      _fData.collection("users").doc("${result.user?.uid}").update(data).then(
          (value) => null,
          onError: (e) =>
              _fData.collection("users").doc("${result.user?.uid}").set(data));
      return AppUser(user);
    } catch (e) {
      return null;
    }
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    String errorMessage = "";
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      assignName("Имя не задано");
      CurrentUserData.name = await getUserDisplayName();
      final data = {"username": email};
      _fData.collection("users").doc("${result.user?.uid}").set(data);
      _fData
          .collection("users")
          .doc("${result.user?.uid}")
          .collection("favorites")
          .doc("delete")
          .set({"product_id": "0"});
      _fData
          .collection("users")
          .doc("${result.user?.uid}")
          .collection("cart")
          .doc("delete")
          .set({"product_id": "0", "amount": 0});
      _fData
          .collection("users")
          .doc("${result.user?.uid}")
          .collection("orders")
          .doc()
          .collection("menu")
          .doc("delete")
          .set({"product_id": "0"});
    } on FirebaseAuthException catch (error) {
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
    return "Success";
  }

  Future<String> getUserDisplayName() async {
    String? ans = _fAuth.currentUser?.displayName.toString();
    if (ans == null || ans == "null") {
      return "Имя не задано";
    } else {
      return ans;
    }
  }

  Future signOut() async {
    await _fAuth.signOut();
  }

  Stream<AppUser?> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User? user) => user != null ? AppUser(user) : null);
  }

  void resetPassword(email) async {
    try {
      _fAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return null;
    }
  }

  void assignName(name) async {
    try {
      User? user = _fAuth.currentUser;
      await user?.updateDisplayName(name);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        default:
      }
    }
  }

  Future<String> updateEmail(email) async {
    String errorMessage = "";
    try {
      User? user = _fAuth.currentUser;
      await user?.updateEmail(email);
      final data = {"username": "$email"};
      _fData.collection("users").doc("${user?.uid}").update(data).then(
          (value) => null,
          onError: (e) =>
              _fData.collection("users").doc("${user?.uid}").set(data));
    } on FirebaseAuthException catch (error) {
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
