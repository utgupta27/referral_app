import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:referral_app/authentication/authentication.dart';
import 'package:referral_app/screens/signInScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Referral App"),
        actions: [
          IconButton(
              onPressed: () async {
                await Authentication.signOut(context: context);
                Navigator.of(context).pushReplacement(_routeToSignInScreen());
              },
              tooltip: "Logout",
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
