import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:referral_app/screens/allReferralsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:referral_app/screens/scaffoldDrawer.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({Key? key}) : super(key: key);

  @override
  ReferScreenState createState() {
    return ReferScreenState();
  }
}

class ReferScreenState extends State<ReferScreen> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  addReferralData() {
    final CollectionReference userCol = _firebase.collection('users');
    userCol.doc(MyDrawer.data[2]).collection('referrals').doc(email.text).set({
      "date": DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                    'assets/31821-share-everythin-moneybooks.json'),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: email,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Email ',
                      filled: true,
                      // fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Referred Successfully'),
                          ),
                        );
                        // print(email.text);
                        addReferralData();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => new AllReferralsScreen()),
                        );
                      }
                    },
                    child: Text("Submit")),
              ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 16.0),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         if (_formKey.currentState!.validate()) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(content: Text('Processing Data')),
              //           );
              //         }
              //       },
              //       child: const Text('Submit'),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
