
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String admin;
  String groupIcon;
  String groupId;
  String groupName;
  List members;
  bool public;
  String recentMessage;
  String recentMessagesender;
  

  GroupModel({
    required this.admin,
    required this.groupIcon,
    required this.groupName,
    required this.members,
    required this.groupId,
    required this.recentMessage,
    required this.recentMessagesender,
    required this.public
  });

 factory GroupModel.fromJson(DocumentSnapshot snapshot){
  return GroupModel(
    admin: snapshot['admin'], 
    groupIcon: snapshot['groupIcon'], 
    groupId: snapshot['groupId'],
    groupName: snapshot['groupName'], 
    members: snapshot['membesrs'], 
    public: snapshot['public'],
    recentMessage: snapshot['recentMessage'],
    recentMessagesender: snapshot['recentMessagesender'],
    
    
);
 }
}