import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart';

import 'CreatePost.dart';
class Postlist extends StatefulWidget {


  @override
  _State createState() => _State();
}

class _State extends State<Postlist> {

  final url="https://mongoapi3.herokuapp.com/posts";

  var _postsJson = [];
  String answer;
  void getPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
  }
  void initState() {
    super.initState();
    getPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          flexibleSpace: Image(
            image: AssetImage('assets/about.jpg'),
            fit: BoxFit.cover,
          ),
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.plus),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePost(),
                      ));
                }),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final post = _postsJson[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                    margin: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child:Text("Question:${post['title']}",  style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),),),
                        Text("Category:${post['category']}"),
                        Text("description:${post['description']}"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0,),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Comment here',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.attribution_outlined)),
                              onChanged: (val){
                                answer=val;
                              },
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(icon: Icon(Icons.add_task_rounded ,),
                          onPressed: (){
                            Fluttertoast.showToast(
                              msg: "Added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }),

                      FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Warning"),
                                  content: Text("Are you sure want to delete data profile ${post['title']}?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        /*  apiService.deleteProfile(profile.id).then((isSuccess) {
                                                if (isSuccess) {
                                                  setState(() {});
                                                  Scaffold.of(this.context)
                                                      .showSnackBar(SnackBar(content: Text("Delete data success")));
                                                } else {
                                                  Scaffold.of(this.context)
                                                      .showSnackBar(SnackBar(content: Text("Delete data failed")));
                                                }
                                              });*/
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        //   Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: _postsJson.length,
          ),
        )
    );
  }
}
