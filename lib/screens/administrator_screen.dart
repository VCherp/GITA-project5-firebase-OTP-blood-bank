import 'package:flutter/material.dart';

import '../utility/firebase_wrapper.dart';
import '../widgets/blood_bank_button.dart';
import 'administrator_validation.dart';
import '../widgets/donation_text_field.dart';

class AdministratorScreen extends StatelessWidget {
  static const routName = '/administrator_screen';

  AdministratorScreen({super.key});

  final GlobalKey<DonationTextFieldState> _phoneNumberKey = GlobalKey();
  final GlobalKey<DonationTextFieldState> _passKey = GlobalKey();

  final _firebaseWrapper = FirebaseWrapper();

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '';
    String pass = '';

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Blood Bank \n Administration',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 100,
            ),
            DonationTextField(
                key: _phoneNumberKey,
                labelText: 'Phone number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                onEditingComplete: (String text) {
                  phoneNumber = text;
                }),
            DonationTextField(
                key: _passKey,
                labelText: 'Password',
                icon: Icons.password,
                obscureText: true,
                onEditingComplete: (String text) {
                  pass = text;
                }),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BloodBankButton(
                title: 'Sing in',
                onPress: () async {
                  final response = await _firebaseWrapper.readUser(
                      'administrators', phoneNumber);

                  if (context.mounted) {
                    if (response.success) {
                      if (pass != response.password) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password is incorrect'),
                          ),
                        );
                      } else {
                        Navigator.of(context).pushReplacementNamed(
                            AdministratorValidation.routName,
                            arguments: phoneNumber);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Error while getting user : ${response.error ?? ''}'),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
