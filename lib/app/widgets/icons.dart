
import 'package:flutter/material.dart';
import 'package:todo_app/app/core/values/colors.dart';
import 'package:todo_app/app/core/values/icons.dart';

List<Icon> getIcons(){
 return const [
   Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple,),
   Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: blue,),
   Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: deepPink,),
   Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: lightblue,),
   Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: yellow,),
   Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: pink,),
 ];
}