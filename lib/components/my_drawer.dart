import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_drawer_list_tile.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>>? getUserData() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          FutureBuilder(
            future: getUserData(),
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
                Map<String, dynamic>? data = snapshot.data!.data();

                return UserAccountsDrawerHeader(
                  accountName: Text(
                    data!['username'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  accountEmail: Text(
                    data['email'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                );
              }

              return const Center(
                child: Text('No data found'),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Column(
              children: [
                CustomDrawerListTile(
                  onTap: () => Navigator.pop(context),
                  title: 'H O M E',
                  icon: Icons.home,
                ),
                CustomDrawerListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                  title: 'P R O F I L E',
                  icon: Icons.person,
                ),
                CustomDrawerListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users');
                  },
                  title: 'U S E R S',
                  icon: Icons.group,
                ),
              ],
            ),
          ),
          CustomDrawerListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            title: 'L O G O U T',
            icon: Icons.logout,
            pBottom: 30,
          ),
        ],
      ),
    );
  }

  String _convertStringToAvatar(String string) {
    //  return all the first 2 letters of the string
    return string.substring(0, 2);
  }
}
