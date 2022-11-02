import 'package:flutter/material.dart';
class Sizeconfig{
static MediaQueryData _mediaQueryData;
static double screenWidth;
static double screenHeight;
static double defaultSize;
static Orientation orientation;

void init(BuildContext context)
{
  _mediaQueryData=MediaQuery.of(context);
  screenWidth=_mediaQueryData.size.width;
  screenHeight=_mediaQueryData.size.height;
  orientation=_mediaQueryData.orientation;
}

}
//obtenir la proportion adequate de hauteur de l'ecran utilise 
double getProportionateScreenHeight(double inputHeight){
  double screenHeight=Sizeconfig.screenHeight;

  return (inputHeight /812.0) *screenHeight;
}
//obtenir la proportion adequate de largeur de l'ecran utilise 
double getProportionateScreenWidth(double inputWidth){
  double screenWidth=Sizeconfig.screenWidth;

  return (inputWidth /812.0) *screenWidth;
}