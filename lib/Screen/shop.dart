import 'dart:convert';

import 'package:blogapp/CustumWidget/shopservice.dart';
import 'package:blogapp/shop/shoprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Shop extends StatefulWidget {

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {

/*  "sellerName":sellerName,
  "contactNumber":phoneNo,
  "email":email,
  "address":address,*/
/*
 Future<void> postData() async{
    try {
      final response =await http.post(
          Uri.parse("http://localhost:5000/userTask/createUserTask"),
          body: {
            "name":shopName,
            "age":city

          });
      print(response.body);
    }catch(e){
      print(e);
    }
  }*/

  var shopName,email,sellerName,phoneNo,address,city;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0.0,
          centerTitle: true,
          title: Text('Create shop',
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
                  margin: const EdgeInsets.all(10.0),

                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //                 <--- border radius here
                    ),
                  ),
                  child: Image(
                    image: AssetImage("assets/shop.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height:5.0),
                Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ShopName',
                                prefixIcon: Icon(Icons.person),
                              ),
                            onChanged: (val){
                              shopName=val;
                            },
                          ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightGreen,width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),

                            )
                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                         decoration: InputDecoration(

                                  labelText: 'SellerName',
                                  prefixIcon: Icon(Icons.attribution_outlined)),
                            onChanged: (val){
                              sellerName=val;
                            },
                          ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightGreen,width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),

                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ContactNumber',
                                prefixIcon: Icon(Icons.contact_phone),
                              ),
                            onChanged: (val){
                              phoneNo=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.attach_email_rounded),
                            ),
                            onChanged: (val){
                              email=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                          ),
                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'City',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            onChanged: (val){
                              city=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Address',
                              prefixIcon: Icon(Icons.add_location),
                            ),
                            onChanged: (val){
                              address=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed:(){

                            ShopService().addShop(shopName,sellerName,phoneNo,email,address,city).then((val){
                              Fluttertoast.showToast(
                                msg: val.data['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>Showitem()));

                            });
                          },
                          child: Text('Create shop',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
