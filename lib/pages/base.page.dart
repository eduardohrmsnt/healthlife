import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthlife/manager/page_manager.dart';
import 'package:healthlife/pages/medicament/medicament.read.page.dart';
import 'package:healthlife/pages/prescription/prescription.read.page.dart';
import 'package:provider/provider.dart';
import 'company/company.read.page.dart';
import 'home.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Home(),
          PrescriptionPage(),
          MedicamentPage(),
          CompanyPage(),
          //StrategiesScreen(),
          //InstitutionScreen(),
          //AudioView(),
          //AboutScreen(),
          //CloseAccount(),
        ],
      ),
    );
  }
}
