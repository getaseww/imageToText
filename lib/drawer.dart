import 'package:flutter/material.dart';
import 'package:ocr/utils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: appBarColor,
            ),
            accountName: Center(
              child: Text(
                "Image to Text",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.w600)
              ),
            ), //style: TextStyle(color: Colors.black),),
            accountEmail:
                Text(""), //style: TextStyle(color: Colors.black),)
          ),
          ListTile(
              title: Text("About Us",style: TextStyle(fontSize: 17)),
              leading: Icon(Icons.person,color: drawerIconColor,),
              onTap: () {
                
              }),
         
          ListTile(
            title: Text("About the app",style: TextStyle(fontSize: 17)), 
            leading: Icon(Icons.apps,color: drawerIconColor,),
            onTap: (){
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>()));
            },),          
          ListTile(
            title: Text("Share App",style: TextStyle(fontSize: 17)),
            leading: Icon(Icons.share,color:drawerIconColor),
            onTap: () {
            },
          ),
          ListTile(
            title: Text("Write a review",style: TextStyle(fontSize: 17),),
            leading: Icon(Icons.star_rate,color: drawerIconColor,),
            onTap: () {
            },
          ),
          ListTile(
            title: Text("Exit",style: TextStyle(fontSize: 17)),
            leading: Icon(Icons.exit_to_app,color: drawerIconColor,),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
