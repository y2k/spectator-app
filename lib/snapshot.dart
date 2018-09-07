import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:spectator/domain.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Model {
  final String url;
  final String title;
  final String updated;
  final Snapshot snapshot;
  Model(this.url, this.title, this.updated, this.snapshot);
  Model copy({String url, String title, String updated, Snapshot snapshot}) =>
      Model(
        url ?? this.url,
        title ?? this.title,
        updated ?? this.updated,
        snapshot ?? this.snapshot,
      );
}

abstract class Msg {}

class SnapshotMsg extends Msg {
  final Snapshot snapshot;
  SnapshotMsg(this.snapshot);
}

class SelectWeb extends Msg {}

class SelectDiff extends Msg {}

Upd<Model, Msg> _init(int id) => Upd(
      Model("http://joyreactor.cc/", null, null, null),
      effects: Cmd.ofAsyncFunc(
        () => Services.getSnapshot(id),
        onSuccess: (r) => SnapshotMsg(r),
      ),
    );

Upd<Model, Msg> _update(Msg msg, Model model) {
  if (msg is SnapshotMsg) return Upd(model.copy(snapshot: msg.snapshot));
  if (msg is SelectWeb) return Upd(model.copy(url: model.snapshot?.web));
  if (msg is SelectDiff) return Upd(model.copy(url: model.snapshot?.diff));
  return Upd(model);
}

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return WebviewScaffold(
    url: model.url,
    appBar: AppBar(
      title: Text(model.url),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.public),
          onPressed: () => dispatch(SelectWeb()),
        ),
        new IconButton(
          icon: new Icon(Icons.history),
          onPressed: () => dispatch(SelectDiff()),
        ),
      ],
    ),
  );
}

Widget mkSnapshotWidget(int id) =>
    Program(() => _init(id), _update, _view).build();
