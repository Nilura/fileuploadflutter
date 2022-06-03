import 'dart:convert';

import 'package:blogapp/Pages/SinInPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class Architect extends StatefulWidget {

  final String name;
  final String about;
  final String contact;
  final String team;

  // receive data from the FirstScreen as a parameter
  Architect({Key key, @required this.name,@required this.about,@required this.contact,@required this.team}) : super(key: key);
  @override
  _ArchitectState createState() => _ArchitectState();
}

class _ArchitectState extends State<Architect> {

  final url = "https://mongoapi3.herokuapp.com/items";
  var _itemsJson = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _itemsJson = jsonData;
      });
    } catch (err) {}
  }

  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)
        ),
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              SizedBox(
                height: 150,
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              image:DecorationImage(
                                image: AssetImage("assets/architect.jpg"),
                                fit: BoxFit.contain,
                              ),
                            )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            SizedBox(height: 10,),
                            Text("Profilename:${widget.name}"),
                            Text("About:${widget.about}"),
                            Text("Contact:${widget.contact}"),
                            Text("Team:${widget.team}"),

                          ]

                        )

                      ]

                  ),

                ),
              ),
              Divider(),
              Flexible(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: _itemsJson.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = _itemsJson[index];
                        return Card(
                            elevation: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network("${item['image']}",
                                    width: 120, height: 100, fit: BoxFit.fill),
                                ListTile(
                                  isThreeLine: true,
                                  title: Text("Item name:${item['itemname']}"),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Description:${item['description']}"),
                                      Text("Price:${item['price']}"),
                                      Text("Type:${item['category']}"),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    child: Icon(
                                      FontAwesomeIcons.trash,
                                      size: 20.0,
                                      color: Colors.brown[900],
                                    ),
                                    onTap: () {

                                     // deletePost(item['_id']);
                                      /* setState(() {
                                      deletePost(item['_id']);
                                    });*/

                                      Fluttertoast.showToast(
                                        msg: "Deleted",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    },
                                  ),)
                              ],
                            ));
                      })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
