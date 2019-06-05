import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  controller: _weightcontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter your weight (pounds)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  controller: _agecontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter amount of drinks',
                  ),
                ),
              ),
              Container(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BackResultsScreen(
                                    age: int.parse(_agecontroller.text),
                                    name: _namecontroller.text,
                                    weight:
                                        double.parse(_weightcontroller.text),
                                  )));
                    },
                  ))
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

  double _getBac(double weight, int amountofDrinks) {
    return (600 * amountofDrinks) / (weight * (0.06 * amountofDrinks + 169));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final userArgument = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Container(
            height: 350.0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 30,
                    child: Container(
                      child: Text(
                        'Blood Alcohol Concentration:',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 150,
                      child: Container(
                    child: Text(
                      _getBac(weight, 4).toStringAsPrecision(3),
                      style: TextStyle(
                        fontSize: 80.0,
                      ),
                    ),
                  ))
                ],
              ),
            )));
  }
}

class BackSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
