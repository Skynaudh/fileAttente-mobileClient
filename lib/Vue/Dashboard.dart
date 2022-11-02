import 'dart:ui';

// import 'package:fileattente/Provider/typeInstitutions.dart';
import 'package:fileattente/Ressource/auth.dart';
import 'package:fileattente/Vue/DialogBox.dart';
import 'package:fileattente/Models/institution_model.dart';
import 'package:fileattente/Provider/Institutions.dart';
import 'package:fileattente/Vue/AgenceList.dart';
import 'package:fileattente/Vue/AgenceMap.dart';
// import 'package:fileattente/Vue/InstitutList.dart';
// import 'package:fileattente/Models/typeInstitution.dart';
import 'package:fileattente/Vue/Profile.dart';
import 'package:fileattente/Vue/Register.dart';
import 'package:fileattente/Vue/ReservationList.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Institution> institution;

  bool _isInit = true;

  bool _isLoad = false;

  Map args;

  // List<InstitutionType> inst;

  String login = '';

  String password = '';

  final _keyForm = GlobalKey<FormState>();

  // bool _isInit = true;
  // bool _isLoad = false;
  bool isAuth;

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoad = true;
      });
      Provider.of<Institutions>(context)
          .getAllInstitution("Opérateurs")
          .then((value) {
        setState(() {
          _isLoad = false;
        });
      });
      
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    institution = Provider.of<Institutions>(context).items;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade200,
        elevation: 0,
        title: Text(
          "Smart File",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
              onTap: () async {
                bool isAuth = await Auth.isAuth();
                print(isAuth);
                if (isAuth == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReservationList()),
                  );
                } else {
                  messageNon(context).show();
                }
              },
              child: Icon(
                Icons.timelapse,
                size: 30,
                color: Color.fromARGB(255, 224, 252, 121),
              )),
          SizedBox(
            width: 10,
          ),
          // InkWell(
          //   //onTap: () => alert(context).show(),
          //   onTap: () async {
          //     bool isAuth = await Auth.isAuth();
          //     print(isAuth);
          //     if (isAuth == true) {
          //       message(context).show();
          //     } else {
          //       alert(context).show();
          //     }
          //   },
          //   child: Icon(
          //     Icons.connected_tv,
          //     size: 30,
          //     color: Colors.white,
          //   ),
          // ),
          // SizedBox(
          //   width: 10,
          // ),
          
          GestureDetector(
            onTap: () async {
              bool isAuth = await Auth.isAuth();
              print(isAuth);
              if (isAuth == true) {
                print('disconnect');
                confirmerDeconnexion(context).show();
              } else {
                messageNon(context).show();
              }
            },
            child: Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
          ),
        SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: double.maxFinite,
              // padding: const EdgeInsets.only(left: 08, right: 08, top: 0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 185,
                    width: size.width,
                    color: Colors.indigo,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Bienvenue sur Smart File",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                        Icon(
                          Icons.timelapse,
                          color: Colors.white,
                          size: 60,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: true,
                                repeatForever: true,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                      "Reservez  vos tickets via l'application",
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontStyle: FontStyle.italic)),
                                ])),
                      ],
                    ),
                  ),
                  SizedBox(height: 05),
                  Text(
                    "Nos institutions",
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0),
                  ),
                ],
              ),
            ),
            _isLoad
                ? Center(child: CircularProgressIndicator())
                : institution.length > 0
                    ? _InstitutionType()
                    
                    : Center(child: Text('Aucune Institution')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      bool isAuth = await Auth.isAuth();
                      print(isAuth);
                      if (isAuth == true) {
                        message(context).show();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal)),
                    child: Text(
                      "creer votre compte",
                    )),
                ElevatedButton(
                    onPressed: () async {
                      bool isAuth = await Auth.isAuth();
                      print(isAuth);
                      if (isAuth == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      } else {
                        messageNon(context).show();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.indigoAccent)),
                    child: Text(
                      "consulter mon profil",
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Alert alert(BuildContext context) {
    return Alert(
        context: context,
        title: "CONNEXION",
        content: Form(
          key: _keyForm,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Identifiant',
                ),
                validator: (val) =>
                    val.length < 3 ? 'Mot de passe incorrect' : null,
                onChanged: (val) => login = val,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                validator: (val) =>
                    val.length < 3 ? 'Mot de passe incorrect' : null,
                onChanged: (val) => password = val,
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (_keyForm.currentState.validate()) {
                Auth.login(login, password, context);
              }
            },
            child: Text(
              "Se connecter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]);
  }

  Widget _InstitutionType() {
    //inst = Provider.of<TypeInstitutions>(context).items;
    //print(_simData.toString());
    List<Widget> list = <Widget>[];
    for (var i = 0; i < institution.length; i++) {
      var current = institution[i];
      list.add(Padding(
        padding: const EdgeInsets.all(5.0),
       child: Card(
              color: Colors.indigo[50],
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image(
                      image: AssetImage("images/" +
                          current
                              .name
                              .toLowerCase() +
                          ".png"),
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  title: Text(
                    current.name,
                    style: TextStyle(
                        fontSize: 15.0, color: Colors.black),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber),
                    child: Text("Agences"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          Design.routeName,
                          arguments: {
                            'id': current.id,
                            'institution':
                                current.name
                          });
    })
    ))
    )
    )
    );
  }
   return new Column(children: list);
   }
}
