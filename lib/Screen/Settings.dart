import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool valNotify1=true;
  bool valNotify2=false;
  bool valNotify3=false;
  onChangeFunction1(bool newValue1){
    setState(() {
      valNotify1=newValue1;
    });
  }
  onChangeFunction2(bool newValue2){
    setState(() {
      valNotify2=newValue2;
    });
  }
  onChangeFunction3(bool newValue3){
    setState(() {
      valNotify3=newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Settings UI",style:TextStyle(fontSize: 22)),
        leading:IconButton(
          onPressed: (){

          },
          icon:Icon(
            Icons.arrow_back,color:Colors.white,
          ),
        ),
      ),
      body:Container(
        padding: const EdgeInsets.all(10),
        child:ListView(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(
                  Icons.person,color:Colors.blue,
                ),
                SizedBox(width: 10,),
                Text("Account",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
              ],
            ),
            Divider(height: 20,thickness: 1,),
            SizedBox(height: 10,),
            buildAccountOption(context, "change Password"),
            buildAccountOption(context, "Languages"),
            buildAccountOption(context, "Notification"),
            buildAccountOption(context, "change Password"),
            SizedBox(height:40),
            Row(
              children: [
                Icon(Icons.volume_up_outlined,color:Colors.blue),
                SizedBox(width:40),
                Text("Notification",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(height: 20,thickness: 1,),
            SizedBox(height:40),
            buildNotificationOption("Theme", valNotify1, onChangeFunction1),
            buildNotificationOption("Account Active", valNotify2, onChangeFunction2),
            buildNotificationOption("Theme", valNotify3, onChangeFunction3),
            SizedBox(height: 50,),
            Center(
              child:OutlinedButton(
                style:OutlinedButton.styleFrom(
                  padding:const EdgeInsets.symmetric(horizontal: 40),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                ),
                onPressed: (){

                },
                  child:Text("Signout",style:TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color:Colors.black,
                  )),
              ),
            ),

          ],
        )
      ),
    );
  }
  Padding buildNotificationOption(String title,bool value,Function onChangeMethod){
    return Padding(

      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(title,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color:Colors.grey[600],

              ),),
              Transform.scale(scale: 0.7,
              child:CupertinoSwitch(
                  activeColor: Colors.blue,
                trackColor: Colors.grey,
                value: value,
                onChanged: (bool newValue){
                    onChangeMethod(newValue);
                },
              )
              ),
              Icon(Icons.arrow_forward_ios,color:Colors.grey)
            ]
        ),

      ),
    );
  }
  GestureDetector buildAccountOption(BuildContext context,String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title:Text(title),
            content:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Option 1"),
                Text("Option 2"),

              ],
            ),
            actions: [
              TextButton(onPressed: (){}, child: Text("Close"))
            ],
          );
        });
      },
      child:Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(title,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color:Colors.grey[600],

            ),),
            Icon(Icons.arrow_forward_ios,color:Colors.grey)
          ]
      ),

      ),
    );
  }
}
