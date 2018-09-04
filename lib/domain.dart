import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

class Subscription {
  final String title;
  final String url;

  const Subscription(this.title, this.url);
}

class Snapshot {
  final String title;
  final String preview;

  const Snapshot(this.title, this.preview);
}

class Services {
  static Future<void> signin() async {
    GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    var accout = await _googleSignIn.signIn();
    print(accout.email);
  }

  static Future<List<Subscription>> getAllSubscriptions() async => [
        Subscription("Subscription #1", "http://google.com/"),
        Subscription("Subscription #2", "http://google.com/"),
        Subscription("Subscription #3", "http://google.com/"),
        Subscription("Subscription #4", "http://google.com/"),
        Subscription("Subscription #5", "http://google.com/"),
      ];

  static Future<List<Snapshot>> getAllSnapshots() async => [
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

class Effects {
  static Future<void> createSubscription(String url) async {
    await Future.delayed(Duration(seconds: 3));
  }
}
