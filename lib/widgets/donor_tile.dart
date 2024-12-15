import 'package:flutter/material.dart';

import '../models/donor.dart';

class DonorTile extends StatelessWidget {
  final Donor donor;

  const DonorTile({required this.donor, super.key});

  static const Color accentColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              donor.fullName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _lineBuilder(Icons.phone, donor.phoneNumber),
                const SizedBox(height: 8),
                _lineBuilder(Icons.map, donor.address),
                const SizedBox(height: 8),
                _lineBuilder(Icons.person, donor.age.toString()),
                if (donor.lastDonationDate != null) ...[
                  const SizedBox(height: 8),
                  _lineBuilder(Icons.water_drop, donor.lastDonationDate!),
                ],
              ],
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You clicked on ${donor.fullName}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _lineBuilder(IconData icon, String data) => Row(
        children: [
          Icon(icon, color: accentColor, size: 20),
          const SizedBox(width: 8),
          Text(
            data,
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ],
      );
}
