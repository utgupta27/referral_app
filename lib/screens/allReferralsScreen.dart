import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:referral_app/screens/homeScreen.dart';
import 'package:intl/intl.dart';

class AllReferralsScreen extends StatelessWidget {
  const AllReferralsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firebase = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Referrals"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: new StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _firebase
              .collection("users")
              .doc(HomeScreen.data[2])
              .collection('referrals')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: InkWell(
                      child: new Card(
                        child: ExpansionTile(
                          // backgroundColor: Colors.blue[100],
                          collapsedBackgroundColor: Colors.grey[100],
                          title: Text(
                            document.id,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              // color: Colors.deepPurple
                            ),
                          ),
                          // subtitle: ,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Date: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(document.data()['date'].microsecondsSinceEpoch))}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Time: ${DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(document.data()['date'].microsecondsSinceEpoch))}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // DistrictPage.sCode = document.id.toString();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => new DistrictPage()));
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
