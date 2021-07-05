import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'company.dart';

class Medicament extends ChangeNotifier {
  String id;
  String nome;
  String valor;
  String indicacao;
  String fornecedor;
  bool excluded;


  Medicament(
      {this.id, this.nome, this.valor, this.indicacao, this.fornecedor, this.excluded = false});

  Medicament.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nome = document.data()['nome'] as String;
    valor = document.data()['valor'];
    indicacao = document.data()['indicacao'] as String;
    fornecedor =  document.data()['fornecedor'] as String;
    excluded = (document.data()['excluded'] ?? false) as bool;

  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  DocumentReference get fireStoreRef => fireStore
      .collection('medicament')
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

  Medicament clone() {
    return Medicament(
        id: id, nome: nome, valor: valor, indicacao: indicacao, fornecedor: fornecedor, excluded: excluded);
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'valor' : valor,
      'indicacao' : indicacao,
      'fornecedor' : fornecedor,
      'excluded': excluded
    };
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = toMap();

    if (id == null) {
      final doc = await fireStore
          .collection('medicament')
          .add(data);
      id = doc.id;
    } else {
      await fireStoreRef.update(data);
    }
    loading = false;
  }
}