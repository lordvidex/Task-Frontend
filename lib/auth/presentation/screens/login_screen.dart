import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:retrofit/http.dart';
import '../../../core/styles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/action_button_widget.dart';
import '../widgets/username_field_widget.dart';
import '../widgets/password_field_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool isLogin = true;
  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeToSignIn() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      final double width = min(constraint.maxWidth, 300);
      return BlocConsumer<AuthBloc, AuthState>(listener: (ctx, state) {
        if (state is UnauthenticatedState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }
      }, builder: (ctx, state) {
        if (state is AuthenticatingState) {
          return Stack(
            children: [
              Opacity(
                  child: MainWidget(
                    changeToSignIn: changeToSignIn,
                    isLogin: isLogin,
                    width: width,
                    usernameController: usernameController,
                    passwordController: passwordController,
                  ),
                  opacity: 0.4),
              Center(child: CircularProgressIndicator())
            ],
          );
        } else if (state is UnauthenticatedState)
          return MainWidget(
            changeToSignIn: changeToSignIn,
            isLogin: isLogin,
            width: width,
            usernameController: usernameController,
            passwordController: passwordController,
          );
        else
          return Container();
      });
    });
  }
}

class MainWidget extends StatelessWidget {
  final bool isLogin;
  final double width;
  final TextEditingController? usernameController;
  final TextEditingController? passwordController;
  final Function changeToSignIn;

  const MainWidget(
      {Key? key,
      required this.isLogin,
      required this.width,
      this.usernameController,
      this.passwordController,
      required this.changeToSignIn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
          child: Container(
        color: Colors.white,
        child: Container(
            width: width,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RichText(
                        text: TextSpan(
                            text: 'Hello!\n\n',
                            style: TextStyle().headerText,
                            children: [
                          TextSpan(
                              style: TextStyle().captionText,
                              text:
                                  'fill in your username and password to get started!')
                        ]))),
                UsernameField(usernameController!),
                SizedBox(
                  height: 10,
                ),
                PasswordField(passwordController!),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ActionButton(
                      text: (!isLogin) ? 'Sign Up' : 'Sign In',
                      onPressed: () {
                        context.read<AuthBloc>().add(!isLogin
                            ? SignupEvent(usernameController!.text,
                                passwordController!.text)
                            : LoginEvent(usernameController!.text,
                                passwordController!.text));
                      }),
                ),
                if (isLogin)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Text('DON\'T HAVE ACCOUNT?'),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(' SIGN UP NOW!'),
                          onPressed: () => changeToSignIn(),
                        )
                      ])),
              ],
            ))),
      )),
    );
  }
}
