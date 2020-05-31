// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/shared/constants.dart';
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

  Future registerWithEmailAndPassword(String email, String password,String batch) async {
    try {
      
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      

      var rng = new Random();
      await DatabaseService(uid: user.uid).updateUserData('Guest${rng.nextInt(100000)}','https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/profile.jpg?alt=media&token=fcd8a982-14f4-424c-9e34-701e5c39f628','user',batch,'','');
      
      // await user.sendEmailVerification();
        return _userFromFirebaseUser(user);
      // }
      
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // Future verifiedaayo() async {

  // }
  
  Future registeradminWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var user = result.user;
      var rng = new Random();
      await DatabaseService(uid: user.uid).updateUserDataByAdmin('Admin${rng.nextInt(100000)}','https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg','admin');
      return ('True');
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future sendPasswordReset(String email) async{
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}