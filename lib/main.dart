import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => BacHomeScreen(),
      '/second': (context) => BackResultsScreen(),
      '/settings': (context) => BackSettingsScreen(),
    },
  ));
}

class User {
  final String name;
  final double wieght;
  final int numberofDrinks;
  final String gender;

  User({this.name, this.gender, this.numberofDrinks, this.wieght});
}

class BacHomeScreen extends StatefulWidget {
  @override
  _BackFormState createState() => _BackFormState();
}

class _BackFormState extends State<BacHomeScreen> {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _weightcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _agecontroller.dispose();
    _weightcontroller.dispose();
    super.dispose();
  }

  Widget bigColorfulBox() {
    return Container(
        height: 32.0,
        width: 90.0,
        padding: const EdgeInsets.all(5.0),
        margin: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue[500],
        ),
        child: FloatingActionButton(
          child: Icon(Icons.chevron_right),
          onPressed: () {
            if (_namecontroller.text == '' ||
                _agecontroller.text == '' ||
                _weightcontroller.text == '') {
              return null;
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BackResultsScreen(
                            age: int.parse(_agecontroller.text),
                            name: _namecontroller.text,
                            weight: double.parse(_weightcontroller.text),
                          )));
            }
          },
        ));
  }

  Widget dahedOutline() {
    return Container(
      height: 200.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'BAC Calculator',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, 'settings');
              },
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  autovalidate: true,
                  validator: (str) {
                    return str == null
                        ? 'Must type something before procceding!'
                        : null;
                  },
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  autovalidate: true,
                  validator: (str) {
                    return str == null
                        ? 'Must type something before procceding!'
                        : null;
                  },
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: _weightcontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter your weight (pounds)',
                    icon: Icon(Icons.account_balance_wallet),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  autovalidate: true,
                  validator: (str) {
                    return str == null
                        ? 'Must type something before procceding!'
                        : null;
                  },
                  controller: _agecontroller,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Enter number of cups you had',
                    icon: Icon(Icons.local_drink),
                  ),
                ),
              ),
              bigColorfulBox(),
            ],
          ),
        ));
  }
}

class BackResultsScreen extends StatelessWidget {
  BackResultsScreen(
      {@required this.name, @required this.age, @required this.weight});
  final String name;
  final double weight;
  final int age;

  String _getBac(double weight, int amountofDrinks) {
    var bac =
        ((600 * amountofDrinks) / (weight * (0.06 * amountofDrinks + 169)));
    return bac.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final userArgument = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Column(
          children: <Widget>[
            Container(
                width: 440.0,
                height: 150.0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        child: Container(
                          child: Text(
                            'Blood Alcohol Concentration',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 25,
                          child: Container(
                            child: Text(
                              _getBac(weight, age),
                              style: TextStyle(
                                  fontSize: 45.0, fontWeight: FontWeight.w300),
                            ),
                          )),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                              bottom: 40,
                              child: Container(
                                height: 140,
                              ))
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                width: 800.0,
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.1, 0.9],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Colors.lightBlue[200],
                        Colors.blue[700],
                      ],
                    ),
                    color: Colors.blue[500],
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(50.0),
                      topStart: Radius.circular(50.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(10.0, 10.0),
                        blurRadius: 30.0,
                      )
                    ]),
                child: ListView(
                  padding: const EdgeInsets.all(15.0),
                  children: <Widget>[
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text('Reduced Sensitivity\n Well Being'),
                      trailing: Text('0.05'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text('Altered Emotions and Behavior\n Relaxation feelings\n  Mild Sedetation'),
                      trailing: Text('0.08'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text('Muscle and speech impaired\n Reduced sensitivity\n'),
                      trailing: Text('0.12'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text('Mental Functions Affected\n Difficulty Standing, Walking\n  Euphoria'),
                      trailing: Text('0.15'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text('Lethal Dosage\n alcohol poisoning\n'),
                      trailing: Text('0.35'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class BackSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
