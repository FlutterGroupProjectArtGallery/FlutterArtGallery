class Category {
  final List<String> categories = [
    "Animation",
    "Contemporary Arts",
    "Digital Arts",
    "Drawing",
    "Fine Arts",
    "Graphic",
    "Painting",
    "Photography",
    "Pixel",
    "Realism",
  ];

  List<List<String>> getCategoryPairs() {
    List<List<String>> pairs = [];
    for (int i = 0; i < categories.length; i += 2) {
      pairs.add(categories.sublist(
          i, i + 2 > categories.length ? categories.length : i + 2));
    }
    return pairs;
  }
}
