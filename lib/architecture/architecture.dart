import 'dart:convert';

import 'package:blogapp/CustumWidget/shopservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
class Architect extends StatefulWidget {

  @override
  _ArchitectState createState() => _ArchitectState();
}

class _ArchitectState extends State<Architect> {
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
  /*
  final httpClient=http.Client();
  Map<String,dynamic> customHeaders={
    "Accept":"application/json",
    "content-Type":"application/json;charset=UTF-8"
  };

  Future addData(Map body) async{
    final Uri restAPIURL=
    Uri.parse("https://jsonplaceholder.typicode.com/albums");
    http.Response response=await httpClient.post(restAPIURL
        ,headers: customHeaders,body: jsonEncode(body));
    return response.body;

  }*/
  var AName,about,designation,token,team,phoneNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0.0,
          centerTitle: true,
          title: Text('Create Architecture Profile',
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
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //                 <--- border radius here
                    ),
                  ),
                  child: Image(
                    image: AssetImage("assets/architect.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height:5.0),
                Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onChanged: (val){
                             AName=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),


                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Designation',
                                prefixIcon: Icon(Icons.attribution_outlined)),
                            onChanged: (val){
                              designation=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.all(15.0),
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
                          ),),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'About',
                              prefixIcon: Icon(Icons.attach_email_rounded),
                            ),
                            onChanged: (val){
                              about=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Team',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            onChanged: (val){
                              team=val;
                            },
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height:5.0),
                        Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Upload',
                                prefixIcon:GestureDetector(
                                child:Icon(Icons.upload),
                                  onTap: (){
                                    _showToast(context);
//                                    uploadImage();
                                  },
                                ),
                              ),
                              onChanged: (val){
                                team=val;
                              },
                            ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightGreen,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),),
                        SizedBox(height:5.0),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed:(){
                            ShopService().addArchitect(AName,designation,phoneNo,about,team).then((val){
                              Fluttertoast.showToast(
                                msg: val.data['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                            });
                          },
                          child: Text('Create Architect shop',
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
  /*uploadFile() async {
    var postUri = Uri.parse("<APIUrl>");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['audio']="audio";
    request.fields['file']="folder";
    request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri("<path/to/file>").readAsBytes(), contentType: new MediaType('image', 'jpeg')))

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }
  uploadImage(String title) async{
  var request=http.MultipartRequest("POST",Uri.parse(''));
  request.fields['audio']="audio";
  request.fields['file']="folder";
  Map<String,String> headers={"Authorization":"XYZ","ClientId":"ABC!@#"};
  request.headers.addAll(headers);
  request.headers['Authorization']="";
  //var audio=http.MultipartRequest.fromBytes('audio',(await rootBundle.load('assets/test.wav')).buffer.asUint8List(),filename:'test.wav');
  //var file=http.MultipartRequest.fromBytes('file',(await rootBundle.load('assets/NewFolder.zip'))..buffer.asUint8List(),filename:'NewFolder.zip');
  //var pdf=http.MultipartRequest.fromBytes('file',(await rootBundle.load('assets/NewFolder.zip'))..buffer.asUint8List(),filename:'NewFolder.zip');
  //request.files.add(audio);
  //request.files.add(file);
  //request.files.add(pdf);
  var response=await request.send();
  var responseData=await response.stream.toBytes();
  //var result =String.fromCharCode(responseData);
  }*/
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
