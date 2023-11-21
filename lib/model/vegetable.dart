class Vegetable {
  String name;
  String imgPath;
  List<Season> seasons;

  Vegetable({required this.name, required this.imgPath, required this.seasons});
}

enum Season{spring, summer, autumn, winter}

List<Vegetable> vegetables = [
  Vegetable(name: "Artischocken", imgPath: "assets/vegetables/artischocken.png", seasons: [Season.summer]),
  Vegetable(name: "Aubergine", imgPath: "assets/vegetables/aubergine.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Blumenkohl", imgPath: "assets/vegetables/blumenkohl.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Bohnen", imgPath: "assets/vegetables/bohnen.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Brokkoli", imgPath: "assets/vegetables/brokkoli.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Chicoree", imgPath: "assets/vegetables/chicoree.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Chinakohl", imgPath: "assets/vegetables/chinakohl.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Dicke Bohnen", imgPath: "assets/vegetables/dicke_bohnen.png", seasons: [Season.summer]),
  Vegetable(name: "Eisbergsalat", imgPath: "assets/vegetables/eisbergsalat.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Endiviensalat", imgPath: "assets/vegetables/endiviensalat.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Erbsen/Zuckererbsen", imgPath: "assets/vegetables/zuckererbsen.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Feldsalat/Rapunzel", imgPath: "assets/vegetables/feldsalat.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Gemüsefenchel", imgPath: "assets/vegetables/gemuese_fenchel.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Gemüsepaprika", imgPath: "assets/vegetables/paprika.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Grünkohl", imgPath: "assets/vegetables/gruenkohl.png", seasons: [Season.autumn, Season.winter]),
  Vegetable(name: "Gurke", imgPath: "assets/vegetables/gurke.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Kohlrabi", imgPath: "assets/vegetables/kohlrabi.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Kopfsalat", imgPath: "assets/vegetables/kopfsalat.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Kürbis", imgPath: "assets/vegetables/kuerbis.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Lollo Rossa/L. Bionda", imgPath: "assets/vegetables/lollo_rossa.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Mangold", imgPath: "assets/vegetables/mangold.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Möhren", imgPath: "assets/vegetables/moehren.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Porree/Lauch", imgPath: "assets/vegetables/porree.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Radicchio", imgPath: "assets/vegetables/radicchio.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Radieschen", imgPath: "assets/vegetables/radieschen.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Rettich", imgPath: "assets/vegetables/rettich.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Rhabarber", imgPath: "assets/vegetables/rhabarber.png", seasons: [Season.spring, Season.summer]),
  Vegetable(name: "Rosenkohl", imgPath: "assets/vegetables/rosenkohl.png", seasons: [Season.autumn, Season.winter]),
  Vegetable(name: "Rote Beete/Rote Rüben", imgPath: "assets/vegetables/rote_beete.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Rotkohl", imgPath: "assets/vegetables/rotkohl.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Rucula", imgPath: "assets/vegetables/ruculalol.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Schwarzwurzel", imgPath: "assets/vegetables/schwarzwurzel.png", seasons: [Season.spring, Season.autumn, Season.winter]),
  Vegetable(name: "Spargel", imgPath: "assets/vegetables/spargel.png", seasons: [Season.spring, Season.summer]),
  Vegetable(name: "Spinat", imgPath: "assets/vegetables/spinat.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Spitzkohl", imgPath: "assets/vegetables/spitzkohl.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Stangen-/Bleichsellerie", imgPath: "assets/vegetables/stangensellerie.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Tomate", imgPath: "assets/vegetables/tomate.png", seasons: [Season.spring, Season.summer, Season.autumn]),
  Vegetable(name: "Weißkohl", imgPath: "assets/vegetables/weisskohl.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
  Vegetable(name: "Zucchini", imgPath: "assets/vegetables/zucchini.png", seasons: [Season.summer, Season.autumn]),
  Vegetable(name: "Zwiebel", imgPath: "assets/vegetables/zwiebel.png", seasons: [Season.spring, Season.summer, Season.autumn, Season.winter]),
];