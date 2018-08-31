import 'package:flutter/material.dart';
import 'package:spectator/domain.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new MyHomePage(title: 'Spectator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Snapshot> list = [];

  @override
  void initState() {
    super.initState();

    () async {
      list = await Services.foo();
      setState(() {});
    }();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) =>
            new SnapshotWidget(snapshot: list[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.create),
      ),
    );
  }
}

class SnapshotWidget extends StatelessWidget {
  const SnapshotWidget({Key key, @required this.snapshot}) : super(key: key);

  final Snapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.3,
              child: Image.network(
                snapshot.preview,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(snapshot.title),
            ),
          ],
        ),
      ),
    );
  }
}
