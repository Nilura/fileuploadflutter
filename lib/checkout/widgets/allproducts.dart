import 'dart:convert';

import 'package:blogapp/checkout/models/cart.dart';
import 'package:blogapp/checkout/models/products.dart';
import 'package:blogapp/checkout/widgets/itemdetails.dart';
import 'package:blogapp/checkout/widgets/pdt_item.dart';
import 'package:blogapp/checkout/widgets/productdetails.dart';
import 'package:blogapp/shop/shopview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class Allproduct extends StatefulWidget {
  @override
  _AllproductState createState() => _AllproductState();
}

class _AllproductState extends State<Allproduct> {
  double rating=0;
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

//final List<itemmodel> itemdata=List.generate(_itemsJson.length, (index) => null)
  @override
  Widget build(BuildContext context) {
    // var myobj;
    final pdt = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);

    return GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: _itemsJson.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          final item = _itemsJson[index];

          return Card(
            color: Colors.amber,
            elevation: 10.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5.0,right: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreen,width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child:Image.network("${item['image']}"),
                ),


                ListTile(
                  isThreeLine: true,
                  leading:GestureDetector(child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage('https://source.unsplash.com/random?sig=$index'),),
                  onTap: () {Navigator.push(context,MaterialPageRoute(
                  builder: (context) => Shopview(text: '${item['itemname']}',price:'${item['price']}',image:'${item['image']}',description:'${item['description']}',quantity:'${item['quantity']}',category:'${item['category']}'),));},),
                  title: Text("Item:${item['itemname']}"),
                  subtitle:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text("Price:Rs${item['price']}"),
          buildRating(),
          TextButton(
          child:Text(
          'Show',style:TextStyle(fontSize:15),
          ),
          // onPressed: ()=>showRating(),
          ),
          ],
          ),
                  trailing: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('Item Added to Cart'),
                        ));
                        //String num="$item['price']";
                      double  myDouble = double.parse("${item['price']}");
                        cart.addItem("${item['itemname']}", "${item['itemname']}",myDouble);
                      }),
                  onTap: () {
                     Navigator.push(
                         context,
                        MaterialPageRoute(
                          builder: (context) => Itemdetails(text: '${item['itemname']}',price:'${item['price']}',image:'${item['image']}',description:'${item['description']}',quantity:'${item['quantity']}',category:'${item['category']}'),
                         ));
                  },
                ),
              ],
            ),
          );
        });
  }
  Widget buildRating()=>RatingBar.builder(
    minRating: 1,
    itemSize: 10,
    itemPadding: EdgeInsets.symmetric(horizontal: 4),
    itemBuilder:(context,_)=>Icon(Icons.star,color:Colors.amber),
    updateOnDrag: true,
    onRatingUpdate:(rating)=>setState((){
      this.rating=rating;
    }),);
}
