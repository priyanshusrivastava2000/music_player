import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class playlist extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return playlistState();
  }

}

class playlistState extends State<playlist>{
  List<PlaylistInfo> playlist = [];
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  void getPlaylist()async{
     playlist = await audioQuery.getPlaylists();
    print(playlist);
  }

  @override
  void initState() {
    super.initState();
    getPlaylist();
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
              child: IconButton(icon: Icon(Icons.search,color: Colors.white,size: 25.0,), onPressed: null),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:35.0,left: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: SafeArea(child: new Text('Playlists',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w700,color: Colors.white),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:110.0,right: 45),
                          child: Icon(
                            Icons.playlist_add,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 175.0,bottom: 15),
                    child: Container(child: new Text('Play your Selects',textAlign: TextAlign.start,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w200,color: Color.fromRGBO(220, 220, 220, 1),),),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                          border: Border.all(
                              color: Colors.white,
                              width: 3.0
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0)
                          )
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.favorite,
                            size: 50,
                            color: Colors.red,),
                          ),
                        ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}