import 'package:finnaport/config/config.dart';
import 'package:finnaport/screens/login.dart';
import 'package:finnaport/services/authentication/authentication_service.dart';
import 'package:finnaport/services/authentication/googleauth_service.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Saran Lertprasertkong';
    final email = 'oat9837@gmail.com';
    final firebaseUser = context.watch<User>();
    final emailFirebase = firebaseUser.email;

    return Container(
      child: Drawer(
        child: Material(
            color: Palette.background,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: padding,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      buildHeader(
                        name: name,
                        email: emailFirebase,
                        onClicked: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PeoplePage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Profile Settings',
                  icon: Icons.person_outline,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Change Password',
                  icon: Icons.lock_outline,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 10),
                buildMenuItem(
                  text: 'Subscription',
                  icon: Icons.money,
                  onClicked: () => selectedItem(context, 0),
                ),
                buildMenuItem(
                  text: 'API key',
                  icon: Icons.vpn_key_outlined,
                  onClicked: () => selectedItem(context, 0),
                ),
                Divider(color: Colors.white),
                buildMenuItem(
                  text: 'Notifications',
                  icon: Icons.notifications_outlined,
                  onClicked: () => selectedItem(context, 0),
                ),
                Divider(color: Colors.white),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Help and Support',
                  icon: Icons.help_outline,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Terms and Agreement',
                  icon: Icons.info_outline,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Logout',
                  icon: Icons.logout,
                  onClicked: () {
                    if (context.read<GoogleAuthService>().signedIn == true) {
                      context.read<GoogleAuthService>().signOut();
                    } else {
                      context.read<AuthenticationService>().signOut();
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}

Widget buildHeader({
  //@required String urlImage,
  @required String name,
  @required String email,
  @required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.finnaGreenText),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Palette.finnaGold),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildMenuItem({
  @required String text,
  @required IconData icon,
  @required VoidCallback onClicked,
}) {
  final color = Colors.grey;
  final hoverColor = Palette.finnaGreen;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
      break;
  }
}
