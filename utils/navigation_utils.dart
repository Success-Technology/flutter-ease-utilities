

import 'package:flutter/material.dart';

/// Jumping into a particular next page
void jump(BuildContext context,Widget next)
{
   Navigator.push(context, MaterialPageRoute(builder: (context)=>next));
}


/// Backing into previous page
void back(BuildContext context)
{
  Navigator.pop(context);
}


/// Advanced Route 
class RouterServices 
{
     static GlobalKey<NavigatorState> naviKey = GlobalKey<NavigatorState>();

     static void pushName(String routeName)
     {
       naviKey.currentState!.pushNamed(routeName);
     }
}