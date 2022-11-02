
import 'dart:async';

import 'package:fileattente/Models/agence_model.dart';
import 'package:fileattente/Provider/agences.dart';
import 'package:fileattente/Vue/ServicesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class Design extends StatefulWidget {
  static const routeName = '/agence';
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {

  List<Agence> agences;

  bool _isInit = true;
  bool _isLoad = false;
  Map args;
  List<double> lat = [6.17, 6.20, 6.19, 6.18];
  List<double> log = [1.17, 1.20, 1.19, 1.18];



  @override
  didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoad = true;
      });
      args = ModalRoute.of(context).settings.arguments as Map;
      Provider.of<Agences>(context).getListMap(args['institution']).then((value){
        setState(() {
          _isLoad= false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    agences = Provider.of<Agences>(context).maps;
    args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          title: Text(args['institution']),
          centerTitle: true,
        ),
        body: agences.length !=0 ? new FlutterMap(
          options: new MapOptions(
              center: new LatLng(6.1760116666667, 1.1737366666667),
              minZoom: 10.0),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(markers: [
              for(var i = 0; i < agences.length; i++)

              new Marker(
                  width: 35.0,
                  height: 35.0,
                  point: new LatLng(agences[i].latitude, agences[i].longitude),
                  builder: (context) => new Container(
                        child:  GestureDetector(
                          child: Image(
                            image: AssetImage("images/"+args['institution'].toLowerCase() +".png"),
                             semanticLabel: agences[i].name,
                              fit: BoxFit.cover,
                              height: 38.0,
                              width: 38.0,
                             ),
                        
                          onTap: () {
                              showModalBottomSheet(context: context,
                               builder: (builder){
                                 return Container(
                                  height: MediaQuery.of(context).size.height/2.5,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.indigo,
                                        height: MediaQuery.of(context).size.height/10,
                                        child: Center(child: Text(agences[i].name,style: TextStyle(color: Colors.white,fontSize: 30),)),
                                      ),
                                      SizedBox(height: 15,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          SizedBox(width: 10,),
                                          Icon(Icons.phone,size: 20,color: Colors.purple,),
                                          SizedBox(width: 10,),
                                          Text("Telephone:",style: TextStyle(color: Colors.black,fontSize: 18)),
                                          SizedBox(width: 10,),
                                          Text(agences[i].phone,style: TextStyle(color: Colors.black,fontSize: 18))
                                        ],),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          SizedBox(width: 10,),
                                          Icon(Icons.location_on,size: 20,color: Colors.purple,),
                                          SizedBox(width: 10,),
                                          Text("Adresse:",style: TextStyle(color: Colors.black,fontSize: 18)),
                                          SizedBox(width: 10,),
                                          Expanded(child: Text(agences[i].address,style: TextStyle(color: Colors.black,fontSize:16)))
                                          
                                        ],),
                                      ),
                                     
                                 
                                      ElevatedButton(
                onPressed: () {
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => ServicesList()),
                   Navigator.of(context).pushReplacementNamed(ServicesList.routeName, arguments: 
                      {'institution' : args['institution'], 'agence' : agences[i].name}); 
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo[200])),
                child: Text(
                  "Voir les services",
                )),
                                    ],
                                  ),
                                   );
                               }
                               );
                              print("Marker tapped");
                            }
                            ),
                      
                      )),
                      
            ]),
          ],
        ): Center(child: Text('Aucune agence pour cette institution')));
  }
}
