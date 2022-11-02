import 'package:fileattente/Models/agence_model.dart';
import 'package:fileattente/Provider/agences.dart';
import 'package:fileattente/Ressource/color.dart';
import 'package:fileattente/Vue/ServicesList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgenceList extends StatefulWidget {
  static const routeName = '/agences';
  @override
  _AgenceListState createState() => _AgenceListState();
}

class _AgenceListState extends State<AgenceList> {

  List<Agence> agences;
  bool _isInit = true;
  bool _isLoad = false;
  Map args;

  @override
  didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoad = true;
      });
      args = ModalRoute.of(context).settings.arguments as Map;
      Provider.of<Agences>(context).getAllAgences(args['institution']).then((value){
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
    agences = Provider.of<Agences>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args['institution'],
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: 
            Icon(Icons.arrow_back, color: Colors.white)
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      //body: Text("Bien"),
      body: _isLoad ? Center(child: CircularProgressIndicator()) : 
      agences.length !=0 ? ListView.builder(
        itemCount: agences.length,
        itemBuilder: (context, index){
          return Column(
                  children: [
                    InkWell(
                      onTap: (){
                        //services
                        Navigator.of(context).pushNamed(ServicesList.routeName, arguments: 
                      {'institution' : args['institution'], 'agence' : agences[index].name}); 
                      },
                      child: Container(
                        child: ListTile(
                          title: Text(agences[index].name),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: pColor,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 20,
                    ),
                  ],
                );
          }): Center(
              child: Text('Aucune agence presente pour cette institution. Merci !!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize : 20),),
            ),
    );
  }
}