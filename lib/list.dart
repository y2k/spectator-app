import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:spectator/create.dart';
import 'package:spectator/domain.dart';
import 'package:spectator/menu.dart';
import 'package:spectator/snapshot.dart';

class Model {
  final List<Snapshot> list;
  Model(this.list);
  Model copy({List<Snapshot> list}) => Model(list ?? this.list);
}

abstract class Msg {}

class LoadedMsg extends Msg {
  final List<Snapshot> list;
  LoadedMsg(this.list);
}

Upd<Model, Msg> _init() {
  return Upd(
    Model(List<Snapshot>()),
    effects: Cmd.ofAsyncFunc(
      () => Services.getAllSnapshots(),
      onSuccess: (x) => LoadedMsg(x),
    ),
  );
}

Upd<Model, Msg> _update(Msg msg, Model model) {
  if (msg is LoadedMsg) return Upd(model.copy(list: msg.list));
  return Upd(model);
}

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return new Scaffold(
    appBar: AppBar(title: Text("Spectator")),
    drawer: Drawer(child: mkMenuWidget()),
    body: ListView.builder(
      itemCount: model.list.length,
      itemBuilder: (_, index) => SnapshotWidget(snapshot: model.list[index]),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => mkCreateWidget()),
        );
      },
      child: Icon(Icons.create),
    ),
  );
}

class SnapshotWidget extends StatelessWidget {
  const SnapshotWidget({Key key, @required this.snapshot}) : super(key: key);

  final Snapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => mkSnapshotWidget(snapshot.id)));
        },
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.3,
              child: Image.network(snapshot.preview, fit: BoxFit.fitWidth),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(snapshot.title),
            ),
          ],
        ),
      ),
    );
  }
}

Widget mkListWidget() => Program(_init, _update, _view).build();
