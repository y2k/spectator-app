import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:spectator/domain.dart';

class Model {}

abstract class Msg {}

class SignInMsg extends Msg {}

Upd<Model, Msg> _init() => Upd(Model());

Upd<Model, Msg> _update(Msg msg, Model model) {
  if (msg is SignInMsg)
    return Upd(model, effects: Cmd.ofAsyncAction(Services.signin));
  return Upd(Model());
}

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return Scaffold(
    appBar: AppBar(title: Text("SignIn")),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: RaisedButton(
          child: Text("SignIn via Google"),
          onPressed: () => dispatch(SignInMsg()),
        ),
      ),
    ),
  );
}

Widget signInWidget() =>
    Program<Model, Msg, void>(_init, _update, _view).build();
