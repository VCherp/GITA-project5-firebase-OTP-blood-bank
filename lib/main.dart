import 'package:flutter/material.dart';

import 'screens/administration_data_screen.dart';
import 'screens/administrator_screen.dart';
import 'screens/administrator_validation.dart';
import 'screens/donor_screen.dart';
import 'screens/donor_thanking_screen.dart';
import 'screens/main_screen.dart';
import 'utility/firebase_wrapper.dart';

void main() {
  FirebaseWrapper().initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        DonorScreen.routName: (context) => DonorScreen(),
        AdministratorScreen.routName: (context) => AdministratorScreen(),
        DonorThankingScreen.routName: (context) => const DonorThankingScreen(),
        AdministratorValidation.routName: (context) =>
            AdministratorValidation(),
        AdministrationDataScreen.routName: (context) =>
            const AdministrationDataScreen(),
      },
    );
  }
}
