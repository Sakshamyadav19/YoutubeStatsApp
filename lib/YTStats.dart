import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class YTStats extends StatefulWidget {
  @override
  _YTStatsState createState() => _YTStatsState();
}

class _YTStatsState extends State<YTStats> {
  var views = '-';
  var likes = '-';
  var dislikes = '-';
  var cmnts = '-';
  String match = "";
  var x;
  final TextEditingController input = new TextEditingController();
  ytdata() async {
    var id = input.text;
    for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match match = exp.firstMatch(id);
    if (match != null && match.groupCount >= 1) x=match.group(1);
  }

    var url ='https://www.googleapis.com/youtube/v3/videos?id=$x&key=AIzaSyD6oPkKotE9exXdtdNF6nkwAL1w1wLuXqI&part=statistics';
    var dio = Dio();
    Response response = await dio.get(url);
    setState(() {
      views = response.data['items'][0]['statistics']['viewCount'];
      likes = response.data['items'][0]['statistics']['likeCount'];
      dislikes = response.data['items'][0]['statistics']['dislikeCount'];
      cmnts = response.data['items'][0]['statistics']['commentCount'];
    });
  }
  clear()
  {
    setState(() {
     views = '-';
     likes = '-';
     dislikes = '-';
     cmnts = '-';
     input.text="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
            child: Text(
          "YTStats",
          textAlign: TextAlign.center,
        )),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.text,
                controller: input,
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(fontSize: 20.0, color: Colors.redAccent),
                  labelText: "URL",
                  fillColor: Colors.red,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: Text("Submit"),
              onPressed: ytdata,
              color: Colors.teal,
              height: 50,
              minWidth: 50,
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: Colors.red,
              child: ListTile(
                leading: Icon(
                  Icons.remove_red_eye_outlined,
                  size: 30,
                ),
                title: Text(
                  "$views",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: Colors.red,
              child: ListTile(
                leading: Icon(
                  Icons.thumb_up_sharp,
                  size: 30,
                ),
                title: Text(
                  "$likes",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: Colors.red,
              child: ListTile(
                leading: Icon(
                  Icons.thumb_down,
                  size: 30,
                ),
                title: Text(
                  "$dislikes",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: Colors.red,
              child: ListTile(
                leading: Icon(
                  Icons.insert_comment,
                  size: 30,
                ),
                title: Text(
                  "$cmnts",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: Text("Clear"),
              onPressed: clear,
              color: Colors.teal,
              height: 50,
              minWidth:80,
            ),
          ],
        ),
      ),
    );
  }
}
