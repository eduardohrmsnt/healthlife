import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Company extends ChangeNotifier {
  String id;
  String razaosocial;
  String cnpj;
  String uf;
  String cidade;
  String telefone;
  String email;
  bool excluded;


  Company(
      {this.id, this.razaosocial, this.cnpj, this.uf, this.cidade, this.telefone, this.email,this.excluded = false});

  Company.fromDocument(DocumentSnapshot document) {
    id = document.id;
    razaosocial = document.data()['razaosocial'] as String;
    cnpj = document.data()['cnpj'] as String;
    uf = document.data()['uf'] as String;
    cidade = document.data()['cidade'] as String;
    telefone = document.data()['telefone'] as String;
    email = document.data()['email'] as String;
    excluded = (document.data()['excluded'] ?? false) as bool;

  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  DocumentReference get fireStoreRef => fireStore
      .collection('company')
      .doc(id);

  void delete() {
    fireStoreRef.update({'excluded': true});
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Company clone() {
    return Company(
        id: id, razaosocial: razaosocial, cnpj: cnpj, uf: uf, cidade: cidade, telefone: telefone, email: email, excluded: excluded);
  }

  Map<String, dynamic> toMap() {
    return {
      'razaosocial': razaosocial,
      'cnpj' : cnpj,
      'uf' : uf,
      'cidade' : cidade,
      'telefone' : telefone,
      'email' : email,
      'excluded': excluded
    };
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = toMap();

    if (id == null) {
      final doc = await fireStore
          .collection('company')
          .add(data);
      id = doc.id;
    } else {
      await fireStoreRef.update(data);
    }
    loading = false;
  }
}