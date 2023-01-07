import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? username;
  String? email;
  String? password;
  String? designation;
  String? telephone;
  String? role;
  bool? isActivated;
  List<Map<String, dynamic>>? stations;
  DateTime? createdAt;
  // List<DataModel>? dataStation;

  UserModel(
      {this.userId,
      this.username,
      this.email,
      this.password = "2022@Inte-eco",
      this.designation,
      this.telephone,
      this.role,
      this.stations,
      this.isActivated,
      this.createdAt});

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final documentSnapshot = snapshot.data();
    return UserModel(
      userId: snapshot.id,
      username: documentSnapshot?['username'],
      email: documentSnapshot?['email'],
      designation: documentSnapshot?['designation'],
      telephone: documentSnapshot?['telephone'],
      role: documentSnapshot?['role'],
      stations: documentSnapshot?['stations'] is Iterable
          ? List.from(documentSnapshot?['stations'])
          : null,
      isActivated: documentSnapshot?['isActivated'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "username": username,
      if (email != null) "email": email,
      if (designation != null) "designation": designation,
      if (telephone != null) "telephone": telephone,
      if (role != null) "role": role,
      if (stations != null) "stations": stations,
      if (isActivated != null) "isActivated": isActivated,
    };
  }
}

class RoleUser {
  String titre;
  String valeur;

  RoleUser({required this.titre, required this.valeur});
}
