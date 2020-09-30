

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/pages/home.dart';

void main(){

runApp(new MaterialApp(
home: new home()
));
}

class home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return player();
  }

}