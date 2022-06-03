import 'dart:convert';
import 'dart:io';
import 'package:blogapp/Screen/googlemap.dart';
import 'package:blogapp/shop/table/main.dart';
import 'package:blogapp/shop/vieworders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Chart.dart';
import 'additem.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'item.dart';
import 'itemservice.dart';

class Showitem extends StatefulWidget {

//  final Album cases;
  _ShowitemState createState() => _ShowitemState();
}

class _ShowitemState extends State<Showitem> {
  final Itemservice api = Itemservice();
  File _image;
  final picker=ImagePicker();

  String _imagepath;

  final url = "https://mongoapi3.herokuapp.com/items";
 // final url="https://govi-piyasa-v-0-1.herokuapp.com/api/v1/shops/6295318a8cde410a4f1ec1b4";
  var _itemsJson = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body)as List;
      setState(() {
        _itemsJson = jsonData;
      });
    } catch (err) {

    }
  }

  void SaveImage(path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("imagepath", path);
  }

  Future deletePost(int id) async {
    final response =
    await http.delete("https://mongoapi3.herokuapp.com/item/$id");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<http.Response> deleteitem(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://mongoapi3.herokuapp.com/item/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }
  chooseImage(ImageSource source) async{
    var image=await picker.getImage(source:source);
    setState(() {
      _image=image as File;
    });
  }
  void initState() {

    fetchPosts();
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String city = "Ja-ela";
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItem(),
                    ));
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.edit ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewOrder(),
                    ));
              }),
          IconButton(
              icon: Icon(Icons.add_chart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chart(),
                    ));
              }),
          IconButton(
              icon: Icon(Icons.add_moderator_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormPage(),
                    ));
              }),
          IconButton(
              icon: Icon(Icons.add_moderator_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ));
              })
        ],
      ),
      //AssetImage("assets/architect.jpg")
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent,width: 1)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.greenAccent)
                                    ),
                                    child:Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child:Container(
                                        height: 200,
                                        width:250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                          image:DecorationImage(
                                            image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/myweb-72a93.appspot.com/o/govipiyasa%2Fshop.jpg?alt=media&token=fbe35e0b-76fc-4f7c-ad9b-730b9476860c'),
                                          ),),),
                                    ),


                                    // ):Container(
                                    //   height: 150,
                                    //   width:150,
                                    //   decoration: BoxDecoration(
                                    //     image:DecorationImage(
                                    //       image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/myweb-72a93.appspot.com/o/govipiyasa%2Fshop.jpg?alt=media&token=fbe35e0b-76fc-4f7c-ad9b-730b9476860c'),
                                    //     ),
                                    //
                                    //   ),
                                    // ),
                                  ),]),),),]),),),
              Divider(),
              SizedBox(
                height: 60,
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: Column(
                                children: [
                                  GestureDetector(
                                    child: Row(
                                        children: [
                                          IconButton(
                                              onPressed:(){
                                                chooseImage(ImageSource.gallery);
                                              }, icon: Icon(Icons.camera_alt_sharp) ),
                                          IconButton(
                                              onPressed:(){
                                                SaveImage(_image.path);
                                                Fluttertoast.showToast(
                                                  msg: "Saved",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              }, icon: Icon(Icons.api_outlined) ),

                                          Icon(Icons.add_location),
                                          Text("${city}"),
                                        ]),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Map(text: "${city}"),
                                          ));
                                    },
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ]),
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
                      return Container(
                          height: 150,
                          width: 150,
                          child:Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network("${item['image']}",
                                  width: 90, height: 90, fit: BoxFit.fill),
                              ListTile(
                                isThreeLine: true,
                                title: Text("name:${item['itemname']}"),
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
                                    // snapshot.data.removeAt(index);
                                    //_onDeleteItemPressed(index);
                                    //deletePost(item['_id']);
                                   // deletePost(_itemsJson[index]['id']);
                                    deleteitem(item['id']);
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
                          )));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.getString("imagepath");
    setState(() {
      _imagepath= pref.getString("imagepath");
    });
  }
}
