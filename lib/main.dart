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
  //Create variables
  String output = "0";
  String input = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool calculationDone = false;

  void buttonPressed(String buttonText) {
    
    //Change state of varibles on button press
    setState(() {
      if (buttonText == "C") {
        output = "0";
        input = "";
        num1 = 0;
        num2 = 0;
        operand = "";
        calculationDone = false;
      //Set Operand
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        num1 = double.parse(input);
        operand = buttonText;
        input = "";
        calculationDone = false;      
      } else if (buttonText == "=") {
        num2 = double.parse(input);

      //Conditionals for operands
        if (operand == "+") {
          output = (num1 + num2).toString();
        } else if (operand == "-") {
          output = (num1 - num2).toString();
        } else if (operand == "×") {
          output = (num1 * num2).toString();
        } else if (operand == "÷") {
          if(num2 == 0){
            output= "Cannot divide by zero.";
          }
          else{
            output = (num1 / num2).toString();            
          }
        }

        input = output;
        num1 = 0;
        num2 = 0;
        operand = "";
        calculationDone = true;
      } else {
        //Clear the display and show new number after a calculation is done.
        if (calculationDone) {
          input = buttonText;
          calculationDone = false;
        } else {
          input += buttonText;
        }
        output = input;
      }
    });
  }

  //Buttons for calculator
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
          //Display
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          //Create columns and rows for buttons
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
