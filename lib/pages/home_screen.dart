import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media/components/my_drawer.dart';
import 'package:mini_social_media/components/my_textfield.dart';
import 'package:mini_social_media/database/firestore.dart';

import '../components/my_post_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController chatController = TextEditingController();
  FireBaseDatabaseService databaseService = FireBaseDatabaseService();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  _postMessage() {
    if (chatController.text.isNotEmpty) {
      databaseService.addPost(chatController.text);
      chatController.clear();
    }
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W A L L'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Say something", controller: chatController),
                ),
                MyPostButton(
                  onTap: () => _postMessage(),
                )
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: databaseService.getPostsStream(),
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
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                        snapshot.data!.docs;
                    // print('==== ${data!.docs.length} ====');

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          title: Text(
                            data[index]['post'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(data[index]['email']),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text('No posts'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
