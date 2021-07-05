import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'custom_drawer_header.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CustomDrawerHeader(),
          const Divider(),
                Column(
                  children: [
                    const DrawerTile(iconData: Icons.home, title: 'Home', page: 0),
                    const DrawerTile(iconData: Icons.insert_drive_file, title: 'Prescrições', page: 1),
                    const DrawerTile(iconData: Icons.medical_services, title: 'Medicamentos', page: 2),
                    const DrawerTile(iconData: Icons.apartment_outlined, title: 'Fornecedors', page: 3),
                  ],
                ),
      ]
      )
    );
  }
}
