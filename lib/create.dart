import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:built_value/built_value.dart';
import 'package:spectator/domain.dart';

part 'create.g.dart';

abstract class Model implements Built<Model, ModelBuilder> {
  @nullable
  String get url;
  bool get isBusy;
  bool get isCanCreate;

  Model._();
  factory Model([updates(ModelBuilder b)]) = _$Model;
}

abstract class Msg {}

class EditMsg implements Msg {
  final String text;
  EditMsg(this.text);
}

class PressMsg implements Msg {}

class CreateSuccessMsg implements Msg {}

class CreateFailedMsg implements Msg {
  final Exception exn;
  CreateFailedMsg(this.exn);
}

class CloseMsg implements Msg {}

Upd<Model, Msg> _init() => Upd(Model((b) => b
  ..isBusy = false
  ..isCanCreate = false));

Upd<Model, Msg> _update(Msg event, Model model) {
  if (event is EditMsg)
    return Upd(model.rebuild((b) => b
      ..url = event.text
      ..isCanCreate = !model.isBusy && event.text.isNotEmpty));
  if (event is PressMsg)
    return Upd(
      model.rebuild((b) => b
        ..isBusy = true
        ..isCanCreate = false),
      effects: Cmd.ofAsyncAction(
        () => Services.createSubscription(model.url),
        onSuccess: () => CreateSuccessMsg(),
      ),
    );
  if (event is CreateSuccessMsg)
    return Upd(
      model.rebuild((b) => b
        ..isBusy = false
        ..isCanCreate = true),
      effects: Cmd.ofMsg(CloseMsg()),
    );
  if (event is CreateFailedMsg)
    return Upd(model.rebuild((b) => b.isBusy = false));
  if (event is CloseMsg)
    return Upd(model, effects: Cmd.ofAction(() => Navigator.pop(null)));
  return Upd(model);
}

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return Scaffold(
    appBar: AppBar(title: Text("Create")),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextField(
            enabled: !model.isBusy,
            decoration: InputDecoration(labelText: "Url"),
            onChanged: (text) => dispatch(EditMsg(text)),
          ),
          RaisedButton(
            child: Text("Create"),
            onPressed: model.isCanCreate ? () => dispatch(PressMsg()) : null,
          ),
          model.isBusy ? CircularProgressIndicator() : Column(),
        ],
      ),
    ),
  );
}

Widget mkCreateWidget() => Program(_init, _update, _view).build();
