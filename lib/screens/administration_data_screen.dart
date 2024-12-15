import 'package:flutter/material.dart';

import '../models/donor.dart';
import '../utility/firebase_wrapper.dart';
import '../widgets/blood_type_selector.dart';
import '../widgets/donor_tile.dart';

class AdministrationDataScreen extends StatefulWidget {
  static const routName = '/administration_data_screen';

  const AdministrationDataScreen({super.key});

  @override
  State<AdministrationDataScreen> createState() =>
      _AdministrationDataScreenState();
}

class _AdministrationDataScreenState extends State<AdministrationDataScreen> {
  final _firebaseWrapper = FirebaseWrapper();

  String bloodType = '';

  Future<List<Donor>?> getDonorsByBloodType(String bloodType) async {
    final response = await _firebaseWrapper.readDonors('donors', bloodType);

    if (context.mounted) {
      if (response.success) {
        return response.userList as List<Donor>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Error while fetching data : ${response.error ?? ''}'),
          ),
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donors List',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BloodTypeSelector(
              onEditingComplete: (String data) {
                setState(() {
                  bloodType = data;
                });
              },
            ),
            FutureBuilder<List<Donor>?>(
              future: getDonorsByBloodType(bloodType),
              // The future that fetches the data
              builder:
                  (BuildContext context, AsyncSnapshot<List<Donor>?> snapshot) {
                // Handle the different states of the Future
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for data to load
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  // If the future throws an error
                  return Expanded(
                      child: Center(child: Text('Error: ${snapshot.error}')));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // If the future completes with no data
                  return const Expanded(
                    child: Center(
                        child: Text(
                      'No donors found',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    )),
                  );
                } else {
                  // If the data is successfully loaded
                  List<Donor>? items = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return DonorTile(donor: items[index]);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
}
