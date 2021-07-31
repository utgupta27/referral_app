import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:referral_app/screens/scaffoldDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;
  static var data = [];
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    _user = widget._user;
    setdata(_user.uid, _user.displayName, _user.email, _user.photoURL);
    initUserDoc();
    super.initState();
  }

  setdata(uid, name, email, picUrl) {
    HomeScreen.data = [uid, name, email, picUrl];
  }

  initUserDoc() {
    final CollectionReference userCol = _firebase.collection('users');
    userCol
        .doc(_user.email)
        .collection('referrals')
        .doc('init')
        .set({'init': 'configured'});
    userCol
        .doc(_user.email)
        .collection('referred')
        .doc('init')
        .set({'init': 'configured'});
  }

  // Route _routeToSignInScreen() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Referral App"),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await Authentication.signOut(context: context);
        //         Navigator.of(context).pushReplacement(_routeToSignInScreen());
        //       },
        //       tooltip: "Logout",
        //       icon: Icon(Icons.logout_outlined))
        // ],
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text("${_user.email.toString()}"),
      ),
    );
  }
}
