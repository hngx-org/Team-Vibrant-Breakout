import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
part 'user.g.dart';


@HiveType(typeId: 1)
class UserModel {
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.highscore
  });
  @HiveField(0)
  String email;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;
  @HiveField(5)
  String highscore;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      highscore: map['highscore']
    );
  }
}
