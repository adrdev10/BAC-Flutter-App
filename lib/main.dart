import 'dart:async';
import 'package:baccalculator/beer_repository.dart';

import 'beer.dart';
import 'package:baccalculator/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-1975185434500098~6499891872');
  runApp(MaterialApp(
    theme: ThemeData(
      // primaryColor: Colors.blac,
      secondaryHeaderColor: Colors.black,
    ),
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
      // '/second': (context) => BackResultsScreen(),
      '/settings': (context) => BackSettingsScreen(),
      '/beerlist': (context) => BeerListScreen(),
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

class BeerListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BeerListScreenState();
  }
}

class _BeerListScreenState extends State<BeerListScreen> {
  List<Beer> _beers = <Beer>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForBeers();
  }


  void listenForBeers() async {
    final Stream<Beer> stream = await getBeers();
    stream.listen((Beer beer) => {setState(() => _beers.add(beer))});
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
      body: ListView.builder(
        itemCount: _beers.length,
        itemBuilder: (context, index) => BeerTite(_beers[index]),
      ),
    );
  }
}

class BeerTite extends StatelessWidget {
  final Beer _beer;
  BeerTite(this._beer);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(_beer.name),
          subtitle: Text(_beer.tagLine),
          leading: Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Image.network(
                _beer.imageUrl,
                height: 50.0,
                fit: BoxFit.fill,
              )),
        ),
        Divider()
      ],
    );
  }
}

class BacHomeScreen extends StatefulWidget {
  @override
  _BackFormState createState() => _BackFormState();
}

class _BackFormState extends State<BacHomeScreen>
    with SingleTickerProviderStateMixin {
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _weightcontroller = TextEditingController();

  AnimationController _controller;
  double _height = 200;
  Matrix4 _matrix = Matrix4.translationValues(0, 0, 0);

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    _height = 200;
    _matrix = Matrix4.translationValues(0, 0, 0);
  }

  @override
  void didUpdateWidget(BacHomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _agecontroller.dispose();
    _weightcontroller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );
    // TODO: implement build
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale.countryCode);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: const Text(
            'BAC Calculator',
            style: TextStyle(fontSize: 17.0),
            textAlign: TextAlign.center,
          ),
          leading: Icon(Icons.sort),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_right),
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
                setState(() {
                  _height = 200;
                  _matrix = Matrix4.translationValues(0, 0, 0);
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                height: 900.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.1, 0.9],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Colors.blue[500],
                      Colors.blue[200],
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    AnimatedContainer(
                      height: _height,
                      duration: Duration(
                        milliseconds: 900,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Image.asset('assets/images/beer.png'),
                      ),
                    ),
                    AnimatedContainer(
                      transform: _matrix,
                      duration: Duration(
                        milliseconds: 1000,
                      ),
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 320,
                          margin: EdgeInsets.only(
                              top: 75.0, left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.1, 0.9],
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Colors.white,
                                  Colors.white,
                                ],
                              ),
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(25.0),
                                topStart: Radius.circular(25.0),
                                bottomEnd: Radius.circular(25.0),
                                bottomStart: Radius.circular(25.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 30.0,
                                )
                              ]),
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextField(
                                  maxLines: 1,
                                  onTap: () {
                                    setState(() {
                                      _height = 0;
                                      _matrix = Matrix4.translationValues(0, -50, 0);
                                    });
                                  },
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                  // autovalidate: true,
                                  // validator: (str) {
                                  //   return str == null
                                  //       ? AppLocalization.of(context)
                                  //           .get('warning')
                                  //       : null;
                                  // },
                                  controller: _namecontroller,
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalization.of(context).get('name'),
                                    icon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextFormField(
                                  autovalidate: true,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                  validator: (str) {
                                    return str == null
                                        ? AppLocalization.of(context)
                                            .get('warning')
                                        : null;
                                  },
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  controller: _weightcontroller,
                                  decoration: InputDecoration(
                                    labelText: AppLocalization.of(context)
                                        .get('weight'),
                                    icon: Icon(Icons.account_balance_wallet),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: TextFormField(
                                  autovalidate: true,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                  validator: (str) {
                                    return str == null
                                        ? AppLocalization.of(context)
                                            .get('warning')
                                        : null;
                                  },
                                  controller: _agecontroller,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    labelText: AppLocalization.of(context)
                                        .get('drinks'),
                                    icon: Icon(Icons.local_drink),
                                  ),
                                ),
                              ),
                              // bigColorfulBox(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
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

  _launchURLUber() async {
    const clientId = "V5wNTK9eCIsd5rEOyzopQLdK2dc3hkEq";
    var url = "https://m.uber.com/ul/?client_id=${clientId}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // _launchURLLift() async {
  //   const url = 'https://www.lyft.com/rider';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );

    Future.delayed(Duration.zero, () => _showDialog(context));
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 170.0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    overflow: Overflow.clip,
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
                                padding: const EdgeInsets.all(2.0),
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
                                padding: const EdgeInsets.all(2.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.all(2.0),
                                  margin: const EdgeInsets.only(top: 5.0),
                                  child: Container(
                                    child: Text(
                                      _getBac(weight, age),
                                      style: TextStyle(
                                          fontSize: 45.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(2.0),
                                  margin: const EdgeInsets.only(top: 5.0),
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
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 45.0,
                                  width: 150.0,
                                  margin: const EdgeInsets.only(top: 35.0),
                                  alignment: Alignment.center,
                                  child: FlatButton(
                                    onPressed: _launchURLUber,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Image.asset(
                                              'assets/images/uber.png'),
                                          tooltip: 'Uber',
                                          // color: Colors.white,
                                          onPressed: _launchURLUber,
                                        ),
                                        Text('Get Uber')
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                )
                                // Container(
                                //   margin:
                                //       const EdgeInsets.only(top: 35.0, left: 8.0),
                                //   child: Align(
                                //     alignment: Alignment(0.0, 1.5),
                                //     child: FloatingActionButton(
                                //       heroTag: "btn1",
                                //       backgroundColor:
                                //           Color.fromRGBO(145, 58, 127, 100),
                                //       tooltip: 'Lift',
                                //       child: Icon(Icons.directions_car),
                                //       onPressed: _launchURLLift,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                width: double.infinity,
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
                  padding: const EdgeInsets.all(10.0),
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
            ),
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
  keywords: <String>[
    'health',
    'games',
    'sport',
    'drinks',
    'fun',
    'drive',
    'night',
    'nobeer',
    'calculator',
    'bac'
  ],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender
      .unknown, // or MobileAdGender.female, MobileAdGender.unknown
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

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-1975185434500098/1602788415',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);
