import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserApp extends ChangeNotifier {
  String id;
  String email;
  String password;
  String name;
  String confirmPassword;

  UserApp(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.confirmPassword});

  UserApp.fromDocument(DocumentSnapshot document) {
    id = document.id;
    email = document.data()['email'] as String;
    name = document.data()['name'] as String;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserApp clone() {
    return UserApp(id: id, name: name, email: email);
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name};
  }

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Future<void> deleteAccount() async {
    return auth.currentUser.delete().then((value) {
      notifyListeners();
    }).catchError((e) => debugPrint(e.toString()));
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = toMap();

    if (id == null) {
      final doc = await fireStore.collection('users').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }
    loading = false;
  }
}
