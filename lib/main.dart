import 'package:finnaport/config/config.dart';
import 'package:finnaport/provider/holdings_provider.dart';
import 'package:finnaport/provider/nav_bar_provider.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:finnaport/provider/validation/signup_login_validation.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:finnaport/services/authentication/authentication_service.dart';
import 'package:finnaport/services/authentication/googleauth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Palette.finnaDarkBox,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavBarProvider>(
          create: (context) => NavBarProvider(),
        ),
        ChangeNotifierProvider<HoldingsProvider>(
          create: (context) => HoldingsProvider(),
        ),
        ChangeNotifierProvider<PerformanceProvider>(
          create: (context) => PerformanceProvider(),
        ),
        ChangeNotifierProvider<SignUpValidation>(
          create: (context) => SignUpValidation(),
        ),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        Provider<GoogleAuthService>(
          create: (_) => GoogleAuthService(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChange,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Finnaport',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Palette.finnaGreen),
          fontFamily: 'Poppins',
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Palette.background,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
