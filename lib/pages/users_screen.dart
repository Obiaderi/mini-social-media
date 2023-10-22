import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media/components/my_back_button.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;

            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: MyBackButton(),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      shrinkWrap: true,
                      itemCount: data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            data.docs[index]['username'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(data.docs[index]['email']),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('No data found'),
          );
        },
      ),
    );
  }
}
