import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(createToJson: false)
class AuthResponse {
  @JsonKey(name: 'access_token')
  final String? accessToken;
  final String? username;
  final int? id;
  final String? error;
  AuthResponse({this.accessToken, this.username, this.id, this.error});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
