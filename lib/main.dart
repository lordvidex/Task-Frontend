import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/presentation/bloc/auth_bloc.dart';
import 'auth/presentation/screens/login_screen.dart';
import 'injection_container.dart';
import 'tasks/presentation/screens/task_screen.dart';

void main() async {
  DI di = DI();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => I.get<AuthBloc>(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Another Task app',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BlocBuilder<AuthBloc, AuthState>(buildWhen: (_, newState) {
              return (newState is AuthenticatedState ||
                  newState is UnauthenticatedState);
            }, builder: (ctx, state) {
              if (state is UnauthenticatedState) {
                return LoginScreen();
              } else if (state is AuthenticatedState) {
                return TaskScreen();
              }
              return Container();
            })));
  }
}
