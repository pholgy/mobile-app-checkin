import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clock-In History')),
      body: StreamBuilder(
        stream: _firestore.collection('clock_ins').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          var clockIns = snapshot.data!.docs;
          return ListView.builder(
            itemCount: clockIns.length,
            itemBuilder: (context, index) {
              var clockIn = clockIns[index];
              return ListTile(
                title: Text('Clocked In: ${clockIn['startTime']}'),
                subtitle: Text('Location: ${clockIn['TIME_IN_LOCATION']}'),
              );
            },
          );
        },
      ),
    );
  }
}
