import 'package:admin/models/data_model.dart';
import 'package:admin/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class DataProvider {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final functions = FirebaseFunctions.instance;

  Future<UserModel?> getUserById(String uid) async {
    final docRef = firebaseFirestore.collection("accounts").doc(uid);

    final ref = firebaseFirestore.collection("accounts").doc(uid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel _user, _) => _user.toFirestore(),
        );
    final docSnap = await ref.get();
    final user = docSnap.data();
    return user;
  }

  Future<List<UserModel>> getEntreprises() async {
    final ref = firebaseFirestore
        .collection("accounts")
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel _user, _) => _user.toFirestore(),
        )
        .where('role', isNotEqualTo: 'admin');

    final querySnapshot = await ref.get();
    final entreprises = querySnapshot.docs.map((e) => e.data()).toList();
    return entreprises;
  }

  Future<List<Map<String, dynamic>>?> getStationsByClient(String uid) async {
    final ref = firebaseFirestore.collection("accounts").doc(uid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel _user, _) => _user.toFirestore(),
        );

    final querySnapshot = await ref.get();
    final stations = querySnapshot.data()!.stations;
    return stations;
  }

  Stream<List<DataModel>> getRealData(Function callback) {
    return firebaseFirestore
        .collection('data_station')
        .limit(100)
        .orderBy("date", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<DataModel> data = [];
      for (var d in query.docs) {
        final dataModel = DataModel.fromDocumentSnapshot(documentSnapshot: d);
        data.add(dataModel);
        // print(dataModel.dateValue!['second']);
      }
      callback();
      return data;
    });
  }

  Stream<List<DataModel>> getDataPerMonth() {
    int year = DateTime.now().year;
    int month = DateTime.now().month;

    return firebaseFirestore
        .collection('data_station')
        // .where('date_value.month', isLessThanOrEqualTo: month)
        .orderBy("date", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<DataModel> data = [];
      for (var d in query.docs) {
        final dataModel = DataModel.fromDocumentSnapshot(documentSnapshot: d);
        data.add(dataModel);
      }
      // print(data);
      return data;
    });
  }

  Future<void> addUser(UserModel userModel) async {
    final ref = firebaseFirestore
        .collection("accounts")
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel _user, _) => _user.toFirestore(),
        )
        .doc(userModel.userId);

    final querySnapshot = await ref.set(userModel);
    print("Added client");
    return querySnapshot;
  }

  Future<void> addStation(String uid, Map<String, dynamic> station) {
    final ref = firebaseFirestore
        .collection("accounts")
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel _user, _) => _user.toFirestore(),
        )
        .doc(uid);

    return ref.update({
      'stations': FieldValue.arrayUnion([station])
    });
  }

  Future<HttpsCallableResult> createUserWithEmailAndPassword(
      String email, String password) {
    // functions.useFunctionsEmulator("127.0.0.1", 5001);
    final HttpsCallable createUser = functions.httpsCallable(
      'createUser',
    );
    return createUser.call(<String, dynamic>{
      'email': email,
      'password': password,
    });
  }
}
