import 'package:flutter/material.dart';
import 'package:healthlife/manager/medicament_manager.dart';
import 'package:healthlife/models/medicament.dart';
import 'package:provider/provider.dart';

class MedicamentItem extends StatefulWidget {
  MedicamentItem(Medicament a)
      : editing = a != null,
        medicament = a != null ? a.clone() : Medicament();

  final Medicament medicament;
  final bool editing;

  @override
  _MedicamentItemState createState() => _MedicamentItemState();
}
//Tela de cadastro de Medicamento

class _MedicamentItemState extends State<MedicamentItem>  {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text("Novo Medicamento",
                  textAlign: TextAlign.left,
                  style: TextStyle( color: Colors.teal),),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),                  child: TextFormField(
                    initialValue: widget.medicament.nome,
                    decoration: const InputDecoration(labelText: "Nome"),
                    onSaved: (nome) => widget.medicament.nome = nome,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nome não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),                  child: TextFormField(
                    initialValue: widget.medicament.valor.toString() == 'null' ? '' : widget.medicament.valor,
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: "Valor"),
                    onSaved: (valor) =>
                    widget.medicament.valor = valor,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Valor não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),                  child: TextFormField(
                    initialValue: widget.medicament.indicacao,
                    decoration: const InputDecoration(labelText: "Indicacao"),
                    onSaved: (indicacao) => widget.medicament.indicacao = indicacao,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Indicacao não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),                  child: TextFormField(
                  initialValue: widget.medicament.fornecedor,
                  decoration: const InputDecoration(labelText: "Fornecedor"),
                  onSaved: (fornecedor) => widget.medicament.fornecedor = fornecedor,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Fornecedor não foi preenchido';
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
                            onPressed: !widget.medicament.loading
                                ? () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                await widget.medicament.save();
                                context.read<MedicamentManager>()
                                    .update(widget.medicament);
                                Navigator.of(context).pop();
                              }
                            }
                                : null,
                            child: widget.medicament.loading
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
    );
  }
}