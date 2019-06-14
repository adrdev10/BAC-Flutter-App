import 'dart:async';
import 'package:baccalculator/beer_repository.dart';
import 'package:flutter/painting.dart';

import 'beer.dart';
import 'package:baccalculator/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-1975185434500098~6499891872');
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
      // '/beerlist': (context) => BeerListScreen(),
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

// class BeerList extends StatelessWidget {

//   BeerList({@required this.name, @required this.age, @required this.weight});
//   final String name;
//   final double weight;
//   final int age;

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return BeerListScreen();
//   }
// }

// class BeerListScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _BeerListScreenState();
//   }
// }

// class _BeerListScreenState extends State<BeerListScreen> {
//   List<Beer> _beers = <Beer>[];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     listenForBeers();
//   }

//   void listenForBeers() async {
//     final Stream<Beer> stream = await getBeers();
//     stream.listen((Beer beer) => {setState(() => _beers.add(beer))});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'BAC Calculator',
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Navigator.pushNamed(context, 'settings');
//             },
//           )
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _beers.length,
//         itemBuilder: (context, index) => BeerTite(_beers[index]),
//       ),
//     );
//   }
// }

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
          centerTitle: true,
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
                                      _matrix =
                                          Matrix4.translationValues(0, -50, 0);
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

class DrunkRate {
  String description1;
  String description2;
  String description3;
  String rate;

  DrunkRate({this.description1, this.description2, this.description3, this.rate});
}

class DrunkRateCard extends StatelessWidget {
  final DrunkRate _drunkRate;
  DrunkRateCard(this._drunkRate);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white70,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            colors: [
              Colors.blue[200],
              Colors.blue[500],
            ]
          )
        ),
        width: 175.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('${_drunkRate.description1}'),
            Text('${_drunkRate.description2}'),
            Text('${_drunkRate.description3}'),
            Text('${_drunkRate.rate}')
          ],
        ),
      ),
    );
  }
}

class BackResultsScreen extends StatelessWidget {
  BackResultsScreen(
      {@required this.name, @required this.age, @required this.weight});
  final String name;
  final double weight;
  final int age;

  List<DrunkRate> drunkList = <DrunkRate>[
    new DrunkRate(
      description1: 'Symptons',
      description2: '- Feeling of well-being, inhibitations',
      description3: '- Absence of obserable effects',
      rate: '0.05 BAC',
    ),
    new DrunkRate(
      description1: 'Symptons',
      description2: '- Altered Emotions and behavior',
      description3: '- Relaxation feelings and mild Sedetation',
      rate: '0.08 BAC',
    ),
    new DrunkRate(
      description1: 'Symptons',
      description2: '- Muscle control impaired',
      description3: '- Speech control impaired and uncoordinated behavior',
      rate: '0.012 BAC',
    ),
    new DrunkRate(
      description1: 'Symptons',
      description2: '- Major impairment of physical function',
      description3: '- Euphoria and difficulty standing',
      rate: '0.015 BAC',
    ),
    new DrunkRate(
      description1: 'Symptons',
      description2: '- Lethal dosage and severe respiratory depression',
      description3: '-Alcohol poisoning and severe circulatory depression',
      rate: '0.35 BAC',
    ),
  ];

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
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );

    var bac = _getBac(weight, age);
    Future.delayed(Duration.zero, () => _showDialog(context));
    return Scaffold(
      
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(name),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(2.0),
                            margin:
                                const EdgeInsets.only(top: 15.0, bottom: 3.0),
                            child: Container(
                              child: Text(
                                'Timer',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey),
                              ),
                            )),
                        Container(
                            padding: const EdgeInsets.all(2.0),
                            margin:
                                const EdgeInsets.only(top: 5.0, bottom: 30.0),
                            child: Container(
                              child: Text(
                                "${(double.parse(bac) / 0.015).toStringAsFixed(2)} hrs",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                        Column(children: <Widget>[
                          new CircularPercentIndicator(
                            backgroundColor: Colors.blue[500],
                            progressColor: Colors.white,
                            radius: 220.0,
                            lineWidth: 15.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            animationDuration: 10200,
                            percent: 0.4,
                            center: new CircularPercentIndicator(
                              backgroundColor: Colors.white,
                              progressColor: Colors.blue[300],
                              animationDuration: 10800,
                              radius: 200.0,
                              animation: true,
                              lineWidth: 15.0,
                              circularStrokeCap: CircularStrokeCap.round,
                              percent: 0.8,
                              center: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.center,
                                        child: Container(
                                          child: Text(
                                            _getBac(weight, age),
                                            style: TextStyle(
                                                fontSize: 35.0,
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Container(
                                        child: Text(
                                          AppLocalization.of(context)
                                              .get('title'),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 45.0,
                            width: 150.0,
                            margin: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                            alignment: Alignment.center,
                            child: FlatButton(
                              onPressed: _launchURLUber,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset('assets/images/uber.png'),
                                    tooltip: 'Uber',
                                    // color: Colors.white,
                                    onPressed: _launchURLUber,
                                  ),
                                  Text('Get Uber')
                                ],
                              ),
                            ),
                          ),
                          Container(
                              height: 200.0,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: drunkList.length,
                                  itemBuilder: (BuildContext context, int i) =>
                                      DrunkRateCard(drunkList[i])))
                        ]),
                      ],
                    ),
                  )),
            ],
          ),
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
    'bac',
    'beer'
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
