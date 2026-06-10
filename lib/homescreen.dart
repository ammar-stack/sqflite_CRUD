import 'package:flutter/material.dart';
import 'package:practise_sqflite/contactmodal.dart';
import 'package:practise_sqflite/dbhelper.dart';
import 'package:practise_sqflite/editorupdate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<ContactModal> dataContact = [];
  refreshListData(){
    setState(() {
      
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Data"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: FutureBuilder<List<ContactModal>>(
        future: Dbhelper.instance.getData(), 
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 20,),);
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"),);
          }
          else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(
              child: Text("No Contacts Found",style: TextStyle(fontSize: 18,color: Colors.blue),)
            );
          }
          else{
            dataContact = snapshot.data!;
            return ListView.builder(
              itemCount: dataContact.length,
              itemBuilder: (context,index){
                return Card(child: ListTile(
                  tileColor: Colors.white60,
                  leading: CircleAvatar(backgroundColor: Colors.green,child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditorUpdate(isAdd: false, appBarText: 'Edit Contact',modall: ContactModal(id: dataContact[index].id,name: dataContact[index].name,email: dataContact[index].email),))).then((_) => refreshListData());
                  }, icon: Icon(Icons.edit,color:Colors.white))),
                  title: Text(dataContact[index].name.toString()),
                  subtitle: Text(dataContact[index].email.toString()),
                  trailing: CircleAvatar(backgroundColor: Colors.red,child: IconButton(onPressed: (){
                    Dbhelper.instance.deleteData(ContactModal(id: dataContact[index].id,));
                    refreshListData();
                    }, icon: Icon(Icons.delete,color:Colors.white))),
                ),);
              });
          }
        }),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditorUpdate(isAdd: true,appBarText: 'Add Contact',contactAdding: 'Add Contact',emailAdding: 'Add Email',))).then((_) => refreshListData());
        },backgroundColor: Colors.blue,child: Icon(Icons.add,color: Colors.black,)),
    );
  }
}