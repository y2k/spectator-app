import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:spectator/domain.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Model {
  final String preview;
  final String title;
  final String updated;
  Model(this.preview, this.title, this.updated);
}

abstract class Msg {}

class SnapshotMsg extends Msg {
  final Snapshot snapshot;
  SnapshotMsg(this.snapshot);
}

Upd<Model, Msg> _init(int id) => Upd(
      Model(id.toString(), "", ""),
      effects: Cmd.ofAsyncFunc(
        () => Services.getSnapshot(id),
        onSuccess: (r) => SnapshotMsg(r),
      ),
    );

Upd<Model, Msg> _update(Msg msg, Model model) => Upd(model);

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return Scaffold(
    appBar: AppBar(title: Text("Snapshot")),
    body: Column(
      children: <Widget>[
        Center(child: Text("Hello World #" + model.preview)),
      ],
    ),
  );
}

Widget mkSnapshotWidget(int id) =>
    Program(() => _init(id), _update, _view).build();
