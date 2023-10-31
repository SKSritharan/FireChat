import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Contact> contacts = <Contact>[];

  Future<void> fetchContacts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('users').get();

      contacts = querySnapshot.docs.map((doc) {
        return Contact(
          uid: doc.id.toString(),
          name: doc['username'] as String,
          email: doc['email'] as String,
          profilePicture: doc['profile_picture'] as String,
        );
      }).toList();
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }
}

class Contact {
  final String uid;
  final String name;
  final String email;
  final String profilePicture;

  Contact({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePicture,
  });
}
