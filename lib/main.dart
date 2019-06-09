import 'dart:io';
import 'dart:math';

import 'package:baccalculator/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-1975185434500098~6499891872');
  runApp(MaterialApp(
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      const AppLocalizationDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''), // English
      const Locale('es', ''), // Spanish
      const Locale.fromSubtags(
          languageCode: 'zh'), // Chinese *See Advanced Locales below*
      // ... other locales the app supports
    ],
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

  @override
  Widget build(BuildContext context) {
    myBanner..load()..show(
      anchorType: AnchorType.bottom,
      anchorOffset: 30.0,
    );
    // TODO: implement build
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale.countryCode);
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
                        ? AppLocalization.of(context).get('warning')
                        : null;
                  },
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).get('name'),
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
                        ? AppLocalization.of(context).get('warning')
                        : null;
                  },
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: _weightcontroller,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).get('weight'),
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
                        ? AppLocalization.of(context).get('warning')
                        : null;
                  },
                  controller: _agecontroller,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).get('drinks'),
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

  void _showDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalization.of(context).get('message')),
                Text(AppLocalization.of(context).get('message2')),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var bac = _getBac(weight, age);

    Future.delayed(Duration.zero, () => _showDialog(context));
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
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                // top: 30,
                                // left: 10,
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  child: Text(
                                    AppLocalization.of(context).get('title'),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ),
                              Container(
                                // top: 30,
                                // right: 10,
                                child: Container(
                                  child: Text(
                                    AppLocalization.of(context).get('hours'),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                margin: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                child: Text(
                                  _getBac(weight, age),
                                  style: TextStyle(
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              )),
                              Container(
                                  padding: const EdgeInsets.all(5.0),
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                child: Text(
                                  (double.parse(bac) / 0.015)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              )),
                            ],
                          )
                        ],
                      ),
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
                      title: Text(AppLocalization.of(context).get('list1')),
                      trailing: Text('0.05'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text(AppLocalization.of(context).get('list2')),
                      trailing: Text('0.08'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text(AppLocalization.of(context).get('list3')),
                      trailing: Text('0.12'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text(AppLocalization.of(context).get('list4')),
                      trailing: Text('0.15'),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(Icons.blur_circular),
                      title: Text(AppLocalization.of(context).get('list5')),
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

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['health', 'games'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender:
      MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-1975185434500098/2490873415',
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
