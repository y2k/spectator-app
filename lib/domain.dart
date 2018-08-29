import 'dart:async';

class Subscription {
  final String title;
  final String url;
  final List<Snapshot> snapthos;

  const Subscription(this.title, this.url, this.snapthos);
}

class Snapshot {
  final String title;
  final String preview;

  const Snapshot(this.title, this.preview);
}

class Services {
  static Future<List<Snapshot>> foo() async {
    return [
      Snapshot("A1", "B1"),
      Snapshot("A2", "B2"),
      Snapshot("A3", "B3"),
    ];
  }
}
