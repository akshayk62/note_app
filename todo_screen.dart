import 'package:flutter/material.dart';
import 'package:note_2/controller/todo_services.dart';
import 'package:note_2/models/todomodel.dart';

class Notohomepage extends StatefulWidget {
  const Notohomepage({super.key});

  @override
  State<Notohomepage> createState() => _NotohomepageState();
}

class _NotohomepageState extends State<Notohomepage> {
  final TextEditingController _titlecontoller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();

  final Notoservice _todobox = Notoservice();

  List<Todo> _notos = [];

  Future<void> loadnoto() async {
    _notos = await _todobox.getall();

    setState(() {

    });
  }

  @override
  void initState() {
    

    loadnoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'ADD',
          child: Icon(Icons.add_outlined),
          onPressed: () => _showdialog()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _notos.length,
                  itemBuilder: (BuildContext, index) {
                    final no = _notos[index];
                     return ListTile(
                      leading: Text('1'),
                      title: Text('${no.title}'),
                      subtitle: Text('${no.description}'),
                      trailing: Checkbox(value: true, onChanged: (bool) {}),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showdialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ADD NEW TESK'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final newnoto = Todo(
                            title: _titlecontoller.text,
                            description: _descriptioncontroller.text,
                            createdAt: DateTime.now(),
                            completed: false);

                        await _todobox.add(newnoto);

                        _titlecontoller.clear();
                        _descriptioncontroller.clear();
                        Navigator.pop(context);

                        loadnoto();

                        
                      },
                      child: Text('ADD')),
                  ElevatedButton(onPressed: () {}, child: Text('CANCEL')),
                ],
              ),
            ],
            content: Center(
              child: Container(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _titlecontoller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'TITLE'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptioncontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'DESCRIPTION'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
