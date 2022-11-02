import 'dart:convert';

import 'package:fileattente/Models/reservation_model.dart';
import 'package:fileattente/Ressource/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Reservations with ChangeNotifier {
  List<Reservation> _items = [];

  List<Reservation> get items {
    return [..._items];
  }

  Future<void> getMesReservations(BuildContext context) async {
    const url = Api.urlMesReservation;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    String client = sharedPreferences.getString("name");
    var jsonData = null;
    if (token != null) {
      try {
        final response = await http
            .post(url, body: json.encode({'client': client}), headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
        if (response.statusCode == 201) {
          final data = json.decode(response.body) as Map<String, dynamic>;
          // print(data);
          List<Reservation> tmp = [];
          final listdata = data['data'];
          listdata.forEach((element) {
            tmp.add(Reservation(
                //id: element['id'],
                numero: element['numero'],
                service: element['service'],
                file: element['file'],
                attente: element['attente'],
                agence: element['agence'],
                expire: element['expire'].toString(),
                code: element['code'].toString(),
                date: element['date'].toString().split(' ')[0]));
          });
          _items = tmp;
        }
      } catch (error) {
        throw error;
      }
    } else {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()));
    }
  }
}
