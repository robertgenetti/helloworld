import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _numberFrom;
  String _startMeasure = '';
  String _convertMeasure;
  String _resultMessage;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds',
    'ounces',
  ];
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds': 6,
    'ounces': 7,
  };
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle =
        TextStyle(fontSize: 60.0, color: Colors.greenAccent);
    final TextStyle labelStyle =
        TextStyle(fontSize: 24.0, color: Colors.grey[700]);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(widget.title)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 45.0,
              ),
              Text(
                'Value',
                style: labelStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  if (_numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom, _startMeasure, _convertMeasure);
                  }
                },
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'From',
                style: labelStyle,
              ),
              DropdownButton(
                isExpanded: true,
                value: _startMeasure,
                onChanged: (String newValue) => setState(() {
                  _startMeasure = newValue;
                  if (_numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom, _startMeasure, _convertMeasure);
                  }
                }),
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'To',
                style: labelStyle,
              ),
              DropdownButton(
                isExpanded: true,
                value: _convertMeasure,
                onChanged: (newValue) => setState(() {
                  _convertMeasure = newValue;
                  if (_numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom, _startMeasure, _convertMeasure);
                  }
                }),
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 35.0,
              ),
              Text(
                (_resultMessage == null) ? '' : _resultMessage,
                style: inputStyle,
              ),
              SizedBox(
                height: 15.0,
              ),
            ])),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _startMeasure = 'kilometers';
    _convertMeasure = 'miles';
    _numberFrom = 0;
    super.initState();
  }

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var calc = value * multiplier;
    var result = double.parse((calc).toStringAsFixed(3));
    if (calc != 0 && result == 0) {
      _message(double.parse((calc).toStringAsFixed(6)));
    } else {
      _message(result);
    }
  }

  void _message(double result) {
    if (result == 0) {
      setState(() {
        _resultMessage = 'This conversion cannot be performed';
      });
    } else if (_numberFrom == 1.00 && _startMeasure == 'feet') {
      setState(() {
        _resultMessage =
            '${_numberFrom.toString().trim()} foot is ${result.toString()} $_convertMeasure';
      });
    } else if (_numberFrom == 1.00) {
      setState(() {
        _resultMessage =
            '${_numberFrom.toString().trim()} ${_startMeasure.substring(0, _startMeasure.length -1)} is ${result.toString()} $_convertMeasure';
      });
    } else {
      setState(() {
        _resultMessage =
            '${_numberFrom.toString().trim()} $_startMeasure are ${result.toString()} $_convertMeasure';
      });
    }
  }
}
