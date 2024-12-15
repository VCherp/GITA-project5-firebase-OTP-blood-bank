import 'user.dart';

class Administrator extends User {
  String password;

  Administrator({required super.phoneNumber, required this.password});

  @override
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
