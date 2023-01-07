import 'package:admin/controllers/realtime_controller.dart';
import 'package:admin/models/data_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class TempsReel extends StatelessWidget {
  TempsReel({
    Key? key,
  }) : super(key: key);

  RealTimeController controller = Get.put(RealTimeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tableau de données en temps réel",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(() => (controller.dataStation.length > 0)
                ? DataTable2(
                    // columnSpacing: defaultPadding,
                    minWidth: 600,
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    columns: [
                      DataColumn(
                        label: Text("Station"),
                      ),
                      DataColumn(
                        label: Center(child: Text("CO2")),
                      ),
                      DataColumn(
                        label: Center(child: Text("CO")),
                      ),
                      DataColumn(
                        label: Center(child: Text("H2S")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Date")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Humidité")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Température")),
                      ),
                    ],
                    rows: List.generate(
                      controller.dataStation.length <= 15
                          ? controller.dataStation.length
                          : 15,
                      (index) =>
                          recentFileDataRow(controller.dataStation[index]),
                    ),
                  )
                : Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: secondaryColor,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(DataModel dataStation) {
  return DataRow(
    cells: [
      DataCell(Text(dataStation.idStation!)),
      DataCell(Center(child: Text(dataStation.co2!))),
      DataCell(Center(child: Text(dataStation.co!))),
      DataCell(Center(child: Text(dataStation.h2s!))),
      DataCell(Center(child: Text(dataStation.date!.toDate().toString()))),
      DataCell(Center(child: Text(dataStation.tauxHumidite!))),
      DataCell(Center(child: Text(dataStation.temperature!))),
    ],
  );
}
