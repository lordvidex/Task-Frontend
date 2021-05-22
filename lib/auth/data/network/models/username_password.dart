import 'package:json_annotation/json_annotation.dart';

part 'username_password.g.dart';

@JsonSerializable(createFactory: false)
class UsernamePassword {
  final String username;
  final String password;
  UsernamePassword(this.username, this.password);
  Map<String, dynamic> toJson() => _$UsernamePasswordToJson(this);
}
