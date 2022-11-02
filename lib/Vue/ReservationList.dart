import 'package:fileattente/Models/reservation_model.dart';
import 'package:fileattente/Provider/reservations.dart';
import 'package:fileattente/Ressource/auth.dart';
import 'package:fileattente/Vue/Dashboard.dart';
import 'package:fileattente/Vue/DialogBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/reservation_model.dart';

class ReservationList extends StatefulWidget {
  static const routeName = '/mesreservations';
  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  List<Reservation> reservation;
  // List<Reservation> reservation = [
  //   Reservation(id: 1, numero: 1, service:'Creation compte', attente:'2:00', file: 2, agence:'Orabank', date:'2021-10-11'),
  //   Reservation(id: 2, numero: 3, service:'Creation compte', attente:'4:00', file: 2, agence:'Orabank', date:'2021-11-11'),
  //   Reservation(id: 3, numero: 2, service:'Creation compte', attente:'3:00', file: 2, agence:'Orabank', date:'2021-01-11'),
  //   Reservation(id: 4, numero: 9, service:'Creation compte', attente:'1:00', file: 2, agence:'Orabank', date:'2021-10-11'),
  // ];
  bool _isInit = true;
  bool _isLoad = false;
  Map args;


  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoad = true;
      });
      //BuildContext context;
      // args = ModalRoute.of(context).settings.arguments as Map;
      Provider.of<Reservations>(context)
          .getMesReservations(context)
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
    args = ModalRoute.of(context).settings.arguments as Map;
    reservation = Provider.of<Reservations>(context).items;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Mes reservations"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoad
            ? Center(child: CircularProgressIndicator())
            : reservation.length != 0
                ? ListView.builder(
                    itemCount: reservation.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          String nom = await Auth.getName();
                          confirmerPrsce(context, reservation[index].code)
                              .show();
                        },
                        child:
                        reservation[index].expire == 'non'
                                      ? Container(
                          height: 160,
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color.fromARGB(255, 219, 236, 209)),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/reservation.png"),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          reservation[index].agence,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                       Text("Code secret: " +
                                          reservation[index].code, style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 7, 165, 7)),),
                                          
                                      SizedBox(
                                        height: 5,
                                      ),
                                     
                                      Text("Date: " + reservation[index].date),
                                     SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: Text("Service: " +
                                            reservation[index].service),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Attente: " +
                                          reservation[index].file.toString() +
                                          ' personne(s)'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                       Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 28.0),
                                              child: Container(
                                                height: 20,
                                                width: 70,
                                                color: Colors.green,
                                                child: Center(
                                                    child: Text(
                                                  " Valide",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: Text("N°",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold),),
                                            ),
                                          Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: Text(
                                          reservation[index].numero.toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                        :  
                        Container(
                          height: 130,
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color.fromARGB(255, 224, 155, 155)),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/reservation.png"),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          reservation[index].agence,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      
                                      Text("Date: " + reservation[index].date),
                                     SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: Text("Service: " +
                                            reservation[index].service),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      
                                       Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 28.0),
                                              child: Container(
                                                height: 20,
                                                width: 70,
                                                color: Colors.red,
                                                child: Center(
                                                    child: Text(
                                                  " Expiré",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                            ),
                                          
                          ],
                            ),
                          ),
                        ])
                        )
                        )
                      );
                    })
                : Center(child: Text('Aucune reservation')),
      ),
    );
  }
}
