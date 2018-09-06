import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';

class Model {
  final String preview;
  Model(this.preview);
}

abstract class Msg {}

Upd<Model, Msg> _init(int id) => Upd(Model(id.toString()));

Upd<Model, Msg> _update(Msg msg, Model model) => Upd(model);

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return Scaffold(
    appBar: AppBar(title: Text("Snapshot")),
    body: Center(child: Text("Hello World #" + model.preview)),
  );
}

Widget mkSnapshotWidget(int id) =>
    Program(() => _init(id), _update, _view).build();
