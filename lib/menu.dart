import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:spectator/domain.dart';

// type Model = { list : Subscription list }
// type Msg = LoadedMsg of Subscription list | SelectedMsg of Subscription

class Model {
  final List<Subscription> list;
  Model(this.list);
  Model copy({List<Subscription> list}) => Model(list ?? this.list);
}

abstract class Msg {}

class LoadedMsg extends Msg {
  final List<Subscription> list;
  LoadedMsg(this.list);
}

class SelectedMsg extends Msg {
  final Subscription selected;
  SelectedMsg(this.selected);
}

Upd<Model, Msg> _init() {
  return Upd(
    Model([]),
    effects: Cmd.ofAsyncFunc(
      () => Services.getAllSubscriptions(),
      onSuccess: (r) => LoadedMsg(r),
    ),
  );
}

Upd<Model, Msg> _update(Msg msg, Model model) {
  if (msg is LoadedMsg) return Upd(model.copy(list: msg.list));
  return Upd(model);
}

Widget _view(BuildContext context, Dispatch<Msg> dispatch, Model model) {
  return ListView.builder(
    itemCount: model.list.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(model.list[index].title),
        onTap: () => Navigator.pop(context),
      );
    },
  );
}

Widget mkMenuWidget() => Program(_init, _update, _view).build();
