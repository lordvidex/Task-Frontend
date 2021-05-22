class User {
  final String? username;
  final String? userId;
  final String? _accessToken;
  const User({this.username, String? accessToken, this.userId})
      : _accessToken = accessToken;
}
