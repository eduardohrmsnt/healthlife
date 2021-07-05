import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthlife/manager/company_manager.dart';
import 'package:healthlife/models/company.dart';

class CompanyItem extends StatefulWidget {
  CompanyItem(Company a)
      : editing = a != null,
        company = a != null ? a.clone() : Company();

  final Company company;
  final bool editing;

  @override
  _CompanyItemState createState() => _CompanyItemState();
}
//Tela de cadastro de fornecedores
class _CompanyItemState extends State<CompanyItem>  {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.company,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          shadowColor: Colors.transparent,
        ),
        body:Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                   Text(widget.editing == true ? "Editando Fornecedor": "Novo Fornecedor",
                    textAlign: TextAlign.left,
                    style: TextStyle( color: Colors.teal),),

                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      initialValue: widget.company.razaosocial,
                      decoration: const InputDecoration(labelText: "Razão Social"),
                      onSaved: (razaosocial) => widget.company.razaosocial = razaosocial,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Razão Social não foi preenchido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),                    child: TextFormField(
                      initialValue: widget.company.cnpj,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "CNPJ"),
                      onSaved: (cnpj) =>
                      widget.company.cnpj = cnpj,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'CNPJ não foi preenchido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),                    child: TextFormField(
                      initialValue: widget.company.email,
                      decoration: const InputDecoration(labelText: "UF"),
                      onSaved: (email) => widget.company.email = email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'UF não foi preenchido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),                    child: TextFormField(
                      initialValue: widget.company.cidade,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "Cidade"),
                      onSaved: (cidade) =>
                      widget.company.cidade = cidade,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Cidade não foi preenchido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),                    child: TextFormField(
                      initialValue: widget.company.telefone,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "Telefone"),
                      onSaved: (telefone) =>
                      widget.company.telefone = telefone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Telefone não foi preenchido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),                    child: TextFormField(
                      initialValue: widget.company.email,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "Email"),
                      onSaved: (email) =>
                      widget.company.email = email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email não foi preenchido';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 300,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 40,
                            width: 200,
                            child: RaisedButton(
                              onPressed: !widget.company.loading
                                  ? () async {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  await widget.company.save();
                                  context.read<CompanyManager>()
                                      .update(widget.company);
                                  Navigator.of(context).pop();
                                }
                              }
                                  : null,
                              child: widget.company.loading
                                  ? CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation(Colors.white),
                              )
                                  : const Text('Salvar', style: TextStyle(color: Colors.white),),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    ));
  }
}