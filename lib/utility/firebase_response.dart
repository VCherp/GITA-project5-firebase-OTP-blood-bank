import '../models/user.dart';

class FirebaseResponse {
  final bool success;
  final List<User>? userList;
  final String? password;
  final String? error;

  FirebaseResponse(this.success, {this.userList, this.password, this.error});
}
