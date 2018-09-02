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
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
      Snapshot("joel27, art, красивые картинки",
          "http://img0.joyreactor.cc/pics/post/-4004930.jpeg"),
    ];
  }
}

class Effects {
  static Future<void> createSubscription(String url) async {
    await Future.delayed(Duration(seconds: 3));
  }
}
