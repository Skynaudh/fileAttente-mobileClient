import 'dart:convert';

import 'package:fileattente/Ressource/api.dart';
import 'package:fileattente/Ressource/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Vue/DialogBox.dart';
import '../Vue/DialogBox.dart';

class Auth {
  String _name;
  String _token;
  //SharedPreferences sharedPrefs;

  initValue() async {
    await SharedPreferencesClass.restore("name").then((value) {
      if (value is String) {
        _name = value;
      }
    });
    await SharedPreferencesClass.restore("token").then
    ((value) {
      if (value is String) {
        _token = value;
      }
    });
  }

  static Future<bool> isAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token != null;
  }

  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
      return token;
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()));
  }
  
  //Infos
  static Future<String> getName()
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString("name");
      return name;
  }

  static Future<String> getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String email = sharedPreferences.getString("email");
    return email;
  }

  static Future<String> getNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String number = sharedPreferences.getString("number");
    return number;
  }

  static register(String username,
    String password, 
    String name, 
    String adress, 
    String number, 
    String email,
    BuildContext context,
  ) async {
    const url = Api.urlInscription;
    Map data = {'username': username, 'password': password, 'name': name, 'adress': adress, 'number': number, 'email': email};
    var jsonData = null;
    var response = await http.post(url, body: data);
    if(response.statusCode == 201) {
      jsonData = json.decode(response.body);
      await SharedPreferencesClass.save('token', jsonData['data']['token']);

      final listdata =  jsonData['data']['information'] as Map;
      await SharedPreferencesClass.save('name', listdata['name']);
      await SharedPreferencesClass.save('email', listdata['email']);
      await SharedPreferencesClass.save('number', listdata['number']);
      await SharedPreferencesClass.save('client', listdata);

      print('inscrit');
      Navigator.pop(context);
    }
    else {
      print(response.body);
    }
  }

  static login(
    String name,
    String password,
    BuildContext context,
  ) async {
    const url = Api.login;
    Map data = {'name': name, 'password': password};
    var jsonData = null;
    var response = await http.post(url, body: data);
    if(response.statusCode == 201) {
      jsonData = json.decode(response.body);
      await SharedPreferencesClass.save('token', jsonData['data']['token']);

      final listdata =  jsonData['data']['information'] as Map;
      await SharedPreferencesClass.save('name', listdata['name']);
      await SharedPreferencesClass.save('email', listdata['email']);
      await SharedPreferencesClass.save('number', listdata['number']);
      await SharedPreferencesClass.save('client', listdata);
      print('connecter');
      Navigator.pop(context);
    }
    else {
      errorMessage(context).show();
      //print(response.body);
    }
  }

  static logout(BuildContext context) async {
    const url = Api.urllogout;
    var jsonData = null;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String token =  sharedPrefs.getString('token');
    print(token);
    if(token != null)
    {
    var response = await http.post(url, headers: {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'});
    print('logout');
    if(response.statusCode == 201) {
      jsonData = json.decode(response.body);
    await SharedPreferencesClass.clear("token");
    await SharedPreferencesClass.clear("name");
    await SharedPreferencesClass.clear("email");
    await SharedPreferencesClass.clear("number");
    await SharedPreferencesClass.clear("client");
      
      print(jsonData['status']);
      print('deconnecter');
      print('token = ');
      deconnexionOk(context).show();
    }
    else {
      print(response.body);
    }
    }
    else{
      print('token non existant');
      print(token);
    }
  }
}