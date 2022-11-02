import 'dart:convert';

import 'package:fileattente/Vue/DialogBox.dart';
import 'package:fileattente/Vue/ReservationList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Vue/DialogBox.dart';

class Api {
  // static const String url = 'http://vue.xaed4360.odns.fr/public/api';
  static const String url = 'http://192.168.137.1:8000/api';

  static const String urlAllTypeInstitution = "$url/listeInstitutionType";
  static const String urlAllInstitution = "$url/listeInstitutionByType";
  static const String urlAllAgence = "$url/listeAgenceByInstitution";
  static const String urlAgenceGab = "$url/ListMapInstitution";
  static const String urlAllContries = "$url/listeCountry";
  static const String urlService = "$url/listeServiceToAgence";
  static const String login = '$url/loginClient';
  static const String urlInscription = '$url/addClient';
  static const String urlReservation = '$url/addReservation';
  static const String urlMesReservation = '$url/listeReservationByClient';
  static const String urllogout = '$url/logout';

  //faire reservation
  static doReservation(
      BuildContext context, String agence, String service) async {
    const url = Api.urlReservation;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    String name = sharedPreferences.getString("name");
    var jsonData = null;
    if (token != null) {
      try {
        final response = await http.post(url,
            body: json
                .encode({'agence': agence, 'service': service, 'client': name}),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token'
            });
        if (response.statusCode == 201) {
          jsonData = json.decode(response.body);
        
          reservationOk(context).show();
        } else {
          // Navigator.of(context).pushNamed(Connexion.routeName, arguments:
          //                     {'route' : MesReservations.routeName});
          print(response.body);
        }
      } catch (error) {
        throw error;
      }
    } else {
      messageNon(context);
    }
  }

  //confirmer sa presence dans l'agence
}
