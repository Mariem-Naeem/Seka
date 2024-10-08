

import 'package:firebase_auth/firebase_auth.dart';
class Visa{
 late String numberCard="";
 late String yearExpired="";
 late String cvv="";

  Visa(String numberCard , String  yearExpired ,String cvv);
}
class FireBaseHelper {
 FirebaseAuth auth =FirebaseAuth.instance;
 Future<dynamic>signUp( String name , String email , String password , String phoneNum , String address , Visa visa ) async{
  try{
   UserCredential user= await auth.createUserWithEmailAndPassword(email: email, password: password);
   await auth.currentUser!.updateDisplayName(name);

   String phonenum = phoneNum;
   String cardNumber = visa.numberCard;
   String expirationYear = visa.yearExpired;
   String cvvCode = visa.cvv;
   await auth.currentUser!.reload();
   return user.user;
  } on FirebaseAuthException catch (e) {

   if (e.code == 'email-already-in-use')
    return "email is already used";
   else if (e.code == 'weak-password')
    return "password is too weak";

  }
 }
 Future<dynamic> signIn(String email, String password) async {
  try {
   UserCredential user = await auth.signInWithEmailAndPassword(email: email ,password: password);

   if (user.user != null){
    return user.user;
  }
 }
   on FirebaseAuthException catch (e) {
   return e.code;
   }

 }

 void signOut() async{
  await auth.signOut();
 }
}