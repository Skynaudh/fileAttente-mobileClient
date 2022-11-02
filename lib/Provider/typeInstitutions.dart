import 'dart:convert';

import 'package:fileattente/Ressource/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/typeInstitution.dart';

class TypeInstitutions with ChangeNotifier{

  List<InstitutionType> _items = [];
  
  List<InstitutionType> get items {
    return [..._items];
  }

  Future<List<InstitutionType>> getAllTypeInstitution() async{
    const url = Api.urlAllTypeInstitution;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    //print('typeA');
    try {
      final response = await http.get(url, headers: {
        'Content-type' : 'application/json',
        'Accept' : 'application/json'});
        //print(response);
      if(response.statusCode==201 ){
        //print('typeB');
        final data = json.decode(response.body) as Map<String, dynamic>;
        List<InstitutionType> tmp = [];
        final listdata = data['data'] as List;
        //print(listdata);
        listdata.forEach((element) { 
          tmp.add(InstitutionType(id: element['id'], description: element['description'], name: element['name']));
        });
        _items = tmp;
        return _items;
      }
      else {
        print('No Categories');
      }
    }catch(error) {throw error;}
  }
}