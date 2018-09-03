import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:built_value/built_value.dart';
import 'package:spectator/domain.dart';
import 'package:spectator/elm.dart';

part 'create.g.dart';

//
// Update
//

abstract class Model implements Built<Model, ModelBuilder> {
  @nullable
  String get url;
  bool get isBusy;

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

class CreateModule implements ElmPage<Model, Msg> {
  Upd<Model, Msg> init() => Upd(Model((b) => b.isBusy = false));

  Upd<Model, Msg> reduce(Model model, Msg event) {
    if (event is EditMsg) return Upd(model.rebuild((x) => x.url = event.text));
    if (event is PressMsg)
      return Upd(
        model.rebuild((x) => x.isBusy = true),
        effects: Cmd.ofAsyncAction(
          () => Effects.createSubscription(model.url),
          onSuccess: () => CreateSuccessMsg(),
          onError: (e) => CreateFailedMsg(e),
        ),
      );
    if (event is CreateSuccessMsg)
      return Upd(model.rebuild((x) => x.isBusy = false),
          effects: Cmd.ofMsg(CloseMsg()));
    if (event is CreateFailedMsg)
      return Upd(model.rebuild((x) => x.isBusy = false));
    if (event is CloseMsg)
      return Upd(model, effects: Cmd.ofAction(() => Navigator.pop(null)));
    return Upd(model);
  }
}

//
// View
//

class CreateSubscriptionPage extends StatefulWidget {
  @override
  _CreateSubscriptionPageState createState() => _CreateSubscriptionPageState();
}

class _CreateSubscriptionPageState extends State<CreateSubscriptionPage>
    implements StateHolder<Model> {
  ElmManager<Model, Msg> elm;
  Model _model;

  @override
  void initState() {
    super.initState();
    elm = ElmManager(CreateModule(), this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            enabled: !_model.isBusy,
            decoration: InputDecoration(labelText: "Url"),
            onChanged: (text) => elm.dispatch(EditMsg(text)),
          ),
          RaisedButton(
            child: Text("Create"),
            onPressed: _model.isBusy ? null : () => elm.dispatch(PressMsg()),
          ),
          _model.isBusy ? CircularProgressIndicator() : Column(),
        ],
      ),
    );
  }

  @override
  Model getState() => _model;
  @override
  void updateState(Model value) => setState(() => _model = value);
}
