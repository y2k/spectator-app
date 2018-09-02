import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:built_value/built_value.dart';
import 'package:spectator/domain.dart';

part 'create.g.dart';

//
// Update
//

abstract class Model implements Built<Model, ModelBuilder> {
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

Model init() => Model();

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
    return Upd(model.rebuild((x) => x.isBusy = false));
  if (event is CreateFailedMsg)
    return Upd(model.rebuild((x) => x.isBusy = false));
  return Upd(model);
}

//
// View
//

class CreateSubscriptionPage extends StatefulWidget {
  @override
  CreateSubscriptionPageState createState() =>
      new CreateSubscriptionPageState();
}

class CreateSubscriptionPageState extends State<CreateSubscriptionPage> {
  Model _model = init();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            enabled: !_model.isBusy,
            decoration: InputDecoration(labelText: "Url"),
            onChanged: (text) {
              var upd = reduce(_model, EditMsg(text));
              setState(() => _model = upd.model);
            },
          ),
          RaisedButton(
            child: Text("Create"),
            onPressed: _model.isBusy
                ? null
                : () async {
                    var upd = reduce(_model, PressMsg());
                    setState(() => _model = upd.model);

                    upd.effects.forEach((f) {
                      f((x) {
                        var upd2 = reduce(_model, x);
                        setState(() => _model = upd2.model);
                      });
                    });
                  },
          ),
          _model.isBusy ? CircularProgressIndicator() : Column(),
        ],
      ),
    );
  }
}
