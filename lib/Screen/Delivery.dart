import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  double rating=5;
  void lanchwhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("can't open whatsapp");
  }
  final myController = TextEditingController();
  final url="https://mongoapi3.herokuapp.com/delivery";
  //final url = "https://mongoapi3.herokuapp.com/delivery";
  var _postsJson = [];
  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }
  /*
  final String apiUrl = "http://ninanews.com/NinaNewsService/api/values/GetLastXBreakingNews?rowsToReturn=10";

  Future<List<dynamic>> fetchUsers() async {

    var result = await http.get(apiUrl);
    return json.decode(result.body)['Data'];

  }*/


/*
  final httpClient=http.Client();
  List<dynamic> todoData;
  Future fetchData() async {
    final Uri restAPIURL=
    Uri.parse("http://localhost:3000/users");
    http.Response response=await httpClient.get(restAPIURL);
 final Map parsedData=await json.decode(response.body.toString());
 todoData=parsedData['result'];

  }
*/
/*
   Map data;
   List userData;
  fgetUsers() async {
    http.Response response=await http.get('https://govi-piyasa-v-0-1.herokuapp.com/api/v1/shops');
    data=json.decode(response.body);
    setState(() {
      userData=data['data'];

    });

  }*/
  void initState() {
    super.initState();
    //  getUsers();
    fetchPosts();
    // fetchData();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0.0,
          centerTitle: true,
          title: Text('DeliveryPeople',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
        ),
        body: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.builder(
              itemCount: _postsJson.length,
              itemBuilder: (BuildContext context, index) {
                final post = _postsJson[index];
                return Container(
                  margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //                 <--- border radius here
                      ),
                    ),
                  child: ListTile(

                    leading: Image.network("${post['location']}"),
                    title: Text("Name:${post['name']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Type:${post['type']}"),
                        Text("Contact:+94${post['contact']}"),
                        Row(
                          children:[
                            Text("$rating"),
                            buildRating1(),
                          ]

                        ),
                        Row(
                            children:[
                              TextButton(
                                child:Text(
                                  'Rate',style:TextStyle(fontSize:14),
                                ),
                                onPressed: ()=>showRating(),
                              ),
                              TextButton(
                                child:Text(
                                  'review',style:TextStyle(fontSize:14),
                                ),
                                onPressed: ()=>showReview(),
                              ),
                            ]
                        ),],
                    ),
                    trailing: GestureDetector(
                      child: Icon(Icons.add_call),
                      onTap: () {
                        launch("tel://+94${post['contact']}");
                      },
                    ),
                    isThreeLine: true,
                  ),
                );
              }),
        ));
  }

  Widget buildRating()=>RatingBar.builder(
    minRating: 1,
    itemSize: 18,
    itemPadding: EdgeInsets.symmetric(horizontal: 4),
    itemBuilder:(context,_)=>Icon(Icons.star,color:Colors.amber),
    updateOnDrag: true,
    onRatingUpdate:(rating)=>setState((){
      this.rating=rating;
    }),);
  Widget buildRating1()=>RatingBar.builder(
    minRating: 1,
    itemSize: 18,
    itemPadding: EdgeInsets.symmetric(horizontal: 4),
    itemBuilder:(context,_)=>Icon(Icons.star,color:Colors.amber),
    updateOnDrag: true,
    onRatingUpdate:(rating)=>setState((){
      this.rating=rating;
    }),);
  void showRating()=>showDialog(
  context:context,
  builder:(context)=>AlertDialog(
    title:Text('Rate this Product'),
    content: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children:[
      Text('Please leave a star rating',
          style:TextStyle(fontSize:10)),
      SizedBox(height: 5.0,),
   Row(
     children: [
       Text("$rating"),
       buildRating(),
     ],
   )

    ]),
  actions: [
  TextButton(onPressed:()=>Navigator.pop(context) , child: Text('Ok',style:TextStyle(fontSize:20)))
  ],
  ),);
  void showReview()=>showDialog(
    context:context,
    builder:(context)=>AlertDialog(
      title:Text('Review this Product'),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:[
            SizedBox(height: 5.0,),
            TextField(controller:myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Review',),),]),
      actions: [
        TextButton(onPressed:()=>Navigator.pop(context) , child: Text('Ok',style:TextStyle(fontSize:20)))
      ],
    ),);
}
