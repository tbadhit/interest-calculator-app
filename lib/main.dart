import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Membuat Aplikasi Calculator Sederhana',
      theme: ThemeData(
        primaryColor: Color(0xff72af13),
      ),
      home: SIForm(),
    );
  }
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _itemDropDown = ['Flutter', 'Kotlin', 'Java', 'IOS'];

  final _minimumPading = 5.0;

  var _currentItemSelected = '';

  var displayResult = '';

  var _formKey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentItemSelected = _itemDropDown[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Interest Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPading * 2),
          child: ListView(
            children: <Widget>[
              // NOTE: Image :
              getImageAsset(),
              // NOTE: Ini TextField :
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: _minimumPading,
                ),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter principal amount';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        labelStyle: textStyle,
                        hintText: 'Enter Principal e.g 12000',
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
              ),
              // NOTE: TextField
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: _minimumPading,
                ),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter rate of interest';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        labelStyle: textStyle,
                        hintText: 'In Percent',
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: _minimumPading),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter term';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              labelStyle: textStyle,
                              hintText: 'Term in years',
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)))),
                    ),
                    SizedBox(
                      width: _minimumPading * 5,
                    ),
                    Expanded(
                        child: DropdownButton(
                      items: _itemDropDown.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: _minimumPading),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = _calculateTotalReturns();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Result'),
                                      content: Text(this.displayResult),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'))
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Text(
                            'Calculate',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color(0xff72af13),
                          textColor: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff72af13),
                      textColor: Theme.of(context).primaryColorLight,
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/logo-app.png');
    Image image = Image(
      image: assetImage,
      width: 220.0,
      height: 220.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPading * 2),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    this._currentItemSelected = newValueSelected;
  }

  String _calculateTotalReturns() {
    double princpal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    int term = int.parse(termController.text);

    double totalAmountPayable = princpal + (princpal * roi * term) / 100;
    String result =
        'After $term years, your invesment will be worth  $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = '';
    _currentItemSelected = _itemDropDown[0];
  }
}
