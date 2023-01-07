import 'package:admin/models/data_model.dart';
import 'package:admin/providers/data_provider.dart';
import 'package:get/get.dart';

class RealTimeController extends GetxController {
  final DataProvider _dataProvider = DataProvider();

  final _dataStation = <DataModel>[].obs;
  List<DataModel> get dataStation => _dataStation.value;

  final _isDataLoaded = false.obs;
  bool get isDataLoaded => _isDataLoaded.value;
  set isDataLoaded(bool value) => _isDataLoaded.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _dataStation.bindStream(_dataProvider.getRealData(() {
      isDataLoaded = true;
    }));
    ever(_dataStation, _onDtaChanged);
  }

  @override
  void onClose() {
    super.onClose();
  }

  _onDtaChanged(value) {
    // print(value.length);
  }
}
