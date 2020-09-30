import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:music_player/pages/playlist.dart';

class player extends StatefulWidget{
  @override
 playerState createState() => playerState();
}
class playerState extends State<player>{
  final SnakeBarStyle snakeBarStyle = SnakeBarStyle.floating;
  final SnakeShape snakeShape = SnakeShape.circle;
  int _selectedItemPosition = 3 ;
  ShapeBorder barShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25))
  );
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<FileSystemEntity> _songsList;
  List<SongInfo> deviceSongs = [];
  @override
  void initState(){
    super.initState();
    getSOngs();
  }
  void getSOngs() async{
    Directory dir = Directory('/storage/emulated/0');
    String mp3Path = dir.toString();
    print(mp3Path);
    List<FileSystemEntity> _files;
    List<FileSystemEntity> _songs = [];
     deviceSongs = await audioQuery.getSongs();
    _files = dir.listSync(recursive: true, followLinks: false);
    for(FileSystemEntity entity in _files){
      String path = entity.path;
      if (path.endsWith('mp3'))
        _songs.add(entity);
    }

    print(deviceSongs);
    print(_songs.length);
    setState(() {
      _songsList=_songs;
    });
  }





  @override
  Widget build(BuildContext context) {

  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right:15.0),
          child: IconButton(icon: Icon(Icons.search,color: Colors.white,size: 25.0,), onPressed: getSOngs),
        )
      ],
    ),
    drawer: Drawer(),

    body: Stack(
      children: [
        Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(image: new AssetImage('images/background.jpg'),fit: BoxFit.cover)
              ),
              child: new Column(

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:35.0,left: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: SafeArea(child: new Text('Hello!',style: TextStyle(fontSize: 65,fontWeight: FontWeight.w700,color: Colors.white),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:110.0,right: 65),
                          child: Icon(
                            Icons.play_circle_filled,
                            size: 65,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 175.0),
                    child: Container(child: new Text('Play your Selects',textAlign: TextAlign.start,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200,color: Color.fromRGBO(220, 220, 220, 1),),),),
                  ),
                  Flexible(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 100.0,
                      physics: BouncingScrollPhysics(),
                      diameterRatio: 2.5,
                      useMagnifier: true,
                      magnification: 1.1,
                      offAxisFraction: 1.0,
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context,index){
                          if (index >= 0 && index <= deviceSongs.length) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)
                                )
                              ),
                              child: Row(
                                children: <Widget>[
                                  ClipRect(
                                    child: Image(
                                      height: 50,
                                      width: 90,
                                      fit: BoxFit.cover,
                                      image: AssetImage('images/music.jpg'),
                                    ),
                                  ),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(

                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 13.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("${deviceSongs[index].title}",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700,color: Colors.white),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text("Artist: ${deviceSongs[index].artist}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11, color: Color.fromRGBO(220, 220, 220, 1),fontWeight: FontWeight.w500),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text("Album: ${deviceSongs[index].album}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11,color: Color.fromRGBO(220, 220, 220, 1),fontWeight: FontWeight.w500),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text("Duration: ${deviceSongs[index].duration}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11, color: Color.fromRGBO(220, 220, 220, 1),fontWeight: FontWeight.w500),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                         return null;

                        },
                        childCount: deviceSongs.length

                      ),
                    )
                    //
                  )
                ],
              ),
            ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Theme(data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: SnakeNavigationBar(
                style: SnakeBarStyle.floating,
                snakeShape: snakeShape,
                snakeColor: Colors.black,
                backgroundColor: Colors.white,
                currentIndex: _selectedItemPosition,
                padding: EdgeInsets.all(12),
                shape: barShape,
                onPositionChanged: (index){
                  setState(() {
                    _selectedItemPosition = index;
                    switch(index){
                      case 0:
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => playlist()));
                        break;
                    }
                  });
                },
                showSelectedLabels: true,

                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.playlist_play), title: Text('Playlists')),
                  BottomNavigationBarItem(icon: Icon(Icons.album),title: Text('Albums')),
                  BottomNavigationBarItem(icon: Icon(Icons.play_arrow),title: Text('Player')),
                  BottomNavigationBarItem(icon: Icon(Icons.audiotrack),title: Text('Tracks')),
                  BottomNavigationBarItem(icon: Icon(Icons.mic),title: Text('Artists'))      ],
              ),),
        )
      ],
    ),


  );
  }

}