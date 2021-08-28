import 'package:finnaport/config/config.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finnaport/services/authentication/authentication_service.dart';

class SignUpLoginButton extends StatelessWidget {
  final String title;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignUpLoginButton(
      {Key key,
      @required this.title,
      @required this.emailController,
      @required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationService authService = context.read<AuthenticationService>();
    return Container(
      child: ElevatedButton(
        onPressed: () {
          title.toLowerCase() == 'sign up'
              ? authService
                  .signUp(
                      email: emailController.text,
                      password: passwordController.text)
                  .then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(),
                      ),
                    ),
                  )
                  .catchError(
                      (onError) => showMaterialDialog(context, onError, title))
              : authService
                  .login(
                      email: emailController.text,
                      password: passwordController.text)
                  .then(null)
                  .catchError(
                      (onError) => showMaterialDialog(context, onError, title));
        },
        child: Text(title,
            style: TextStyle(
                color: Palette.finnaDarkBox,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Palette.finnaGreen),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
        ),
      ),
    );
  }

  void showMaterialDialog(BuildContext context, String error, String title) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        elevation: 3,
        backgroundColor: Palette.finnaDarkBox,
        title: Text(
          "${title.toLowerCase()} failed",
          style: TextStyle(color: Colors.white.withOpacity(0.9)),
        ),
        content: Text(error,
            style: TextStyle(color: Colors.white.withOpacity(0.75))),
        actions: <Widget>[
          FlatButton(
            child: Text('Close',
                style: TextStyle(color: Colors.white.withOpacity(0.8))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
