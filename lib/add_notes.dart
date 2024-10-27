import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String search = "";
  bool isSearch = false;
  TextEditingController searchCon = TextEditingController();

  TextEditingController userTitle = TextEditingController();
  TextEditingController userDescription = TextEditingController();

  void _insertData()async{
    var name = userTitle.text.toString();
    var description = userDescription.text.toString();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch == false
          ? AppBar(
              title: Text("Add Notes"),
              backgroundColor: Colors.green,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = true;
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            )
          : AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              leading: BackButton(
                onPressed: () {
                  setState(() {
                    isSearch = false;
                  });
                },
              ),
              title: TextFormField(
                maxLength: 10,
                maxLines: 1,

                decoration: const InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
      body:
      Column(
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: userTitle,
                    maxLength: 20,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: userDescription,
                    maxLength: 30,
                    maxLines: 5,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                    decoration: InputDecoration(
                      hintText: "Depcription",
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(15)),
            child: Center(child: Text("Save",style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold),)),
          ),
        ],
      ),
    );
  }
}
