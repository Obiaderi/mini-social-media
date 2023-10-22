import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseDatabaseService {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

// Create Post
  Future<void> addPost(String post) {
    return posts.add({
      'post': post,
      'user': user!.uid,
      'email': user!.email,
      'createdAt': DateTime.now(),
    });
  }

  // Read Post
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return postsStream;
  }
}
