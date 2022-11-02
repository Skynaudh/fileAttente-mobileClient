import 'package:fileattente/Provider/Institutions.dart';
import 'package:fileattente/Provider/agences.dart';
import 'package:fileattente/Provider/countries.dart';
import 'package:fileattente/Provider/reservations.dart';
import 'package:fileattente/Provider/services.dart';
import 'package:fileattente/Provider/typeInstitutions.dart';
import 'package:fileattente/Vue/AgenceList.dart';
import 'package:fileattente/Vue/AgenceMap.dart';
import 'package:fileattente/Vue/Dashboard.dart';
import 'package:fileattente/Vue/InstitutList.dart';
import 'package:fileattente/Vue/ReservationList.dart';
import 'package:fileattente/Vue/ServicesList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider.value(value: TypeInstitutions(),),
      ChangeNotifierProvider.value(value: Institutions(),),
      ChangeNotifierProvider.value(value: Countries(),),
      ChangeNotifierProvider.value(value: Agences()),
      ChangeNotifierProvider.value(value: Services()),
      ChangeNotifierProvider.value(value: Reservations()),
    ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Waiting',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Dashboard(),
        routes: {
          InstitutionList.routeName: (context) => InstitutionList(),
          Design.routeName: (context) => Design(),
          ServicesList.routeName: (context) => ServicesList(),
          ReservationList.routeName: (context) => ReservationList(),
          AgenceList.routeName: (context) => AgenceList()
        },
      ),
    );
  }
}

