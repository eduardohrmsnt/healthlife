import 'package:flutter/material.dart';
import 'package:healthlife/manager/company_manager.dart';
import 'package:healthlife/pages/base.page.dart';
import 'package:healthlife/pages/company/company.item.page.dart';
import 'package:healthlife/pages/login/login.page.dart';
import 'package:healthlife/pages/medicament/medicament.item.page.dart';
import 'package:healthlife/pages/medicament/medicament.read.page.dart';
import 'package:healthlife/pages/prescription/prescription.item.page.dart';
import 'package:healthlife/pages/prescription/prescription.read.page.dart';
import 'package:provider/provider.dart';
import 'manager/medicament_manager.dart';
import 'manager/prescription_manager.dart';
import 'manager/user_manager.dart';
import 'models/company.dart';
import 'models/medicament.dart';
import 'models/prescription.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CompanyManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => MedicamentManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => PrescriptionManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
            title: 'Health Life',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/login':
                  return MaterialPageRoute(builder: (_) => LoginPage());
                case '/medicament':
                  return MaterialPageRoute(builder: (_) => MedicamentPage());
                case '/medicament_item':
                  return MaterialPageRoute(builder: (_) => MedicamentItem(settings.arguments as Medicament));
                case '/prescription':
                  return MaterialPageRoute(builder: (_) => PrescriptionPage());
                case '/prescription_item':
                  return MaterialPageRoute(builder: (_) => PrescriptionItem(settings.arguments as Prescription));
                case '/company_item':
                  return MaterialPageRoute(builder: (_) => CompanyItem(settings.arguments as Company));
                case '/':
                default:
                  return MaterialPageRoute(builder: (_) => BasePage());
              }
            },
          )
    );
  }
}
