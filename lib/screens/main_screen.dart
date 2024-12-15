import 'package:flutter/material.dart';

import '../widgets/blood_bank_button.dart';
import 'administrator_screen.dart';
import 'donor_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                'Blood Bank',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Once a blood donor, always a lifesaver!',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset('assets/main_screen_donor.jpg'),
              const SizedBox(
                height: 100,
              ),
              BloodBankButton(
                title: 'Ready To Donate?',
                onPress: () {
                  Navigator.of(context).pushNamed(DonorScreen.routName);
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AdministratorScreen.routName);
                },
                child: const Text(
                  'Log In As Administrator',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
