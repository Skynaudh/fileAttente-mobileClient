import 'dart:convert';

import 'package:fileattente/Models/agence_model.dart';
import 'package:fileattente/Ressource/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Agences with ChangeNotifier {
  List<Agence> _items = [];
  List<Agence> _maps = [];

  List<Agence> get items {
    return [..._items];
  }

  List<Agence> get maps {
    return [..._maps];
  }

  Future<void> getAllAgences(String institution) async {
    //print('marche');
    const url = Api.urlAllAgence;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    try {
      final response = await http.post(url,
          body: json.encode({'institution': institution}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      //print(institution);
      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        List<Agence> tmp = [];
        final listdata = data['data'] as List;
        // print(listdata);
        listdata.forEach((element) {
          //print(element['institution_id']);
          //tmp.add(Agence(id: element['id'], name: element['name'], phone: element['phone'], longitude: double.tryParse(element['longitude']).toDouble(), latitude: double.tryParse(element['latitude']).toDouble()));
          tmp.add(Agence(
              id: element['id'],
              name: element['name'],
              address: element['address'],
              phone: element['phone'],
              longitude: element['longitude'].toDouble(),
              latitude: element['latitude'].toDouble()));
          // print('id'+element['id'].runtimeType.toString());
          // print('name'+element['name'].runtimeType.toString());
          // print('phone'+element['phone'].runtimeType.toString());
          // print('long'+element['longitude'].runtimeType.toString());
          // print('large'+element['latitude'].runtimeType.toString());
        });
        _items = tmp;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> getListMap(String institution) async {
    const url = Api.urlAgenceGab;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    try {
      final response = await http.post(url,
          body: json.encode({'institution': institution}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (response.statusCode == 201) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        List<Agence> tmp = [];
        final listdata = data['data'] as Map<String, dynamic>;
        final listgab = listdata['gab'] as List;
        final listagence = listdata['agence'] as List;
        
        listagence.forEach((element) {
          tmp.add(Agence(
              id: element['id'],
              name: element['name'],
              address: element['address'],
              phone: element['phone'],
              longitude: element['longitude'],
              latitude: element['latitude']));
              // longitude: double.parse(element['longitude']),
              // latitude: double.parse(element['latitude'])));
        });
        listgab.forEach((element) {
          tmp.add(Agence(
              id: element['id'],
              name: element['name'],
              address: element['address'],
              phone: 'null',
              longitude: element['longitude'],
              latitude: element['latitude']));
              // longitude: double.parse(element['longitude']),
              // latitude: double.parse(element['latitude'])));
        });
        _maps = tmp;
        //print(_maps);
      }
    } catch (error) {
      throw error;
    }
  }
}
