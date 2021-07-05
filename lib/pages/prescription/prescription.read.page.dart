import 'package:flutter/material.dart';
import 'package:healthlife/common/custom_drawer/custom_drawer.dart';
import 'package:healthlife/manager/company_manager.dart';
import 'package:healthlife/manager/prescription_manager.dart';
import 'package:provider/provider.dart';

import 'components/prescription.read.tile.page.dart';

class PrescriptionPage extends StatefulWidget {
  final String title;
  const PrescriptionPage({Key key, this.title}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}
//Tela de Prescrições

class _PrescriptionPageState extends State<PrescriptionPage> {
  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Consumer<PrescriptionManager>(
          builder: (_, prescriptionManager, __) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("PRESCRIÇÕES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(143, 131, 118, 1),
                      fontSize: 24,
                    )),
                Expanded(
                  child: ListView.builder(
                      itemCount: prescriptionManager.allPrescription.length,
                      itemBuilder: (_, index) {
                        return PrescriptionListTile(prescriptionManager.allPrescription[index]);
                      }),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/prescription_item');
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.teal,
                      size: 80,
                    )
                )
              ],
            );
          }),
    );
  }
}