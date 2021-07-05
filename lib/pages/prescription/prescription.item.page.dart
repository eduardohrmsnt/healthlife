import 'package:flutter/material.dart';
import 'package:healthlife/manager/medicament_manager.dart';
import 'package:healthlife/manager/prescription_manager.dart';
import 'package:healthlife/models/prescription.dart';
import 'package:provider/provider.dart';

class PrescriptionItem extends StatefulWidget {
  PrescriptionItem(Prescription a)
      : editing = a != null,
        prescription = a != null ? a.clone() : Prescription();

  final Prescription prescription;
  final bool editing;

  @override
  _PrescriptionItemState createState() => _PrescriptionItemState();
}
//Tela de cadastro de Precricao
class _PrescriptionItemState extends State<PrescriptionItem>  {
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
                Text("Paciente",
                  textAlign: TextAlign.left,
                  style: TextStyle( color: Colors.teal),),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    initialValue: widget.prescription.nome,
                    decoration: const InputDecoration(labelText: "Nome"),
                    onSaved: (nome) => widget.prescription.nome = nome,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nome não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    initialValue: widget.prescription.cpf,
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: "Cpf"),
                    onSaved: (cpf) =>
                    widget.prescription.cpf = cpf,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Cpf não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    initialValue: widget.prescription.nascimento.toString() == 'null' ? '' : widget.prescription.nascimento,
                    decoration: const InputDecoration(labelText: "Nascimento"),
                    onSaved: (nascimento) => widget.prescription.nascimento = nascimento,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nascimento não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Text("Medicamentos",
                  textAlign: TextAlign.left,
                  style: TextStyle( color: Colors.teal),),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    initialValue: widget.prescription.medicamento,
                    decoration: const InputDecoration(labelText: "Medicamento"),
                    onSaved: (medicamento) => widget.prescription.medicamento = medicamento,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Medicamento não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    initialValue: widget.prescription.quantidade == 'null' ? '' :widget.prescription.quantidade ,
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: "Quantidade"),
                    onSaved: (quantidade) =>
                    widget.prescription.quantidade = quantidade,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Quantidade não foi preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    initialValue: widget.prescription.intervalo,
                    decoration: const InputDecoration(labelText: "Intervalo"),
                    onSaved: (intervalo) => widget.prescription.intervalo = intervalo,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Intervalo não foi preenchido';
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
                            onPressed: !widget.prescription.loading
                                ? () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                await widget.prescription.save();
                                context.read<PrescriptionManager>()
                                    .update(widget.prescription);
                                Navigator.of(context).pop();
                              }
                            }
                                : null,
                            child: widget.prescription.loading
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