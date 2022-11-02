import 'package:fileattente/Ressource/auth.dart';
import 'package:fileattente/Vue/Dashboard.dart';
import 'package:fileattente/Vue/ReservationList.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert connect(BuildContext context) {
  String login = '';

  String password = '';

  final _keyForm = GlobalKey<FormState>();
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

Alert message(BuildContext context) {
  return Alert(
      context: context,
      title: "Message",
      content: Column(
        children: <Widget>[
          Text('Vous êtes deja connecté'),
          Text('Effectué vos opérations'),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]);
}

Alert messageNon(BuildContext context) {
  return Alert(
      context: context,
      title: "Message",
      content: Column(
        children: <Widget>[
          Text('Vous n\'êtes pas connecté'),
          Text('Voulez-vous vous connecter ?'),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {Navigator.pop(context);
            connect(context).show();
          },
          child: Text(
            "Oui",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Non",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]);
}

Alert reservationOk(BuildContext context) {
  return Alert(
      context: context,
      title: "Message",
      content: Column(
        children: <Widget>[
          Text('Reservation effectuée !', style: TextStyle(fontSize: 16, color: Colors.green),),
         
                       ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, ReservationList.routeName);
          },
          child: Text(
            "Consulter",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        DialogButton(
          onPressed: () => {
            Navigator.pop(context),Navigator.pop(context)},
          child: Text(
            "Retour",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
      ]);
}

Alert deconnexionOk(BuildContext context) {
  return Alert(
      context: context,
      title: "Message",
      content: Column(
        children: <Widget>[
          Text('Vous êtes deconnecté !!!'),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]);
}

Alert confirmerPrsce(BuildContext context, String code) {
  return Alert(
      context: context,
      title: "Information du  client",
      content: Column(
        children: <Widget>[
          Text('Votre code secret : ' + code),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]);
}

Alert confirmerDeconnexion(BuildContext context) {
  return Alert(
      context: context,
      title: "Message",
      content: Column(
        children: <Widget>[
          Text('Voulez-vous vous deconnecter ?'),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            Auth.logout(context);
          },
          child: Text(
            "Oui",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.red,
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Non",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]);
}

Alert errorMessage(BuildContext context) {
  return Alert(
      context: context,
      title: "Message",
      content: Column(
        children: <Widget>[
          Text('Identifiant ou mot de passe incorrect'),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Ressayez",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]);
}
