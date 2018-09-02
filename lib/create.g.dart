// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new

class _$Model extends Model {
  @override
  final String url;
  @override
  final bool isBusy;

  factory _$Model([void updates(ModelBuilder b)]) =>
      (new ModelBuilder()..update(updates)).build();

  _$Model._({this.url, this.isBusy}) : super._() {
    if (url == null) throw new BuiltValueNullFieldError('Model', 'url');
    if (isBusy == null) throw new BuiltValueNullFieldError('Model', 'isBusy');
  }

  @override
  Model rebuild(void updates(ModelBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ModelBuilder toBuilder() => new ModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Model && url == other.url && isBusy == other.isBusy;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, url.hashCode), isBusy.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Model')
          ..add('url', url)
          ..add('isBusy', isBusy))
        .toString();
  }
}

class ModelBuilder implements Builder<Model, ModelBuilder> {
  _$Model _$v;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  bool _isBusy;
  bool get isBusy => _$this._isBusy;
  set isBusy(bool isBusy) => _$this._isBusy = isBusy;

  ModelBuilder();

  ModelBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _isBusy = _$v.isBusy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Model other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Model;
  }

  @override
  void update(void updates(ModelBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Model build() {
    final _$result = _$v ?? new _$Model._(url: url, isBusy: isBusy);
    replace(_$result);
    return _$result;
  }
}
