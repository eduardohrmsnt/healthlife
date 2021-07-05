import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthlife/helpers/firebase_erros.dart';
import 'package:healthlife/models/user_app.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
    _loadAllUsers();
  }

  List<UserApp> allUsersApp = [];

  Future<void> _loadAllUsers() async {
    final QuerySnapshot snapUserApp =
        await fireStore.collection('users').get();
    allUsersApp =
        snapUserApp.docs.map((c) => UserApp.fromDocument(c)).toList();
    notifyListeners();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  UserApp user;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingFacebook = false;
  bool get loadingFacebook => _loadingFacebook;

  set loadingFacebook(bool value) {
    _loadingFacebook = value;
    notifyListeners();
  }

  void update(UserApp userApp) {
    allUsersApp.removeWhere((c) => c.id == userApp.id);
    allUsersApp.add(userApp);
    notifyListeners();
  }

  bool get isLogged => user != null;

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> signIn(
      {UserApp user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      await _loadCurrentUser(firebaseUser: result.user);
      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> resetPassword(String email) async {
    return await auth
        .sendPasswordResetEmail(email: email)
        .then((value) {})
        .catchError((e) => debugPrint(e.toString()));
  }

  Future<void> deleteAccount() async {
    await user.deleteAccount();
    user = null;
    notifyListeners();
  }

  Future<void> signUp(
      {UserApp user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await fireStore.collection('users').doc(currentUser.uid).get();
      user = UserApp.fromDocument(docUser);
      notifyListeners();
    }
  }
}
