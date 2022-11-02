import 'dart:async';
import 'package:fileattente/Models/institution_model.dart';
import 'package:fileattente/Provider/Institutions.dart';
import 'package:fileattente/Vue/AgenceList.dart';
import 'package:fileattente/Vue/AgenceMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class InstitutionList extends StatelessWidget {
  static const routeName = '/institutions';
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

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List<Institution> institution;

  bool _isInit = true;

  bool _isLoad = false;

  Map args;

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoad = true;
      });
      args = ModalRoute.of(context).settings.arguments as Map;
      print('argu'+args['type']);
      Provider.of<Institutions>(context).getAllInstitution(args['type']).then((value){
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
    args = ModalRoute.of(context).settings.arguments as Map;
    institution = Provider.of<Institutions>(context).items;
    print(institution);
    return Scaffold(
      backgroundColor: Color(0XFF21BFBD),
      body: ListView(children: [
        Padding(padding: EdgeInsets.only(top: 15.0,left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: (){
              Navigator.pop(context);
            },
          ),

        ],),
        ),

        SizedBox(height: 25.0,),
        Padding(
          padding: EdgeInsets.only(left: 70.0),
          child: Text(args['type'],style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 30.0,fontWeight: FontWeight.w400),
          ),),
          SizedBox(height:35.0,),
          Container(
            padding: EdgeInsets.only(top: 40),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0))
            ),
            child: _isLoad ? ShimmerList() : 
              institution.length!= 0 ?
               ListView.builder(
                itemCount: institution.length,
                  itemBuilder: (context, index){
                    return Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 10.0),
                    child: Card(
                      color: Colors.indigo[50],
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                leading:CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Image(
                                        image:AssetImage("images/"+args['type'].toLowerCase()+".png"),
                                        fit: BoxFit.cover,
                                        height: 40.0,
                                        width: 40.0,
                                      ),
                                ) ,
                                title: Text(institution[index].name,style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black
                                      ),),
                                trailing:ElevatedButton( 
                                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                                  child:Text("Agences") ,
                                  onPressed: ()
                                  {
                                  Navigator.of(context).pushNamed(Design.routeName, arguments: 
                                        {'id' : institution[index].id, 'institution' : institution[index].name});
                                      //en attente de connexion
                                    // Navigator.of(context).pushNamed(AgenceList.routeName, arguments:
                                    //   {'id' : institution[index].id, 'institution' : institution[index].name});
                                  },),
                      ),
                            ),
                    ),
                  );
                    }
            ): Center(child: Text('Aucune institution pour cette categorie')),
          )
      ],),
    );
  }

  Widget _institutItem(String name,BuildContext context){
  Map args;
    args = ModalRoute.of(context).settings.arguments as Map;
    return Padding(
      padding: EdgeInsets.only(left: 0.0,right: 0.0,top: 20.0),
      child: ListTile(
        leading:CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Image(
                image:AssetImage("images/"+args['type'].toLowerCase()+".png"),
                fit: BoxFit.cover,
                height: 40.0,
                width: 40.0,
              ),
        ) ,
        title: Text(name,style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),),
        trailing:ElevatedButton( 
          style: ElevatedButton.styleFrom(primary: Colors.amber),
          child:Text("Agences") ,
          onPressed: ()
          {
          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Design()),
                      );
          },)
 ,
      ),
    );

  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
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
