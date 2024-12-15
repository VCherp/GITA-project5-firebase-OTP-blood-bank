import 'user.dart';

class Donor extends User {
  String fullName;
  int age;
  String address;
  String bloodType;
  String? lastDonationDate;

  Donor({
    required super.phoneNumber,
    required this.fullName,
    required this.age,
    required this.address,
    required this.bloodType,
    this.lastDonationDate,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'age': age,
      'address': address,
      'bloodType': bloodType,
      'lastDonationDate': lastDonationDate,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      phoneNumber: map['phoneNumber'] ?? '',
      fullName: map['fullName'] ?? '',
      age: map['age'] ?? 0,
      address: map['address'] ?? '',
      bloodType: map['bloodType'] ?? '',
      lastDonationDate: map['lastDonationDate'] ?? '',
    );
  }
}
