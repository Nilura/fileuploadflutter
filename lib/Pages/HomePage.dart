

import 'package:blogapp/Pages/WelcomePage.dart';
import 'package:blogapp/Screen/About.dart';
import 'package:blogapp/Screen/Delivery.dart';
import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:blogapp/Profile/ProfileScreen.dart';
import 'package:blogapp/Screen/Architectlist.dart';
import 'package:blogapp/Screen/Map.dart';

import 'package:blogapp/Screen/Settings.dart';

import 'package:blogapp/Screen/feedback.dart';
import 'package:blogapp/Screen/expertlist.dart';
import 'package:blogapp/Search/grid_search.dart';
import 'package:blogapp/Search/page/filter_local_list_page.dart';
import 'package:blogapp/architecture/ArchitectCreate.dart';
import 'package:blogapp/architecture/widget_screen.dart';
import 'package:blogapp/crud/app.dart';
import 'package:blogapp/payment/gateway/payment.dart';

import 'package:blogapp/shop/shoprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

import 'bg_drawer.dart';
//import 'package:blogapp/onesignal_flutter/onesignal_flutter.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key, this.value}) : super(key: key);
  String value;
  @override
  _HomePageState createState() => _HomePageState(value);
}

class _HomePageState extends State<HomePage> {
/*
static final String oneSignalAppId="7a1f4b11-b687-479e-84b1-35d8ac53978f";
Future<void> initPlateformState() async{
  OneSignal.shared.setAppId(oneSignalAppId);
}*/
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  List<String> titleString = ["Home Page", "Profile Page"];
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );
  String value;
  _HomePageState(this.value);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
        keyOne,
        keyThree,
        keyFour,
        keyTwo,
      ]),
    );
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
            radius: 50,
            // backgroundImage: NetworkHandler().getImage(response['username']),
            backgroundImage:AssetImage('assets/logo1.png')
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/logo1.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    String _message;
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
          () {
        if (hour >= 5 && hour < 12) {
          _message = 'Good Morning';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'Good Afternoon';
        } else {
          _message = 'Good Evening';
        }
      },
    );
    return Scaffold(
      drawer: Drawer(
        child: CustomPaint(
        painter: BackgroundDrawer(),
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    profilePhoto,
                    SizedBox(
                      height: 10,
                    ),
                    Text("@$username"),
                  ],
                ),
              ),
              ListTile(
                title: Text("Delivery"),
                trailing: Icon(Icons.airport_shuttle, color: Colors.green),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Delivery()));
                },
              ),
              ListTile(
                title: Text("Feedback"),
                trailing: Icon(Icons.feedback, color: Colors.green),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ReachUs()));
                },
              ),
              ListTile(
                title: Text("Designers"),
                trailing: Icon(Icons.assistant_rounded, color: Colors.green),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>expert()));
                },
              ),
              ListTile(
                title: Text("Expertlist"),
                trailing: Icon(Icons.lightbulb_rounded, color: Colors.green),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>SellerList()));
                },
              ),
              ListTile(
                title: Text("About"),
                trailing: Icon(Icons.assignment_sharp, color: Colors.green),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>About()));
                },
              ),

              Divider(),
              ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.power_settings_new, color: Colors.green),
                onTap: logout,
              ),
            ],
          ),
        )

      ),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0.0,
        centerTitle: true,
        title: Text(_message,
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Colors.lightGreen)),
        flexibleSpace: Image(
          image: AssetImage('assets/about.jpg'),
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.notifications),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => ShopNotification(),
              //   ),
              // );
            },
            // icon: Showcase(
            //   key: keyThree,
            //   description: 'Notification',
            //   shapeBorder: const CircleBorder(),
            //   showcaseBackgroundColor: Colors.indigo,
            //   descTextStyle: const TextStyle(
            //     fontWeight: FontWeight.w500,
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            //
            //   contentPadding: const EdgeInsets.all(20),
            //   child: const  Icon(Icons.notifications),
            // ),
          ),


          PopupMenuButton<int>(
            onSelected: (item)=>onSelected(context,item),
            itemBuilder: (context)=>[
              PopupMenuItem<int>(
                value:0,
                child:Row(
                  children:[
                    Icon(Icons.apps_rounded,color:Colors.blue),
                    Text("Services"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value:1,
                child:Row(
                  children:[
                    Icon(Icons.api_sharp ,color:Colors.blue),
                    Text("Settings"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value:2,
                child:Row(
                  children:[
                    Icon(Icons.art_track_outlined,color:Colors.blue),
                    Text("Search"),
                  ],

                ),

              ),
              PopupMenuItem<int>(
                value:3,
                child:Row(
                  children:[
                    Icon(Icons.article_sharp ,color:Colors.blue),
                    Text("Add Blog"),
                  ],

                ),

              ),
              PopupMenuItem<int>(
                value:4,
                child:Row(
                  children:[
                    Icon(Icons.app_registration_sharp,color:Colors.blue),
                    Text("Crud"),
                  ],),),
              PopupMenuItem<int>(
                value:5,
                child:Row(
                  children:[
                    Icon(Icons.add_location_rounded ,color:Colors.blue),
                    Text("Map"),
                  ],),),
              PopupMenuItem<int>(
                value:6,
                child:Row(
                  children:[
                    Icon(Icons.add_location_rounded ,color:Colors.blue),
                    Text("Near Shops"),
                  ],),),

            ],)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Showitem()));
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        color: Colors.lightGreen,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 40,
                )
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }
  void onSelected(BuildContext context, int item) {
    switch(item){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>WidgetScreen()));break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Settings()));break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>GridSearch()));break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ArchitectCreate()));break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>App()));break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Map2()));break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Map2()));break;
    }
  }
  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
            (route) => false);
  }
}

