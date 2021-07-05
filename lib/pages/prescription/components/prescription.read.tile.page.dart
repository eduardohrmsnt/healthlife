import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:healthlife/models/prescription.dart';
import 'package:provider/provider.dart';

class PrescriptionListTile extends StatelessWidget {
  const PrescriptionListTile(this.prescription);

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Prescription>.value(
      value: prescription,
      child: Card(
        child: Dismissible(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment(-0.9, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.startToEnd,
            child: Container(
              height: 100,
              child: ListTile(
                  isThreeLine: true,
                  contentPadding: EdgeInsets.only(left: 20, top: 20),
                  title: AutoSizeText(prescription.nome,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                      minFontSize: 18,
                      overflow: TextOverflow.ellipsis),
                  subtitle: AutoSizeText(prescription.cpf,
                      maxLines: 2,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      minFontSize: 14,
                      overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    color: Colors.grey,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/prescription_item', arguments: prescription);
                    },
                  )),
            ),
            onDismissed: (direction) {
              prescription.delete();
            }),
      ),
    );
  }
}
