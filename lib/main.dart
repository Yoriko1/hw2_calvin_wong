import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _input = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool calculationComplete = false;

  void buttonPressed(String buttonText) {
    
    //Change state of varibles on button press
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _input = "";
        num1 = 0;
        num2 = 0;
        operand = "";
        calculationComplete = false;
      //Set Operand
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        num1 = double.parse(_input);
        operand = buttonText;
        _input = "";
        calculationComplete = false;      
      } else if (buttonText == "=") {
        num2 = double.parse(_input);

      //Conditionals for operands
        if (operand == "+") {
          _output = (num1 + num2).toString();
        } else if (operand == "-") {
          _output = (num1 - num2).toString();
        } else if (operand == "×") {
          _output = (num1 * num2).toString();
        } else if (operand == "÷") {
          if(num2 == 0){
            _output= "Cannot divide by zero.";
          }
          else{
            _output = (num1 / num2).toString();            
          }
        }

        _input = _output;
        num1 = 0;
        num2 = 0;
        operand = "";
        calculationComplete = true;
      } else {
        //Clear the display and show new number after a calculation is done.
        if (calculationComplete) {
          _input = buttonText;
          calculationComplete = false;
        } else {
          _input += buttonText;
        }
        _output = _input;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 48.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(children: [
            Row(children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("÷"),
            ]),
            Row(children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("×"),
            ]),
            Row(children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ]),
            Row(children: [
              buildButton("0"),
              buildButton("."),
              buildButton("="),
              buildButton("+"),
            ]),
            Row(children: [
              buildButton("C"),
            ]),
          ])
        ],
      ),
    );
  }
}
