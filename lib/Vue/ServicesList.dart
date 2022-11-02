import 'package:fileattente/Models/service_model.dart';
import 'package:fileattente/Provider/services.dart';
import 'package:fileattente/Ressource/api.dart';
import 'package:fileattente/Ressource/auth.dart';
import 'package:fileattente/Vue/DialogBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';

class ServicesList extends StatelessWidget {
  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DataList(),
      ),
    );
  }
}

class DataList extends StatefulWidget {
  static const routeName = '/services';
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List<Service> service;
  bool _isInit = true;
  bool _isLoad = false;
  Map args;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoad = true;
      });
      args = ModalRoute.of(context).settings.arguments as Map;
      //print(args['type']);
      Provider.of<Services>(context)
          //.getAllServices(args['agence'])
          .getAllServices(args['agence'])
          .then((value) {
        setState(() {
          _isLoad = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments as Map;
    service = Provider.of<Services>(context).items;
    
    return Scaffold(
      backgroundColor: Colors.purple,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Services de " + args['agence'],
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(75.0))),
            child: _isLoad
                ? ShimmerList()
                : service.length != 0
                    ? ListView.builder(
                        itemCount: service.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: _ServiceItem(
                                service[index].service,
                                service[index].file,
                                service[index].dureeService,
                                context,
                                index),
                          );
                        })
                    : Center(child: Text('Aucun service cette agence.')),
          ),
        ],
      ),
    );

  }

  Widget _ServiceItem(String name, int personne, String duree,
      BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 8.0,
        child: ListTile(
          // leading:CircleAvatar(
          //   backgroundColor: Colors.red[200],
          //   radius: 20,
          //   child: Text("S",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
          // ) ,
          title: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personnes: $personne",
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              Text("Duree par service: $duree min",
                  style: TextStyle(fontSize: 15, color: Colors.black)),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red[200]),
            child: Text(
              "Reserver",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => showCustomDialog(context, service[index], index),
          ),
        ),
      ),
    );
  }

  showCustomDialog(BuildContext context, Service service, int index) =>
      showModal(
          configuration: FadeScaleTransitionConfiguration(
            transitionDuration: Duration(seconds: 1),
            reverseTransitionDuration: Duration(milliseconds: 600),
          ),
          context: context,
          builder: (context) => AlertDialog(
                title: Center(
                    child: Text(
                  "RESERVATION",
                  style: TextStyle(color: Colors.indigo),
                )),
                content: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  //width: double.infinity,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Text("Agence:",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(service.agence,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black))),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text("Service:",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(service.service,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black))),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text("Duree d'attente:",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(service.dureeAttente,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 133, 12)))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                bool isAuth = await Auth.isAuth();
                                if (isAuth == true) {
                                  Api.doReservation(
                                      context, service.agence, service.service);
                                } else {
                                  messageNon(context).show();
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.indigoAccent)),
                              child: Text(
                                "Confirmer",
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              child: Text(
                                "Annulé",
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 200;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
