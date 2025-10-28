// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:my_tasks/core/entities/user_entity.dart';

// import '../../../logic/auth_bloc/sign_in_bloc.dart';
// import '../../widgets/flutter_toast.dart';

// enum AuthType { cridentials, google }

// class SignInController {
//   final BuildContext context;
//   // final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

//   SignInController({required this.context});

//   void handleSignIn(AuthType type) async {
//     try {
//       if (type == AuthType.cridentials) {
//         final state = context.read<SignInBloc>().state;

//         String email = state.email;
//         String password = state.password;

//         if (email.isEmpty) {
//           toastInfo(msg: "You nee to fill email address");
//           return;
//         }
//         if (email.isEmpty) {
//           toastInfo(msg: "You nee to fill password");
//           return;
//         }

//         try {
//           final credential = await FirebaseAuth.instance
//               .signInWithEmailAndPassword(email: email, password: password);
//           print(credential);
//           if (credential.user == null) {
//             toastInfo(msg: "You don't exist");
//             return;
//           }
//           if (!credential.user!.emailVerified) {
//             toastInfo(msg: "You need to verify your email account");
//             return;
//           }

//           final user = credential.user;
//           if (user != null) {
//             print("user Exist");

//             String? displayName = user.displayName;
//             String? email = user.email;
//             String? id = user.uid;
//             String? photoUrl = user.photoURL;

//             print('user open id $id');
//             print('user photo url $photoUrl');

//             UserEntity userEntity = UserEntity(
//               avatar: photoUrl,
//               name: displayName,
//               email: email,
//               openId: id,
//               type: 1, // type 1 means login
//             );

//             asyncPostAllData(userEntity);
//           } else {
//             // we have error getting user from firebase
//             toastInfo(msg: "Currently you are not a user of this app");
//             return;
//           }
//         } on FirebaseAuthException catch (e) {
//           if (e.code == "user-not-found") {
//             print('no user found for that email');
//             toastInfo(msg: "No user found for that email");
//           } else if (e.code == "wrong-password") {
//             print("wrong password provided fo that user");
//             toastInfo(msg: "Wrong password provided fo that user");
//           } else if (e.code == "invalid-email") {
//             print("Your email format is incorrect");
//             toastInfo(msg: "Your email format is incorrect");
//           } else if (e.code == "invalid-credential") {
//             print("invalid credentials");
//             toastInfo(msg: "Your email or password is incorrect");
//           } else {
//             print(e);
//           }
//         }
//       }

//       if (type == AuthType.google) {
//         try {
//           final user = await _googleSignIn.authenticate();

//           String? displayName = user.displayName;
//           String? email = user.email;
//           String? id = user.id;
//           String? photoUrl =
//               user.photoUrl ?? "${AppConstants.SERVER_UPLOADS}default.png";

//           LoginRequestEntity loginRequestEntity = LoginRequestEntity(
//             avatar: photoUrl,
//             name: displayName,
//             email: email,
//             openId: id,
//             type: 2, // type 1 means google
//           );

//           asyncPostAllData(loginRequestEntity);
//         } on FirebaseAuthException catch (e) {
//           if (e.code == "user-not-found") {
//             print('no user found for that email');
//             toastInfo(msg: "No user found for that email");
//           } else if (e.code == "wrong-password") {
//             print("wrong password provided fo that user");
//             toastInfo(msg: "Wrong password provided fo that user");
//           } else if (e.code == "invalid-email") {
//             print("Your email format is incorrect");
//             toastInfo(msg: "Your email format is incorrect");
//           } else if (e.code == "invalid-credential") {
//             print("invalid credentials");
//             toastInfo(msg: "Your email or password is incorrect");
//           } else {
//             print(e);
//           }
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void asyncPostAllData(UserEntity data) async {
//     EasyLoading.show(
//       indicator: CircularProgressIndicator(),
//       maskType: EasyLoadingMaskType.clear,
//       dismissOnTap: true,
//     );

//     User result = await UserAPI.login(params: data);
//     if (result.code == 200) {
//       try {
//         Global.storageService.setString(
//           AppConstants.STORAGE_USER_PROFILE_KEY,
//           jsonEncode(result.data!),
//         );
//         Global.storageService.setString(
//           AppConstants.STORAGE_USER_TOKEN_KEY,
//           result.data!.access_token!,
//         );
//         print(result.data!.access_token!);
//         EasyLoading.dismiss();
//         if (context.mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             AppRoutes.application,
//             (route) => false,
//           );
//         }
//       } catch (e) {
//         EasyLoading.dismiss();
//         print('Saving local storage error : ${e.toString()}');
//       }
//     } else {
//       EasyLoading.dismiss();
//       toastInfo(msg: "Unknow Error");
//     }
//   }
// }
