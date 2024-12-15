import 'package:flutter/material.dart';

import '../models/donor.dart';
import '../utility/firebase_wrapper.dart';
import '../widgets/blood_bank_button.dart';
import 'donor_thanking_screen.dart';
import '../widgets/blood_type_selector.dart';
import '../widgets/donation_date_selector.dart';
import '../widgets/donation_text_field.dart';

class DonorScreen extends StatelessWidget {
  static const routName = '/donor_screen';

  DonorScreen({super.key});

  final _firebaseWrapper = FirebaseWrapper();

  final GlobalKey<DonationTextFieldState> _fullNameKey = GlobalKey();
  final GlobalKey<DonationTextFieldState> _ageKey = GlobalKey();
  final GlobalKey<DonationTextFieldState> _phoneNumberKey = GlobalKey();
  final GlobalKey<DonationTextFieldState> _addressKey = GlobalKey();

  final Donor _donor =
      Donor(phoneNumber: '', fullName: '', age: 0, address: '', bloodType: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/blood_donor.png',
                height: 120,
              ),
              const Text(
                'Donate BLOOD',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              DonationTextField(
                  key: _fullNameKey,
                  labelText: 'Full name',
                  icon: Icons.person,
                  onEditingComplete: (String text) {
                    _donor.fullName = text;
                  }),
              DonationTextField(
                  key: _ageKey,
                  labelText: 'Age',
                  icon: Icons.person,
                  onEditingComplete: (String text) {
                    _donor.age = int.tryParse(text) ?? 0;
                  }),
              DonationTextField(
                  key: _phoneNumberKey,
                  labelText: 'Phone number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  onEditingComplete: (String text) {
                    _donor.phoneNumber = text;
                  }),
              DonationTextField(
                  key: _addressKey,
                  labelText: 'Address',
                  icon: Icons.map,
                  onEditingComplete: (String text) {
                    _donor.address = text;
                  }),
              BloodTypeSelector(
                onEditingComplete: (String bloodType) {
                  _donor.bloodType = bloodType;
                },
              ),
              DonationDateSelector(
                onEditingComplete: (String date) {
                  _donor.lastDonationDate = date;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: BloodBankButton(
                  title: 'Become A Donor',
                  onPress: () async {
                    final response =
                        await _firebaseWrapper.createUser('donors', _donor);

                    if (context.mounted) {
                      if (response.success) {
                        Navigator.of(context)
                            .pushReplacementNamed(DonorThankingScreen.routName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Error while creating data : ${response.error ?? ''}'),
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
      ),
    );
  }
}
