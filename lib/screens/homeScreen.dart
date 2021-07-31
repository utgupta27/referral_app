import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:referral_app/screens/allReferralsScreen.dart';
import 'package:referral_app/screens/referScreen.dart';
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
  // final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    _user = widget._user;
    setdata(_user.uid, _user.displayName, _user.email, _user.photoURL);
    // initUserDoc();
    super.initState();
  }

  setdata(uid, name, email, picUrl) {
    HomeScreen.data = [uid, name, email, picUrl];
  }

  // initUserDoc() {
  //   final CollectionReference userCol = _firebase.collection('users');
  //   userCol
  //       .doc(_user.email)
  //       .collection('referrals')
  //       .doc('init')
  //       .set({'init': 'configured'});
  //   userCol
  //       .doc(_user.email)
  //       .collection('referred')
  //       .doc('init')
  //       .set({'init': 'configured'});
  // }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => new AllReferralsScreen()),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Referral App"),
        actions: [
          PopupMenuButton<int>(onSelected: (item) {
            return onSelected(context, item);
          }, itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                child: Text("View Referrals"),
                value: 0,
              )
            ];
          })
        ],
      ),
      drawer: MyDrawer(),
      body: ReferScreen(),
    );
  }
}
