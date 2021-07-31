import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:referral_app/authentication/authentication.dart';
import 'package:referral_app/screens/homeScreen.dart';
import 'package:referral_app/screens/signInScreen.dart';

class MyDrawer extends StatefulWidget {
  static var data;
  MyDrawer() {
    data = HomeScreen.data;
  }
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              MyDrawer.data[1],
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            accountEmail: Text(
              MyDrawer.data[2],
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(MyDrawer.data[3]),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple),
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded, size: 30),
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () async {
              await Authentication.signOut(context: context);
              Navigator.of(context).pushReplacement(_routeToSignInScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_rounded, size: 30),
            title: Text(
              "Version",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text("0.1"),
            // trailing: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
