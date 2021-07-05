import 'package:flutter/material.dart';
import 'package:healthlife/common/custom_drawer/custom_drawer.dart';
import 'package:healthlife/helpers/validator.dart';
import 'package:healthlife/manager/user_manager.dart';
import 'package:healthlife/models/user_app.dart';
import 'package:provider/provider.dart';
import 'reset.password.page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool passWordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scafoldKey,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          shadowColor: Colors.transparent,
        ),
        body: Container(
            color: Colors.teal,
            child: Card(
                shadowColor: Colors.transparent,
                margin: EdgeInsets.only(top: 90, left: 40, right: 40),
                color: Colors.teal,
                child: Form(
                    key: formKey,
                    child:
                        Consumer<UserManager>(builder: (_, userManager, child) {
                      return ListView(children: <Widget>[
                        SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.asset("assets/images/hospital.png")),
                        SizedBox(height: 20),
                        Text("HEALTH LIFE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 24,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          enabled: !userManager.loading,
                          decoration: const InputDecoration(
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20)),
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (email) {
                            if (!emailValid(email)) return 'E-mail inválido!';
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passController,
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20)),
                          style: TextStyle(fontSize: 20),
                          validator: (pass) {
                            if (pass.isEmpty || pass.length < 6) {
                              return 'Senha inválida!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 237, 205, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: SizedBox.expand(
                                child: FlatButton(
                              child: Text("LOGIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 131, 118, 1))),
                              onPressed: userManager.loading
                                  ? null
                                  : () {
                                      if (formKey.currentState.validate()) {
                                        userManager.signIn(
                                            user: UserApp(
                                                email: emailController.text,
                                                password: passController.text),
                                            onFail: (e) {
                                              scafoldKey.currentState
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Falha ao entrar: $e'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            },
                                            onSucess: () {
                                              Navigator.of(context)
                                                  .pushNamed('/');
                                            });
                                      }
                                    },
                            ))),
                      ]);
                    })))));
  }
}
