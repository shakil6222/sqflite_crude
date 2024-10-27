import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataBaseHelper dbHelper = DataBaseHelper();
  List<Map<String, dynamic>> notes = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  int? selectedNoteId;

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Fetch notes when the page initializes
  }

  Future<void> _fetchNotes() async {
    final fetchedNotes = await dbHelper.getAllNotes();
    setState(() {
      notes = fetchedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bottomShift,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${notes[index]['id']}"),
              ),
              title: Text(notes[index]['title'] ?? "No Title"),
              subtitle: Text(notes[index]['description'] ?? "No Description"),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      update_showDialog(notes[index]);
                    },
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Edit"),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      _confirmDelete(notes[index]['id']);
                    },
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("Delete"),
                    ),
                  ),
                ],
                onSelected: (value) {

                },
              ),
            ),
          );
        },
      ),
    );
  }

  void bottomShift() {
    titleController.clear();
    descriptionController.clear();
    selectedNoteId = null; // Reset the selected note ID for adding a new note

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  "Add Notes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 21),
                ),
              ),
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
                        controller: titleController,
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
                      padding: const EdgeInsets.all(12),
                      child: TextFormField(
                        controller: descriptionController,
                        maxLength: 30,
                        maxLines: 5,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue),
                        decoration: const InputDecoration(
                          hintText: "Description",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _insertNotes,
                child: Container(
                  height: 50,
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _insertNotes() async {
    var titleName = titleController.text.toString();
    var description = descriptionController.text.toString();
    if (titleName.isNotEmpty && description.isNotEmpty) {
      Map<String, dynamic> newNote = {
        'title': titleName,
        'description': description,
      };
      await dbHelper.insertNewUser(newNote);
      _fetchNotes();
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: "Fill in All Blanks");
    }

    }

  void _updateNote(Map<String, dynamic> note) async {
    var updateTitle = titleController.text;
    var updateDescription = descriptionController.text;
    if (updateTitle.isNotEmpty || updateDescription.isNotEmpty) {
      updateTitle = note["title"];
      updateDescription = note["description"];
      selectedNoteId = note['id'];

    }
    else{
      Fluttertoast.showToast(msg: "Please fill in all fields.");
    }

    Map<String, dynamic> noteData = {
      'id': selectedNoteId,
      'title': titleController.text,
      'description': descriptionController.text,
    };

    await dbHelper.update(noteData);
    Fluttertoast.showToast(msg: "Note updated successfully!");
    _fetchNotes();
    Navigator.pop(context);
  }

  Future<void> update_showDialog(Map<String, dynamic> note) {
    titleController.text = note['title'];
    descriptionController.text = note['description'];
    selectedNoteId = note['id'];

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Update Title',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Update Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),

              ),
              onPressed: () {
                _updateNote(note);
              },
              child:
              Center(child: Text('Update',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight:FontWeight.bold),)),
            ),
          ],
        );
      },
    );
  }

// Call this method from the PopupMenuButton

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await dbHelper.delete(id);
                Fluttertoast.showToast(msg: "Note deleted successfully!");
                _fetchNotes(); // Refresh the notes
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
