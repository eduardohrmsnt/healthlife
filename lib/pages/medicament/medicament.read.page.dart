import 'package:flutter/material.dart';
import 'package:healthlife/common/custom_drawer/custom_drawer.dart';
import 'package:healthlife/manager/company_manager.dart';
import 'package:healthlife/manager/medicament_manager.dart';
import 'package:provider/provider.dart';

import 'components/medicament.read.tile.page.dart';

class MedicamentPage extends StatefulWidget {
  final String title;
  const MedicamentPage({Key key, this.title}) : super(key: key);

  @override
  _MedicamentPageState createState() => _MedicamentPageState();
}
//Tela de Medicamentos

class _MedicamentPageState extends State<MedicamentPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body:Consumer<MedicamentManager>(builder: (_, medicamentManager, __) {
    return Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("MEDICAMENTOS",
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
                  itemCount: medicamentManager.allMedicament.length,
                      itemBuilder: (_, index) {
                        return MedicamentListTile(medicamentManager.allMedicament[index]);
                  }),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/medicament_item');
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.teal,
                    size: 80,
                  )
              )
            ],
          ));
        }));
  }
}