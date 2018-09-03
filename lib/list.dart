import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:spectator/create.dart';
import 'package:spectator/domain.dart';
import 'package:spectator/elm.dart';

//
// Update
//

class Model {
  final List<Snapshot> list;
  Model(this.list);
  Model copyWith({List<Snapshot> list}) => Model(list ?? this.list);
}

abstract class Msg {}

class LoadedMsg extends Msg {
  final List<Snapshot> list;
  LoadedMsg(this.list);
}

class PageFunctions implements ElmPage<Model, Msg> {
  Upd<Model, Msg> init() => Upd(
        Model(List<Snapshot>()),
        effects: Cmd.ofAsyncFunc(
          () => Services.getAllSnapshots(),
          onSuccess: (x) => LoadedMsg(x),
        ),
      );

  Upd<Model, Msg> reduce(Model model, Msg msg) {
    if (msg is LoadedMsg) return Upd(model.copyWith(list: msg.list));
    return Upd(model);
  }
}

//
// View
//

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements StateHolder<Model> {
  Model _model;
  ElmManager<Model, Msg> elm;

  @override
  void initState() {
    super.initState();
    elm = ElmManager(PageFunctions(), this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: ListView.builder(
        itemCount: _model.list.length,
        itemBuilder: (context, index) =>
            new SnapshotWidget(snapshot: _model.list[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSubscriptionPage()),
          );
        },
        child: Icon(Icons.create),
      ),
    );
  }

  @override
  Model getState() => _model;
  @override
  void updateState(Model value) => setState(() => _model = value);
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
