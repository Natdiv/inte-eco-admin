import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  String? documentId;
  String? idStation;
  Timestamp? date;
  String? co;
  String? co2;
  String? h2s;
  String? temperature;
  String? tauxHumidite;
  Map<String, dynamic>? dateValue;

  DataModel(
      {this.idStation,
      this.date,
      this.co,
      this.co2,
      this.h2s,
      this.temperature,
      this.tauxHumidite,
      this.dateValue});

  DataModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    idStation = documentSnapshot['id_station'];
    date = documentSnapshot['date'];
    co = documentSnapshot['co'];
    co2 = documentSnapshot['co2'];
    h2s = documentSnapshot['h2s'];
    temperature = documentSnapshot['temperature'];
    tauxHumidite = documentSnapshot['humidity'];
    dateValue = documentSnapshot['date_value'];
  }

  factory DataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final documentSnapshot = snapshot.data();
    return DataModel(
        idStation: documentSnapshot?['id_station'],
        date: documentSnapshot?['date'],
        co: documentSnapshot?['co'],
        co2: documentSnapshot?['co2'],
        h2s: documentSnapshot?['h2s'],
        temperature: documentSnapshot?['temperature'],
        tauxHumidite: documentSnapshot?['humidity'],
        dateValue: documentSnapshot?['date_value']);
  }

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{};
    data['id_station'] = idStation;
    data['date'] = date;
    data['co'] = co;
    data['co2'] = co2;
    data['h2s'] = h2s;
    data['temperature'] = temperature;
    data['taux_humidite'] = tauxHumidite;
    data['date_value'] = dateValue;
    return data;
  }

  DataModel.fromJson(Map<String, dynamic> json) {
    idStation = json['id_station'];
    date = json['date'];
    co = json['co'];
    co2 = json['co2'];
    h2s = json['h2s'];
    temperature = json['temperature'];
    tauxHumidite = json['taux_humidite'];
    dateValue = json['date_value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_station'] = idStation;
    data['date'] = date;
    data['co'] = co;
    data['co2'] = co2;
    data['h2s'] = h2s;
    data['temperature'] = temperature;
    data['taux_humidite'] = tauxHumidite;
    data['date_value'] = dateValue;
    return data;
  }
}

class DateValue {
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;
  int? second;

  DateValue(
      {this.year, this.month, this.day, this.hour, this.minute, this.second});
}
