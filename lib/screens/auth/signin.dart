import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/auth_controller.dart';
import '../../responsive.dart';
import '../../routes/app_pages.dart';

class SigninPage extends StatefulWidget {
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            width: 350,
            //  height: 420,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 27,
                    color: Colors.black12,
                  ),
                ]),
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/logo/logo.png",
                      width: 100,
                      scale: 1,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Connexion",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Center(
                      child: Text("Veuillez vous connecter pour continuer",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12)),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir votre email';
                        } else if (!value.isEmail) {
                          return 'Cet email est invalide';
                        }

                        return null;
                      }),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Adresse email",
                        fillColor: bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIconColor: Colors.white,
                        suffixIcon: Container(
                          padding: EdgeInsets.all(defaultPadding * 0.75),
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    TextFormField(
                      controller: _passwordController,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un mot de passe';
                        } else if (value.length < 6) {
                          return 'Mot de passe trop court. Min 6';
                        }

                        return null;
                      }),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        fillColor: bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Container(
                            padding:
                                const EdgeInsets.all(defaultPadding * 0.75),
                            margin: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        disabledBackgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.login(_emailController.text.trim(),
                              _passwordController.text.trim());
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: Text("Se connecter"),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(() => authController.isLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox()),
                    const SizedBox(
                      height: 12,
                    ),
                    // Text("Ou créer un nouveau compte",
                    //     style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    //         color: Colors.white.withOpacity(0.5),
                    //         fontSize: 12)),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Get.offAllNamed(Routes.SIGNUP);
                    //   },
                    //   child: Text("Créer un compte",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .subtitle1
                    //           ?.copyWith(
                    //               color: Colors.white,
                    //               fontSize: 12,
                    //               decoration: TextDecoration.underline)),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
