import 'package:flutter/material.dart';
import 'package:practise_sqflite/contactmodal.dart';
import 'package:practise_sqflite/dbhelper.dart';

class EditorUpdate extends StatefulWidget {
  ContactModal? modall;
  String appBarText;
  String? contactAdding;
  String? emailAdding;
  bool? isAdd;
  EditorUpdate({required this.isAdd,this.emailAdding,this.contactAdding,required this.appBarText,this.modall,super.key});

  @override
  State<EditorUpdate> createState() => _EditorUpdateState();
}

class _EditorUpdateState extends State<EditorUpdate> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.isAdd == true ? '' : widget.modall?.name.toString());
    emailController = TextEditingController(text: widget.isAdd == true ? '' : widget.modall?.email.toString());
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }
  @override

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarText),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: widget.contactAdding
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: widget.emailAdding
                ),
              ),
              SizedBox(height: 25,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue
                ),
                onPressed: () async{
                  widget.isAdd == true ? 
                  await Dbhelper.instance.insertData(ContactModal(name: nameController.text,email: emailController.text)):
                  await Dbhelper.instance.updateData(ContactModal(id: widget.modall?.id, name: nameController.text, email: emailController.text));
                  Navigator.pop(context);
                }, child: widget.isAdd == true ? Text("Add Contact",style: TextStyle(color: Colors.white,fontSize: 20),): Text("Edit Contact",style: TextStyle(color: Colors.white,fontSize: 20),))
            ],
          ),
        ),
      ),
    );
  }
}