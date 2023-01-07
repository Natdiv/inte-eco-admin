import 'package:admin/models/data_model.dart';
import 'package:admin/providers/data_provider.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  final DataProvider _dataProvider = DataProvider();

  final _monthlyData = <DataModel>[].obs;
  List<DataModel> get monthlyData => _monthlyData.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _monthlyData.bindStream(_dataProvider.getDataPerMonth());
    // ever(_dataStation, _onDtaChanged);
  }

  @override
  void onClose() {
    super.onClose();
  }

  _onDtaChanged(value) {
    // print(value.length);
  }
}
