import 'package:inte_eco_admin/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/user_controller.dart';

class AddClient extends StatefulWidget {
  AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  UserController _userController = Get.put(UserController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final roles = <RoleUser>[
    RoleUser(titre: "Utilisateur entreprise", valeur: "user"),
    RoleUser(titre: "Compte principal", valeur: "entreprise"),
    RoleUser(titre: "Super Admin", valeur: "admin"),
  ];

  String? role;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _designationController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
              child: (!_userController.isLoading)
                  ? Column(children: [
                      Text(
                        "Ajouter un nouveau client",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                          "Fournissez les informations relatives au nouveau client",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12)),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _designationController,
                        keyboardType: TextInputType.text,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir le nom ou la designation';
                          } else if (value.length < 3) {
                            return 'Le nom est trop court. (Min 3)';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Designation du client",
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
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir un nom d\'utilisateur unique';
                          } else if (value.length < 3) {
                            return 'Le nom est trop court. (Min 3)';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Nom d\'utilisateur du client",
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
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir le numero de telephone';
                          } else if (!value.isPhoneNumber) {
                            return 'Le numero est invalide';
                          } else if (value.length < 10) {
                            return 'Le numero est trop court';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Numero de telephone",
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre email';
                          } else if (!value.isEmail) {
                            return 'Cet email est invalide';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Adresse email de connexion",
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
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir un mot de passe';
                          } else if (value.length < 6) {
                            return 'Mot de passe trop court. Min 6';
                          }

                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Mot de passe par defaut",
                          fillColor: bgColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: role,
                              isExpanded: true,
                              iconSize: 36,
                              icon: const Icon(Icons.arrow_drop_down),
                              hint: Text('Role du client',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              items: roles.map(_buildMenuItem).toList(),
                              onChanged: (value) => setState(() {
                                    this.role = value as String?;
                                  })),
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              role != null &&
                              role!.isNotEmpty) {
                            _userController.addUser(UserModel(
                              designation: _designationController.text.trim(),
                              username: _usernameController.text.trim(),
                              telephone: _phoneController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              role: role!,
                              isActivated: true,
                              createdAt: DateTime.now(),
                              stations: [],
                            ));

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

  DropdownMenuItem<String> _buildMenuItem(RoleUser item) {
    return DropdownMenuItem<String>(
        value: item.valeur,
        child: Text(item.titre,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
