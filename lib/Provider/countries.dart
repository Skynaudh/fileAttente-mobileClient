import 'dart:convert';

import 'package:fileattente/Models/country.dart';
import 'package:fileattente/Ressource/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Countries with ChangeNotifier {
  List<Country> _items = [];
  
  List<Country> get items {
    return [..._items];
  }

  Future<void> getAllCountries() async{
    const url = Api.urlAllContries;
    try{
      final response = await http.get(url);
      if(response.statusCode == 201){
        final data = json.decode(response.body) as Map<String, dynamic>;
        List<Country> tmp = [];
        final listdata = data['data'] as List;
        listdata.forEach((element) { 
          tmp.add(Country(id: element['id'],iso: element['iso'], iso3: element['iso'], name: element['name'],
          nicename: element['nicename'], phonecode: element['phonecode'], numcode: element['numcode']));
        });
        _items = tmp;
      }
    }catch(error){throw error;}
  }
}