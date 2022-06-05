import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class Updateitem extends StatefulWidget {
  final String id;
  final String itemname;
  final String price;
  final String image;
  final String quantity;
  final String description;
  final String category;
  final String deliverystatus;
  // receive data from the FirstScreen as a parameter
  Updateitem(
      {
        @required this.id,
        @required this.itemname,
        @required this.description,
        @required this.price,
        @required this.quantity,
        @required this.category,@required this.deliverystatus, @required this.image,});

  @override
  State<Updateitem> createState() => _UpdateitemState(id,itemname,description,price,quantity,category,deliverystatus,image);
}

class Album {
  final String id;
  final String itemname;
  final String description;
  final String price;
  final String quantity;
  final String category;
  final String deliverystatus;
  final String image;

  const Album({@required this.id, @required this.itemname,@required this.description,@required this.price,@required this.quantity,@required this.category,@required this.deliverystatus,@required this.image});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      itemname: json['itemname'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
      deliverystatus: json['deliverystatus'],
      image: json['image'],
    );
  }
}
class _UpdateitemState extends State<Updateitem> {
  _UpdateitemState(this.id,this.itemname, this.description, this.price, this.quantity, this.category, this.deliverystatus, this.image);

  Future<Album> updateAlbum(String id,String itemname,String description, String price ,String quantity,String category, String deliverystatus,String image) async {
    print(id);
    final response = await http.post(
      Uri.parse('https://mongoapi3.herokuapp.com/update/item/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        '_id':id,
        'itemname':itemname,
        'description':description,
        'price':price,
        'quantity':quantity,
        'category':category,
        'deliverystatus':deliverystatus,
        'image':image
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }

/*Future<http.Response> updateAlbum(String id,String itemname,String description,String price,String quantity,String category,String deliverystatus,String image) {
  print(id);
  return http.post(
      Uri.parse('https://mongoapi3.herokuapp.com/update/item/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        '_id':id,
        'itemname': itemname,
        'description':description,
        'price':price,
        'quantity':quantity,
        'category':category,
        'deliverystatus':deliverystatus,
        'image':image


      }),

    );

  }*/

TextEditingController _itemname = TextEditingController();
TextEditingController _description = TextEditingController();
TextEditingController _price = TextEditingController();
TextEditingController _category = TextEditingController();
TextEditingController _qty = TextEditingController();
TextEditingController _deliverystatus = TextEditingController();
TextEditingController _image = TextEditingController();
  final String id;
  final String itemname;
  final String description;
  final String price;
  final String quantity;
  final String category;
  final String  deliverystatus;
  final String image;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _itemname.text=itemname;
      _description.text=description;
      _price.text=price;
      _qty.text=quantity;
      _category.text=category;
      _deliverystatus.text=deliverystatus;
      _image.text=image;

    });
    super.initState();
  }
  //var itemname, description, price, quantity, category, deliverystatus, image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0.0,
          centerTitle: true,
          title: Text('Update Item',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
        ),
        body: SingleChildScrollView(

          child: Container(
            margin: const EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[

                Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(15.0),
                          child: TextField(

                            controller:_itemname,
                            decoration: InputDecoration(
                              labelText: 'Name',

                              prefixIcon: Icon(Icons.person),
                            ),


                          ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightGreen,width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: _description,
                            decoration: InputDecoration(
                                labelText: 'Designation',
                                prefixIcon: Icon(Icons.attribution_outlined)),

                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: _price,
                            decoration: InputDecoration(
                              labelText: 'ContactNumber',
                              prefixIcon: Icon(Icons.contact_phone),
                            ),

                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextField(

                            controller: _qty,
                            decoration: InputDecoration(
                              labelText: 'About',
                              prefixIcon: Icon(Icons.attach_email_rounded),
                            ),

                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextField(

                            controller: _category,
                            decoration: InputDecoration(
                              labelText: 'Team',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextField(

                            controller: _deliverystatus,
                            decoration: InputDecoration(
                              labelText: 'Team',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: _image,
                            decoration: InputDecoration(
                              labelText: 'Image',
                              prefixIcon: Icon(Icons.lock),
                            ),

                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed:(){
            updateAlbum(id,itemname, description, price, quantity, category, deliverystatus, image);

                          },
                          child: Text('Update Item',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
