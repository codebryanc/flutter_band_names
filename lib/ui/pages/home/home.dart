import 'package:band_name/models/band.dart';
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
        onPressed: (){},
        elevation: 1,
      ),
   );
  }

  ListTile _bandTile(Band band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text( band.name.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(band.name),
      trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
      onTap: () {
        print(band.name);
      },
    );
  }
}