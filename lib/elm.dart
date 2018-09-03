import 'package:dartea/dartea.dart';

abstract class StateHolder<T> {
  T getState();
  void updateState(T value);
}

abstract class ElmPage<Model, Msg> {
  Upd<Model, Msg> init();
  Upd<Model, Msg> reduce(Model model, Msg event);
}

class ElmManager<Model, Msg> {
  final ElmPage<Model, Msg> page;
  final StateHolder<Model> state;

  ElmManager(this.page, this.state) {
    var upd = page.init();
    state.updateState(upd.model);
    for (var eff in upd.effects) eff((msg2) => dispatch(msg2));
  }

  void dispatch(Msg msg) {
    var upd = page.reduce(state.getState(), msg);
    state.updateState(upd.model);
    for (var eff in upd.effects) eff((msg2) => dispatch(msg2));
  }
}
