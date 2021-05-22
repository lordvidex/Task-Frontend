import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth_response.dart';
import '../models/username_password.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() final UsernamePassword data);

  @POST('/auth/signup')
  Future<AuthResponse> signup(@Body() final UsernamePassword data);

  @POST('/auth/token')
  Future<AuthResponse> checkToken(@Body() final Map<String,dynamic> data);
}
