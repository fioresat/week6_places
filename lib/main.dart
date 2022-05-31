import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Set<String> places = {
  'Осака',
  'Киото',
  'Токио',
};

Set<String> descript = {
  'Третий по населению город Японии, который находится в южной части острова Хонсю, близ устья реки Йодо в заливе Осака. Центр одноимённой префектуры.',
  'Расположен в центральной части острова Хонсю, в центре региона Кансай, в юго-западной части префектуры Киото. Город является административным центром этой префектуры. Один из ведущих городов региона Кансай и городского района Осака — Кобе — Киото. ',
  'Cтолица и крупнейший город Японии, её административный, финансовый, промышленный и политический центр. Крупнейшая городская экономика мира. Расположен в юго-восточной части острова Хонсю, на равнине Канто в бухте Токийского залива Тихого океана.',
};

Set<String> photos = {
  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Nishinomaru_Garden_Osaka_Castle06s4s4272.jpg/1280px-Nishinomaru_Garden_Osaka_Castle06s4s4272.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/3/32/Randen_cherry_blossom.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Tokyo_Tower_at_night_8.JPG/1280px-Tokyo_Tower_at_night_8.JPG",
};

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Путешествие по Японии';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          backgroundColor: Colors.green,
        ),
        body: const LHero(),
      ),
    );
  }
}

class LHero extends StatefulWidget {
  const LHero({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _LHeroState createState() => _LHeroState();
}

class _LHeroState extends State<LHero> {
  // int _selectedIndex = 0;

  Widget _bigPicture(int selectedIndex) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(photos.elementAt(selectedIndex)),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _smallPicture(int selectedIndex) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(photos.elementAt(selectedIndex)),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 10,
              child: ListTile(
                leading: GestureDetector(
                    child: Hero(
                      tag: index.toString(),
                      child: _smallPicture(index),
                    ),
                    onTap: () {
                      _fullImagePage(context, index);
                      timeDilation = 5.0;
                    }),
                title: Text(places.elementAt(index)),
                //subtitle: Text(descript.elementAt(index)),
              ));
        });
  }

  void _fullImagePage(BuildContext context, int tag) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: AppBar(
          title: Text(places.elementAt(tag)),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  descript.elementAt(tag),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: tag,
                  child: _bigPicture(tag),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
