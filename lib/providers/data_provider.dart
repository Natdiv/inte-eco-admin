import 'package:inte_eco_admin/models/data_model.dart';
import 'package:inte_eco_admin/models/user_data.dart';
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

  Future<List<DataModel>> getDataPerMonth() async {
    var initDay = -1;
    var cpt = 0;
    double sumCo = 0;
    double sumCo2 = 0;
    double sumH2s = 0;
    double sumHumidity = 0;
    double sumTemperature = 0;
    DataModel dataModel = DataModel();

    final ref = firebaseFirestore
        .collection("data_station")
        .withConverter(
          fromFirestore: DataModel.fromFirestore,
          toFirestore: (DataModel _data, _) => _data.toFirestore(),
        )
        .orderBy("date");

    final querySnapshot = await ref.get();
    List<DataModel> data = [];
    var allData = querySnapshot.docs.map((e) => e.data()).toList();
    allData.add(DataModel(
        co: "0",
        co2: "0",
        h2s: "0",
        tauxHumidite: "0",
        temperature: "0",
        dateValue: {'day': 0, 'month': 0, 'year': 0},
        date: dataModel.date));
    for (var d in allData) {
      dataModel = d;
      if (dataModel.dateValue?['day'] != initDay) {
        if (initDay != -1) {
          data.add(DataModel(
              co: (sumCo / cpt).toStringAsFixed(2),
              co2: (sumCo2 / cpt).toStringAsFixed(2),
              h2s: (sumH2s / cpt).toStringAsFixed(2),
              tauxHumidite: (sumHumidity / cpt).toStringAsFixed(2),
              temperature: (sumTemperature / cpt).toStringAsFixed(2),
              dateValue: allData[(allData.indexOf(dataModel) - 1)].dateValue,
              date: allData[(allData.indexOf(dataModel) - 1)].date));
        }

        cpt = 1;
        initDay = dataModel.dateValue?['day'];
        sumCo = double.parse(dataModel.co!);
        sumCo2 = double.parse(dataModel.co2!);
        sumH2s = double.parse(dataModel.h2s!);
        sumHumidity = double.parse(dataModel.tauxHumidite!);
        sumTemperature = double.parse(dataModel.temperature!);
        // initMinute = dataModel.dateValue?['day'];
      } else {
        sumCo += double.parse(dataModel.co!);
        sumCo2 += double.parse(dataModel.co2!);
        sumH2s += double.parse(dataModel.h2s!);
        sumHumidity += double.parse(dataModel.tauxHumidite!);
        sumTemperature += double.parse(dataModel.temperature!);
        cpt++;
      }
    }
    return data;
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
