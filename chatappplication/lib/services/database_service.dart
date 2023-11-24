import 'package:chatapplication/models/group_model.dart';
import 'package:chatapplication/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? userId;
  DatabaseService({this.userId});

  // refrence for our collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollectio =
      FirebaseFirestore.instance.collection("groups");

  // Intrestin neew user data
  Future insertUserData(
      String? fullName, String? email, String? profilePic) async {
    // check if user data already exist
    DocumentSnapshot getUser = await userCollection.doc(userId).get();

    if (!getUser.exists) {
      await userCollection.doc(userId).set({
        'uid': userId,
        "fullName": fullName,
        "email": email,
        "profilePic": profilePic,
        "jooinedAt": DateTime.now().toString(),
      });
    }
  }

  // get user data and return a userModel instance
  Future<UserModel> getUserdata() async {
    DocumentSnapshot result = await userCollection.doc(userId).get();
    if (!result.exists) {
      await Future.delayed(const Duration(seconds: 2));
      result = await userCollection.doc(userId).get();
    }

    UserModel userModel = UserModel.fromJson(result);
    return userModel;
  }

  // creating new group

  Future createGroup(String groupName) async {
    DocumentReference documentReference = await groupCollectio.add({
      "groupId": "",
      "groupName": groupName,
      "groupIcon": "",
      "admin": userId,
      "membesrs": [userId],
      "recentMessage": "",
      "recentMessagesender": "",
      "public": true,
      "searchKeywords": getSearchKeywords(groupName)
    });
    await groupCollectio
        .doc(documentReference.id)
        .update({"groupId": documentReference.id});
    // update the ovove inserted group with its own doc id
  }

  // fetch all groups joined by user
  Stream<List<GroupModel>> fetchJoinedGroup() async* {
    yield* groupCollectio
        .where("membesrs", arrayContains: userId)
        .snapshots()
        .map((groups) =>
            groups.docs.map((group) => GroupModel.fromJson(group)).toList());
  }

  // joinn group functionality

  Future<void> joinGroup(String groupId) async {
    await groupCollectio.doc(groupId).update({
      "membesrs": FieldValue.arrayUnion([userId])
    });
  }

  // for exit group functionality
  Future<void> exitGroup(String groupId) async {
    await groupCollectio.doc(groupId).update({
      "membesrs": FieldValue.arrayRemove([userId])
    });
  }

  // function to make a list of keywords to search the groups

  List<String> getSearchKeywords(String groupName) {
    List<String> searchkeywordList = [groupName.toLowerCase()];
    List<String> words = groupName.split(" ");
    String temp = '';

    for (var word in words) {
      for (int i = 0; i < word.length; i++) {
        temp = temp + word.toLowerCase()[i];
        searchkeywordList.add(temp);
        if (i == word.length - 1) {
          temp = "";
        }
      }
    }
    return searchkeywordList;
  }

  // fetch searched groups
  Stream<List<GroupModel>> fetchSearchedGroups(String searchName) async* {
    yield* groupCollectio
        .where("searchKeywords", arrayContains: searchName.toLowerCase())
        .snapshots()
        .map((groups) =>
            groups.docs.map((group) => GroupModel.fromJson(group)).toList());
  }

  // fetch all groups
  Stream<List<GroupModel>> fetchAllGroups() async* {
    yield* groupCollectio.snapshots().map((groups) =>
        groups.docs.map((group) => GroupModel.fromJson(group)).toList());
  }

  // send message functionality
  Future<void> sendMessage(
      String message, String groupId, String userId) async {
    UserModel userData = await getUserdata();
    await groupCollectio.doc(groupId).collection("messages").add({
      "message": message,
      "senderId": userId,
      "senderName": userData.name,
      "time": DateTime.now(),
    });
    // update groups info

    await groupCollectio.doc(groupId).update(
        {"recentMessage": message, "recentMessagesender": userData.name});
  }

  // fetch all messages
  Stream getChats(String groupId) async* {
    yield* groupCollectio
        .doc(groupId)
        .collection("messages")
        .orderBy("time", descending: true)
        .snapshots();
  }
}
