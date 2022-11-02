import 'package:fileattente/Ressource/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  String name='';
  String adress='';
  String email='';
  String number='';
  String username='';
  String password='';
  String confPass='';
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          height:MediaQuery.of(context).size.height * 1.5,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightBlue, Colors.indigo],
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              color: Colors.white,
              onPressed: (){
                Navigator.pop(context);
              },
            ),

          ],),
                      Icon(
                        Icons.timelapse,
                        color: Colors.white,
                        size: 60,
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Creer votre compte",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      //form
                      SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez votre nom' : null,
                  onChanged: (val) => name = val,
                ),
                 SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Adresse',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez votre adresse' : null,
                  onChanged: (val) => adress = val,
                ),
                 SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez votre email' : null,
                  onChanged: (val) => email = val,
                ),
                 SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Numero de telephone',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez votre numéro de tel' : null,
                  onChanged: (val) => number = val,
                ),
                 SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Identifiant',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez un identifiant' : null,
                  onChanged: (val) => username = val,
                ),
                 SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),)
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 3 ? 'Mot de passe incorrect' : null,
                  onChanged: (val) => password = val,
                ),
                 SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmez le mot passe',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),)
                  ),
                  obscureText: true,
                  validator: (val) => val != password ? 'Mot de passe incoherent' : null,
                  onChanged: (val) => password = val,
                ),
                SizedBox(height: 10.0),
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(formkey.currentState.validate()){
                      Auth.register(username, password, name, adress, number, email, context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo,
                              shape: new RoundedRectangleBorder(
                 borderRadius: new BorderRadius.circular(30.0),
                 ),),
                            child: Text(
                              "creer le compte",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  Widget textInput(controller, hint, obscureText, method) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: method,
          decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10)),
        ),
      ),
    );
  }
}
