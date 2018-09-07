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
      Model(null, null, null),
      effects: Cmd.ofAsyncFunc(
        () => Services.getSnapshot(id),
        onSuccess: (r) => SnapshotMsg(r),
      ),
    );

Upd<Model, Msg> _update(Msg msg, Model model) => Upd(model);

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return WebviewScaffold(
    url: model.preview,
    appBar: AppBar(
      title: Text("Snapshot"),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.web),
          onPressed: () {},
        ),
        new IconButton(
          icon: new Icon(Icons.email),
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget mkSnapshotWidget(int id) =>
    Program(() => _init(id), _update, _view).build();
