import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class Subscription {
  final String title;
  final String url;

  const Subscription(this.title, this.url);
}

class Snapshot {
  final int id;
  final String title;
  final String preview;
  final String web;
  final String diff;

  const Snapshot(this.id, this.title, this.preview, this.web, this.diff);
}

class Services {
  static Future<void> createSubscription(String url) async {
    await Future.delayed(Duration(seconds: 3));
  }

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
        Snapshot(
            0,
            "joel27, art, красивые картинки",
            "http://img0.joyreactor.cc/pics/post/-4004930.jpeg",
            "https://google.com/",
            "https://ya.ru/"),
        Snapshot(
            1,
            "joel27, art, красивые картинки",
            "http://img0.joyreactor.cc/pics/post/-4004930.jpeg",
            "https://ru.wikipedia.org/wiki/Битва_при_Арсуфе",
            "https://ru.wikipedia.org/wiki/Битва_при_Таутоне"),
        Snapshot(
            2,
            "joel27, art, красивые картинки",
            "http://img0.joyreactor.cc/pics/post/-4004930.jpeg",
            "https://ru.wikipedia.org/wiki/Битва_при_Арсуфе",
            "https://ru.wikipedia.org/wiki/Битва_при_Таутоне"),
      ];

  static Future<Snapshot> getSnapshot(int id) async =>
      (await getAllSnapshots()).firstWhere((x) => x.id == id);
}
