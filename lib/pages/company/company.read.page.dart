import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthlife/common/custom_drawer/custom_drawer.dart';
import 'package:healthlife/manager/company_manager.dart';
import 'package:healthlife/models/company.dart';
import 'package:provider/provider.dart';

import 'components/company.read.tile.page.dart';
//Tela de fornecedores
class CompanyPage extends StatelessWidget {
  List _toDoList = [];
  Company _lastRemoved;
  int _lastRemovedPos;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body: Consumer<CompanyManager>(builder: (_, companyManager, __) {
          return Container(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("FORNECEDORES",
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
              Expanded(
                child: ListView.builder(
                    itemCount: companyManager.allCompany.length,
                    itemBuilder: (_, index) {
                      return CompanyListTile(companyManager.allCompany[index]);
                    }),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/company_item');
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.teal,
                    size: 80,
                  ))
            ],
          ));
        }));
  }
}
