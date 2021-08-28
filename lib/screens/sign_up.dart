import 'package:finnaport/screens/screens.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 175),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/signup.svg',
                height: 80,
                width: screenSize.width - 16.0,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: screenSize.width - 64.0,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    InputTextField(
                      controller: emailController,
                      label: 'Email',
                    ),
                    SizedBox(height: 16),
                    InputTextField(
                      controller: passwordController,
                      label: 'Password',
                      password: true,
                    ),
                    SizedBox(height: 61),
                    SizedBox(
                      width: screenSize.width - 100,
                      height: 60,
                      child: SignUpLoginButton(
                        title: 'SIGN UP',
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      width: screenSize.width - 64.0,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Already have an account? Sign In",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showMaterialDialog(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("You fuck"),
              content: new Text(error),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
