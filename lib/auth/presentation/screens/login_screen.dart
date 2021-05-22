import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:retrofit/http.dart';
import '../../../core/styles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/action_button_widget.dart';
import '../widgets/email_field_widget.dart';
import '../widgets/password_field_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isLogin = true;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
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
                    emailController: emailController,
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
            emailController: emailController,
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
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final Function changeToSignIn;

  const MainWidget(
      {Key? key,
      required this.isLogin,
      required this.width,
      this.emailController,
      this.passwordController,
      required this.changeToSignIn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
            width: width,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                      'Hello, \nfill in your username and password to get started!',
                      style: TextStyle().headerText),
                ),
                EmailField(emailController!),
                SizedBox(
                  height: 10,
                ),
                PasswordField(passwordController!),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ActionButton(
                      text: (!isLogin) ? 'Sign Up' : 'Sign In',
                      onPressed: () {
                        context.read<AuthBloc>().add(!isLogin
                            ? SignupEvent(
                                emailController!.text, passwordController!.text)
                            : LoginEvent(emailController!.text,
                                passwordController!.text));
                      }),
                ),
                if (isLogin)
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
