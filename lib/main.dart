// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eval_ex/expression.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var num_calculo = '';
  double resultado = 0;
  var parentese_aberto = 0;

  void dados(String nome) {
    if (nome == 'AC') {
      limpeza();
    } else if (nome == '=') {
      calculo();
    } else if (nome == '%') {
    } else if (num_calculo == '' && nome == '.') {
    } else if (nome == '<') {
    } else {
      if (nome == '( )' && parentese_aberto == 0) {
        setState(() {
          parentese_aberto = 1;
          nome = '(';
        });
        print(parentese_aberto);
      } else if (nome == '( )' && parentese_aberto != 0) {
        setState(() {
          parentese_aberto = 0;
          nome = ')';
        });
      }
      setState(() {
        num_calculo = num_calculo + nome;
      });
    }
  }

  void limpeza() {
    setState(() {
      num_calculo = '';
      resultado = 0;
    });
  }

  void calculo() {
    Expression exp = Expression(num_calculo);

    setState(() {
      resultado = exp.eval()!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora '),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '$num_calculo',
                        style: TextStyle(fontSize: 60),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${resultado.toStringAsPrecision(3)}',
                        style: TextStyle(
                          fontSize: 60,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TeclasButtons('AC', Colors.white, 20,
                        Color.fromARGB(255, 186, 253, 169), 25),
                    TeclasButtons('( )', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 25),
                    TeclasButtons('%', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 30),
                    TeclasButtons('/', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 30),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TeclasButtons('7', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('8', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('9', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('*', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 30),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TeclasButtons('4', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('5', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('6', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('+', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 30),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TeclasButtons('1', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('2', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('3', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('-', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 30),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TeclasButtons('0', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('.', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('<', Colors.white, 20, Colors.grey, 30),
                    TeclasButtons('=', Colors.white, 20,
                        Color.fromARGB(255, 151, 203, 245), 30),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget TeclasButtons(
      String nome, Color lestilo, double font, Color backround, double padd) {
    return ElevatedButton(
      child: Text(
        nome,
      ),
      style: ElevatedButton.styleFrom(
        primary: backround,
        onPrimary: lestilo,
        padding: EdgeInsets.all(padd),
        shape: CircleBorder(),
        textStyle: TextStyle(
          fontSize: font,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        dados(nome);
      },
    );
  }
}
