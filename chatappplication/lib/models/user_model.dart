import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String uid;
  String email;
  String name;
  String joinedAt;
  String image;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.image,
    required this.joinedAt,
  });

 factory UserModel.fromJson(DocumentSnapshot snapshot){
  return UserModel(
    email: snapshot['email'], 
    name: snapshot['fullName'], 
    uid: snapshot['uid'], 
    image: snapshot['profilePic'], 
    joinedAt: snapshot['jooinedAt']);
 }

}