import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/blood_bank_button.dart';
import 'administration_data_screen.dart';

class AdministratorValidation extends StatefulWidget {
  static const routName = '/administrator_validation';

  const AdministratorValidation({super.key});

  @override
  State<StatefulWidget> createState() => _AdministratorValidationState();
}

@override
State<AdministratorValidation> createState() => _AdministratorValidationState();

class _AdministratorValidationState extends State<AdministratorValidation> {
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyPhoneNumber(String phoneNumber) async {
    // validate

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            setState(() {
              _isLoading = true;
            });

            await _auth.signInWithCredential(credential);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Phone number verified and signed in successfully!'),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error signing in: ${e.toString()} '),
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${e.message} '),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification code sent to your phone.'),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Auto-retrieval timeout. Please enter the code manually.'),
            ),
          );
        });
    setState(() {
      _isLoading = false;
    });
  }

  void _verifyOtp() async {
    final smsCode = _codeController.text.trim();
    if (smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please enter a 6-digit code.'),
        ),
      );
      return;
    }

    if (_verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: smsCode);

      try {
        await _auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phone number verified successfully.'),
          ),
        );

        Navigator.pushReplacementNamed(
            context, AdministrationDataScreen.routName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sing in: ${e.toString()}.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification ID is missing. Please try again.'),
        ),
      );
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone_android,
                    color: Colors.red,
                    size: 35,
                  ),
                  Text(
                    phoneNumber,
                    style: const TextStyle(color: Colors.red, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Enter the validation code sent to your mobile:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: "Validation Code",
                  border: OutlineInputBorder(),
                  counterText: "", // Removes counter below the input
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the code.";
                  } else if (value.length != 6) {
                    return "Code must be 6 digits.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : BloodBankButton(
                      title: 'Validate',
                      onPress: _verifyOtp,
                      //     () {
                      //   _verifyPhoneNumber(phoneNumber);
                      // },
                    ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  _verifyPhoneNumber(phoneNumber);
                },
                child: const Text(
                  'Send Code Again',
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
