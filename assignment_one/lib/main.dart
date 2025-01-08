import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumberPad(),
    );
  }
}

class NumberPad extends StatefulWidget {
  @override
  _NumberPadState createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> {
  String input = '';
  Map<int, int> noteCounts = {
    500: 0,
    100: 0,
    50: 0,
    20: 0,
    10: 0,
    5: 0,
    2: 0,
    1: 0
  };

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
      } else if (value == '<') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else {
        input += value;
      }
      _updateNoteCounts();
    });
  }

  void _updateNoteCounts() {
    int amount = int.tryParse(input) ?? 0;
    Map<int, int> tempCounts = {
      500: 0,
      100: 0,
      50: 0,
      20: 0,
      10: 0,
      5: 0,
      2: 0,
      1: 0
    };

    for (int note in tempCounts.keys) {
      if (amount >= note) {
        tempCounts[note] = amount ~/ note;
        amount %= note;
      }
    }
    noteCounts = tempCounts;
  }

  Widget _buildButton(String value) {
    double screenHeight = MediaQuery.of(context).size.height;
    print("Screen Height for build button: ${screenHeight}");
    return Expanded(
      child: GestureDetector(
        onTap: () => _onButtonPressed(value),
        child: Container(
          margin: EdgeInsets.all(4.0),
          height: screenHeight * 0.085,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: noteCounts.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '${entry.key}: ${entry.value}',
            style: TextStyle(fontSize: 18.0),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    print("Screen Width: ${screenWidth}");
    print("Screen Height: ${screenHeight}");

    return Scaffold(
      appBar: AppBar(
        title: Text('BhangtiChai',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),
        ),
        centerTitle: false, // Aligns the title to the left
        backgroundColor: Color.fromRGBO(66, 159, 66, 1.0), // Sets the background color to green
      ),
      body: Row(
        children: [
          // Left Panel for Notes
          Container(
            width: screenWidth * 0.2,
            padding: EdgeInsets.all(5),
            color: Colors.blueGrey[50],
            child: _buildNoteCounter(),
          ),

          // Right Panel for Number Pad
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Taka: $input',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.025),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: ['1', '2', '3'].map(_buildButton).toList(),
                      ),
                      Row(
                        children: ['4', '5', '6'].map(_buildButton).toList(),
                      ),
                      Row(
                        children: ['7', '8', '9'].map(_buildButton).toList(),
                      ),
                      Row(
                        children: ['C', '0', '<'].map(_buildButton).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}