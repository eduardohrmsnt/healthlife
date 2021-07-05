import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthlife/models/prescription.dart';

class PrescriptionManager extends ChangeNotifier {
  PrescriptionManager() {
    _loadAllPrescription();
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<Prescription> allPrescription = [];
  //Carrega todas as empresas que nao estao excluidas
  Future<void> _loadAllPrescription() async {
    final QuerySnapshot snapActivity = await fireStore
        .collection('institution')
        .where('excluded', isEqualTo: false)
        .get();
    allPrescription = snapActivity.docs.map((c) => Prescription.fromDocument(c)).toList();
    notifyListeners();
  }
  //Atualiza a empresa
  void update(Prescription prescription) {
    allPrescription.removeWhere((c) => c.id == prescription.id);
    allPrescription.add(prescription);
    notifyListeners();
  }
//Delete a empresa
  void delete(Prescription prescription) {
    prescription.delete();
    allPrescription.removeWhere((c) => c.id == prescription.id);
    notifyListeners();
  }
}
