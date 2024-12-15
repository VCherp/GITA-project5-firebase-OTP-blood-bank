import 'package:flutter/material.dart';

class DonorThankingScreen extends StatelessWidget {
  static const routName = '/donor_thanking_screen';

  const DonorThankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Thank You',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Your data has been saved',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/blood_donation.png',
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'You make a commendable contribution as a blood donor!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
