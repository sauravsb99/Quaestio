import 'package:firebase_auth/firebase_auth.dart';
import 'package:queastio/models/user.dart';
import 'database.dart';
import 'dart:math';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid): null;
  }
   Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  Future signInAnon() async{
    try{

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      var rng = new Random();
      await DatabaseService(uid: user.uid).updateUserData('Guest${rng.nextInt(100000)}');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//  Future updateWithPassword(String email, String password) async {
//    try {
//      AuthResult result = await _auth.updateWithPassword(uid: uid, password: password);
//      FirebaseUser user = result.user;
//      return user;
//    } catch (error) {
//      print(error.toString());
//      return null;
//    }
//  }

}