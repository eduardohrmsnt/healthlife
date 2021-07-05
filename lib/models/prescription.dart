import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'medicament.dart';

class Prescription extends ChangeNotifier {
  String id;
  String nome;
  String cpf;
  String intervalo;
  String quantidade;
  String nascimento;
  String medicamento;
  bool excluded;


  Prescription(
      {this.id,this.nome, this.cpf, this.nascimento, this.medicamento, this.excluded = false, this.intervalo, this.quantidade});

  Prescription.fromDocument(DocumentSnapshot document) {
    id = document.id;
    nome = document.data()['nome'] as String;
    cpf = document.data()['cpf'] as String;
    nascimento = document.data()['nascimento'] as String;
    medicamento =  document.data()['medicamentos'] as String;
    excluded = (document.data()['excluded'] ?? false) as bool;
    intervalo = document.data()['intervalo'] as String;
    quantidade = document.data()['quantidade'] as String;

  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  DocumentReference get fireStoreRef => fireStore
      .collection('prescription')
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

  Prescription clone() {
    return Prescription(
        id: id,nome: nome, cpf: cpf, nascimento: nascimento, medicamento: medicamento,  excluded: excluded, quantidade: quantidade, intervalo: intervalo);
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf' : cpf,
      'nascimento' : nascimento,
      'medicamentos' : medicamento,
      'intervalo' : intervalo,
      'quantidade' : quantidade,
      'excluded': excluded
    };
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = toMap();

    if (id == null) {
      final doc = await fireStore
          .collection('prescription')
          .add(data);
      id = doc.id;
    } else {
      await fireStoreRef.update(data);
    }
    loading = false;
  }
}