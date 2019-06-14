

// Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               Container(
//                                 // top: 30,
//                                 // right: 10,
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Container(
//                                   child: Text(
//                                     AppLocalization.of(context).get('hours'),
//                                     style: TextStyle(
//                                         fontSize: 15.0,
//                                         fontWeight: FontWeight.w200),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                   padding: const EdgeInsets.all(2.0),
//                                   margin: const EdgeInsets.only(top: 5.0),
//                                   child: Container(
//                                     child: Text(
//                                       (double.parse(bac) / 0.015)
//                                           .toStringAsFixed(2),
//                                       style: TextStyle(
//                                           fontSize: 45.0,
//                                           fontWeight: FontWeight.w300),
//                                     ),
//                                   )),
//                             ],
//                           ),




// Container(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                   height: 45.0,
//                                   width: 150.0,
//                                   margin: const EdgeInsets.only(top: 35.0),
//                                   alignment: Alignment.center,
//                                   child: FlatButton(
//                                     onPressed: _launchURLUber,
//                                     child: Row(
//                                       children: <Widget>[
//                                         IconButton(
//                                           icon: Image.asset(
//                                               'assets/images/uber.png'),
//                                           tooltip: 'Uber',
//                                           // color: Colors.white,
//                                           onPressed: _launchURLUber,
//                                         ),
//                                         Text('Get Uber')
//                                       ],
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                     color: Colors.white,
//                                   ),
//                                 )
//                                 // Container(
//                                 //   margin:
//                                 //       const EdgeInsets.only(top: 35.0, left: 8.0),
//                                 //   child: Align(
//                                 //     alignment: Alignment(0.0, 1.5),
//                                 //     child: FloatingActionButton(
//                                 //       heroTag: "btn1",
//                                 //       backgroundColor:
//                                 //           Color.fromRGBO(145, 58, 127, 100),
//                                 //       tooltip: 'Lift',
//                                 //       child: Icon(Icons.directions_car),
//                                 //       onPressed: _launchURLLift,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           )


// Container(
//           alignment: Alignment.center,
//           height: double.infinity,
//           width: double.infinity,
//           child: Center(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                     height: 170.0,
//                     child: Center(
//                       child: Stack(
//                         alignment: Alignment.center,
//                         overflow: Overflow.clip,
//                         children: <Widget>[
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Container(
//                                     // top: 30,
//                                     // left: 10,
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Container(
//                                       child: Text(
//                                         AppLocalization.of(context)
//                                             .get('title'),
//                                         style: TextStyle(
//                                             fontSize: 15.0,
//                                             fontWeight: FontWeight.w200),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     // top: 30,
//                                     // right: 10,
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Container(
//                                       child: Text(
//                                         AppLocalization.of(context)
//                                             .get('hours'),
//                                         style: TextStyle(
//                                             fontSize: 15.0,
//                                             fontWeight: FontWeight.w200),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: <Widget>[
//                                   Container(
//                                       padding: const EdgeInsets.all(2.0),
//                                       margin: const EdgeInsets.only(top: 5.0),
//                                       child: Container(
//                                         child: Text(
//                                           _getBac(weight, age),
//                                           style: TextStyle(
//                                               fontSize: 45.0,
//                                               fontWeight: FontWeight.w300),
//                                         ),
//                                       )),
//                                   Container(
//                                       padding: const EdgeInsets.all(2.0),
//                                       margin: const EdgeInsets.only(top: 5.0),
//                                       child: Container(
//                                         child: Text(
//                                           (double.parse(bac) / 0.015)
//                                               .toStringAsFixed(2),
//                                           style: TextStyle(
//                                               fontSize: 45.0,
//                                               fontWeight: FontWeight.w300),
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       height: 45.0,
//                                       width: 150.0,
//                                       margin: const EdgeInsets.only(top: 35.0),
//                                       alignment: Alignment.center,
//                                       child: FlatButton(
//                                         onPressed: _launchURLUber,
//                                         child: Row(
//                                           children: <Widget>[
//                                             IconButton(
//                                               icon: Image.asset(
//                                                   'assets/images/uber.png'),
//                                               tooltip: 'Uber',
//                                               // color: Colors.white,
//                                               onPressed: _launchURLUber,
//                                             ),
//                                             Text('Get Uber')
//                                           ],
//                                         ),
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                     // Container(
//                                     //   margin:
//                                     //       const EdgeInsets.only(top: 35.0, left: 8.0),
//                                     //   child: Align(
//                                     //     alignment: Alignment(0.0, 1.5),
//                                     //     child: FloatingActionButton(
//                                     //       heroTag: "btn1",
//                                     //       backgroundColor:
//                                     //           Color.fromRGBO(145, 58, 127, 100),
//                                     //       tooltip: 'Lift',
//                                     //       child: Icon(Icons.directions_car),
//                                     //       onPressed: _launchURLLift,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     )),
//                 AnimatedContainer(
//                   duration: Duration(
//                     milliseconds: 2000,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )


// child: Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.only(top: 30.0),
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         // Where the linear gradient begins and ends
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomLeft,
//                         // Add one stop for each color. Stops should increase from 0 to 1
//                         stops: [0.1, 0.9],
//                         colors: [
//                           // Colors are easy thanks to Flutter's Colors class.
//                           Colors.lightBlue[200],
//                           Colors.blue[700],
//                         ],
//                       ),
//                       color: Colors.blue[500],
//                       borderRadius: BorderRadiusDirectional.only(
//                         topEnd: Radius.circular(50.0),
//                         topStart: Radius.circular(50.0),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           offset: Offset(10.0, 10.0),
//                           blurRadius: 30.0,
//                         )
//                       ]),
//                   child: ListView(
//                     padding: const EdgeInsets.all(10.0),
//                     children: <Widget>[
//                       ListTile(
//                         contentPadding: const EdgeInsets.all(12.0),
//                         leading: Icon(Icons.blur_circular),
//                         title: Text(AppLocalization.of(context).get('list1')),
//                         trailing: Text('0.05'),
//                       ),
//                       ListTile(
//                         contentPadding: const EdgeInsets.all(12.0),
//                         leading: Icon(Icons.blur_circular),
//                         title: Text(AppLocalization.of(context).get('list2')),
//                         trailing: Text('0.08'),
//                       ),
//                       ListTile(
//                         contentPadding: const EdgeInsets.all(12.0),
//                         leading: Icon(Icons.blur_circular),
//                         title: Text(AppLocalization.of(context).get('list3')),
//                         trailing: Text('0.12'),
//                       ),
//                       ListTile(
//                         contentPadding: const EdgeInsets.all(12.0),
//                         leading: Icon(Icons.blur_circular),
//                         title: Text(AppLocalization.of(context).get('list4')),
//                         trailing: Text('0.15'),
//                       ),
//                       ListTile(
//                         contentPadding: const EdgeInsets.all(12.0),
//                         leading: Icon(Icons.blur_circular),
//                         title: Text(AppLocalization.of(context).get('list5')),
//                         trailing: Text('0.35'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),