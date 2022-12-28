import 'dart:io';

import 'package:band_name/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 2),
    Band(id: '2', name: 'Heroes del silencio', votes: 2),
    Band(id: '3', name: 'Queen', votes: 3),
    Band(id: '4', name: 'Bon Jovi', votes: 1),
    Band(id: '5', name: 'Foo Figthers', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addNewBand(),
        elevation: 1,
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(band.id),
      // ignore: sort_child_properties_last
      child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text( band.name.substring(0,2)),
              ),
              title: Text(band.name),
              trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
              onTap: () {
                if (kDebugMode) {
                  print(band.name);
                }
              },
            ),
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band',style: TextStyle(color: Colors.white)),
        )
      ),
      onDismissed: (DismissDirection direction) {
        if (kDebugMode) {
          print('direction: $direction');
          print('id: ${band.id}');
        }
      },
    );
  }

  // Methods
  addNewBand() {

    final TextEditingController textController = TextEditingController();

    if(Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        // No usamos la propiedad, esto es un estandar
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New band name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget> [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Add'),
                onPressed: () => addBandToList(textController.text)
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Dismiss'),
                onPressed: () => Navigator.pop(context)
              )
            ],
          );
        }
      );
    }
    else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget> [
              MaterialButton(
                elevation: 5,
                onPressed: () => addBandToList(textController.text),
                child: const Text('Add')
              )
            ],
          );
        },
      );
    }
  }

  void addBandToList(String bandName) {
    if(bandName.length > 1) {
      // Add
      bands.add(Band(
        id: DateTime.now().toString(),
        name: bandName,
        votes: 1)
      );

      setState(() {});
    }
    else {
      // Don't do anything
    }

    Navigator.pop(context);
  }
}