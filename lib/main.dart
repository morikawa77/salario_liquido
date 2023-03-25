import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatefulWidget {

  @override
  State<CalculadoraApp> createState() => _CalculadoraAppState();
}

class _CalculadoraAppState extends State<CalculadoraApp> {

  var _formKey = GlobalKey<FormState>();
  var ctrlSalarioBruto = TextEditingController();
  
  double salarioBruto = 0.0;
  double salarioLiquido = 0.0;
  double ir = 0.0;
  double inss = 0.0;
  double taxaInss = 0.0;
  double taxaIr = 0.0;

  void calcular() {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }

    if (salarioBruto <= 1302.00) {
      taxaInss = 0.075;
    } else if (salarioBruto <= 2427.35) {
      taxaInss = 0.09;
    } else if (salarioBruto <= 3641.03){
      taxaInss = 0.12;
    } else {
      taxaInss = 0.14;
    }

    inss = salarioBruto * taxaInss;

    salarioBruto = salarioBruto - inss;

    if (salarioBruto <= 1903.98) {
      taxaIr = 0.0;
    } else if (salarioBruto <= 2826.65){
      taxaIr = 0.075;
    } else if (salarioBruto <= 3751.05){
      taxaIr = 0.15;
    } else if (salarioBruto <= 4664.68){
      taxaIr = 0.225;
    } else {
      taxaIr = 0.275;
    }

    ir = salarioBruto * taxaIr;

    setState(() => salarioLiquido = salarioBruto - inss - ir);
  }

  void limpar(){
    ctrlSalarioBruto.clear();
    setState(() => salarioLiquido = 0.0);
    setState(() => ir = 0.0);
    setState(() => inss = 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculador Salário"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Salário Bruto"),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: ctrlSalarioBruto,
                  onSaved: (value) => salarioBruto = double.parse(value!),
                  validator: (value) {
                    if (value!.isEmpty || double.parse(value) <= 0)
                      return "Valor inválido";
                    else 
                      return null;
                  },
                )
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: calcular, 
                  child: Text("Calcular")
                ),
              ),
              Text("Salário Líquido"),
              Text("R\$ $salarioLiquido"),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Text("IR R\$ $ir"),
                  ),
                  Expanded(
                    child: Text("INSS R\$ $inss"),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: limpar, 
                  child: Text("Limpar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}