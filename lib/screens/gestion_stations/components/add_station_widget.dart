import 'package:admin/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/station_controller.dart';

class AddStation extends StatefulWidget {
  AddStation({Key? key}) : super(key: key);

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
  StationController _stationController = Get.put(StationController());

  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _emplacementController = TextEditingController();
  final TextEditingController _codeUniqueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? client;

  @override
  void initState() {
    super.initState();
    _stationController.getClientsList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: secondaryColor,
        ),
        child: Form(
          key: _formKey,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
              child: (!_stationController.isLoading)
                  ? Column(children: [
                      Text(
                        "Ajouter une station",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text("Fournissez les informations relatives à la station",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12)),
                      const SizedBox(height: 32),
                      (_stationController.entreprises.length > 0)
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: client,
                                    isExpanded: true,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    hint: Text(
                                        'À quel client associer la station ?',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    items: _stationController.entreprises
                                        .map(_buildMenuItem)
                                        .toList(),
                                    onChanged: (value) => setState(() {
                                          this.client = value as String?;
                                        })),
                              ),
                            )
                          : Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  'Aucun client trouvé, veuillez en créer un',
                                  style: const TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _designationController,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir une designation';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Designation de la station",
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: _emplacementController,
                        keyboardType: TextInputType.text,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir une valeur';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Future emplacement / Zone",
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: _codeUniqueController,
                        keyboardType: TextInputType.text,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir une valeur';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Code unique",
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          disabledBackgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              client != null &&
                              _stationController.entreprises.length > 0) {
                            var station = {
                              "code": _codeUniqueController.text.trim(),
                              "emplacement": _emplacementController.text.trim(),
                              "designation": _designationController.text.trim(),
                            };

                            _stationController.addStation(client!, station);
                            _formKey.currentState!.reset();
                          }
                        },
                        child: Text("Valider les informations"),
                      ),
                    ])
                  : Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()),
                    )),
        )));
  }

  DropdownMenuItem<String> _buildMenuItem(UserModel item) {
    return DropdownMenuItem<String>(
        value: item.userId,
        child: Text(item.designation!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
