import 'package:finnaport/config/config.dart';
import 'package:finnaport/services/authentication/googleauth_service.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //AuthenticationService authService = context.read<AuthenticationService>();
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 175),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/login.svg',
                height: 100,
                width: screenSize.width - 32.0,
              ),
            ),
            Center(
              child: Container(
                width: screenSize.width - 64.0,
                child: Column(
                  children: [
                    InputTextField(
                      controller: emailController,
                      label: 'Email',
                    ),
                    SizedBox(height: 16),
                    InputTextField(
                      password: true,
                      controller: passwordController,
                      label: 'Password',
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: screenSize.width - 64.0,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                    SizedBox(height: 45),
                    SizedBox(
                      width: screenSize.width - 100,
                      height: 60,
                      child: SignUpLoginButton(
                        title: 'LOGIN',
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
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Dont have an account? Sign Up",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    InkWell(
                      onTap: () {
                        GoogleAuthService googleAuthService =
                            context.read<GoogleAuthService>();
                        googleAuthService.login();
                        if (googleAuthService.signedIn == true) {
                          print('logged in with Google');
                        }
                      },
                      child: Container(
                        height: 55,
                        decoration: baseBackgroundDecoration,
                        width: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/google_logo.svg',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
