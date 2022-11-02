import 'dart:convert';

import 'package:fileattente/Models/service_model.dart';
import 'package:fileattente/Ressource/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Services with ChangeNotifier {
  List<Service> _items = [];

  List<Service> get items {
    return [..._items];
  }

  Future<void> getAllServices(String agence) async {
    const url = Api.urlService;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    try {
      final response =
          await http.post(url, body: json.encode({'agence': agence}), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        List<Service> tmp = [];
        final listdata = data['data'] as List;
        //print(listdata);
        listdata.forEach((element) {
          tmp.add(Service(
              id: element['id'],
              service: element['service'],
              statut: element['statut'],
              file: element['file'],
              dureeAttente: element['dureeAttente'],
              dureeService: element['dureeService'],
              agence: element['agence']));
        });
        _items = tmp;
        
      }
    } catch (error) {
      throw error;
    }
  }
}
