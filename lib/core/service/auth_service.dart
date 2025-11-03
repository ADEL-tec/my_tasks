import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';
import '../values/constants.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createAcount({
    required UserEntity user,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: user.email!,
      password: password,
    );

    final map = user.toMap();
    map['createdAt'] = FieldValue.serverTimestamp();
    map['userId'] = userCredential.user!.uid;
    map['type'] = 1;
    await FirebaseFirestore.instance
        .collection(AppConstants.FIREBASE_COLLECTION_USERS)
        .doc(userCredential.user!.uid)
        .set(map);

    return userCredential;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateDisplayName({required String username}) async {
    await currentUser!.updateDisplayName(username);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential authCredential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await currentUser!.reauthenticateWithCredential(authCredential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }
}
