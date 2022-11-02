import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 38.0),
                      child: Text(
                        "Mon profil",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3.0,
                              offset: Offset(0, 4.0),
                              color: Colors.white)
                        ],
                        image: DecorationImage(
                            image: AssetImage("images/profile.png"),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Identite",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 18.0, bottom: 10.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        ListTile(
                          // leading: Icon(Icons.location_on),
                          title: Row(
                            children: [
                              Text(
                                "Nom: ",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.indigo),
                              ),
                              Text(
                                " NADOR",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.only(left: 10.0),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                          indent: 0.0,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 10.0),
                          title: Row(
                            children: [
                              Text(
                                "Prenom(s): ",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.indigo),
                              ),
                              Expanded(
                                child: Text(
                                  "Ekuevi Mike Edem",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                          indent: 0.0,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 10.0),
                          title: Row(
                            children: [
                              Text(
                                "Telephone: ",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.indigo),
                              ),
                              Text(
                                "+22890301399",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                "Modifications",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.teal))
                      , child: Text("Mes informations",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      onPressed: () {},style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.teal)),child: Text("Mon mot de passe",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Plus loin",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){},
                  child: Card(
                    color: Colors.red,
                    child: ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      title: Text("Supprimer mon compte",style: TextStyle(fontSize: 20.0,color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
