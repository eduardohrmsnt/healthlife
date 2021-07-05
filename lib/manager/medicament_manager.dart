import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthlife/models/medicament.dart';

class MedicamentManager extends ChangeNotifier {
  MedicamentManager() {
    _loadAllMedicament();
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<Medicament> allMedicament = [];
  //Carrega todas as empresas que nao estao excluidas
  Future<void> _loadAllMedicament() async {
    final QuerySnapshot snapActivity = await fireStore
        .collection('institution')
        .where('excluded', isEqualTo: false)
        .get();
    allMedicament = snapActivity.docs.map((c) => Medicament.fromDocument(c)).toList();
    notifyListeners();
  }
  //Atualiza a empresa
  void update(Medicament medicament) {
    allMedicament.removeWhere((c) => c.id == medicament.id);
    allMedicament.add(medicament);
    notifyListeners();
  }
//Delete a empresa
  void delete(Medicament medicament) {
    medicament.delete();
    allMedicament.removeWhere((c) => c.id == medicament.id);
    notifyListeners();
  }
}
