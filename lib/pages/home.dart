import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthlife/common/custom_drawer/custom_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Container(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text("AÇÕES RÁPIDAS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(143, 131, 118, 1),
                  fontSize: 24,
                )),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.teal,
              child: Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/newpaper.png")
              ),
              SizedBox(

                height: 100,
                width: MediaQuery.of(context).size.width - 90,
                child: RaisedButton(
                  color: Colors.teal,
                  elevation: 0,
                  disabledColor: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/prescription_item');
                  },
                  child: Text('Nova Prescrição', style: TextStyle(fontSize: 25)),
                ),
              ),
                  ]
            ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: Colors.teal,
              child: Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/images/pill-xxl.png")
                    ),
                    SizedBox(

                      height: 100,
                      width: MediaQuery.of(context).size.width - 90,
                      child: RaisedButton(
                        color: Colors.teal,
                        elevation: 0,
                        disabledColor: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/medicament_item');
                        },
                        child: Text('Novo Medicamento', style: TextStyle(fontSize: 25)),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: Colors.teal,
              child: Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/images/factory-xxl.png")
                    ),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 90,
                      child: RaisedButton(
                        color: Colors.teal,
                        elevation: 0,
                        disabledColor: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/company_item');
                        },
                        child: Text('Novo Fornecedor', style: TextStyle(fontSize: 25)),
                      ),
                    ),
                  ]
              ),
            ),
          ],
        ),
      )),
    );
  }
}
