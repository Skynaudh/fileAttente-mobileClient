import 'dart:convert';

import 'package:fileattente/Models/institution_model.dart';
import 'package:fileattente/Ressource/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Institutions with ChangeNotifier {
  List<Institution> _items = [];

  List<Institution> get items {
    return [..._items];
  }

  Future<void> getAllInstitution(String typeInstitution) async {
    //print('marche');
    const url = Api.urlAllInstitution;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
  
    try {
      final response = await http.post(url,
          body:
              json.encode(<String, String>{'typeInstitution': typeInstitution}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      //print(response.statusCode);
      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        List<Institution> tmp = [];
        final listdata = data['data'] as List;
        listdata.forEach((element) {
          tmp.add(Institution(
              id: element['id'],
              name: element['name'],
              institutionTypesId: element['type_institution_id']));
        });
        _items = tmp;
        // print(_items);
      }
    } catch (error) {
      throw error;
    }
  }
}
