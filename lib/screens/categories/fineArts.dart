class FineArtData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const FineArtData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class FineArtCategory {
  static const List<FineArtData> fineEntries = [
    FineArtData(
        "farts1",
        "Fine Arts",
        "The Birth of Venus",
        "Sandro Botticelli",
        "A 1485 painting depicting the goddess Venus emerging from the sea. It’s celebrated for its beauty and influence on Renaissance art."),
    FineArtData("farts2", "Fine Arts", "Mona Lisa", "Leonardo da Vinci",
        "A 1503-1506 portrait known for its enigmatic expression and masterful use of sfumato, making it one of the most famous paintings in the world."),
    FineArtData("farts3", "Fine Arts", "Guernica", "Pablo Picasso",
        "A 1937 painting that portrays the horrors of war, created as a response to the bombing of Guernica during the Spanish Civil War."),
    FineArtData(
        "farts4",
        "Fine Arts",
        "The Persistence of Memory",
        "Salvador Dalí",
        "A 1931 surrealist painting featuring melting clocks, reflecting Dalí’s exploration of time and the subconscious."),
    FineArtData("farts5", "Fine Arts", "The School of Athens", "Raphael",
        "A fresco painted between 1509 and 1511, depicting classical philosophers and scholars in a grand architectural setting, reflecting the Renaissance ideals of knowledge and wisdom."),
    FineArtData("farts6", "Fine Arts", "Starry Night", "Vincent van Gogh",
        "A 1889 painting known for its swirling night sky and emotional intensity, capturing Van Gogh’s unique perspective on the world."),
    FineArtData("farts7", "Fine Arts", "The Last Supper", "Leonardo da Vinci",
        "A 1495-1498 fresco depicting the final meal of Jesus with his disciples. It’s renowned for its composition and emotional depth."),
    FineArtData("farts8", "Fine Arts", "The Kiss", "Gustav Klimt",
        "A 1907-1908 painting characterized by its decorative use of gold and intricate patterns, symbolizing love and intimacy."),
    FineArtData("farts9", "Fine Arts", "The Night Watch", "Rembrandt van Rijn",
        "A 1642 painting showcasing a militia company in action. It’s known for its dramatic use of light and shadow."),
    FineArtData("farts10", "Fine Arts", "American Gothic", "Grant Wood",
        "A 1930 painting that depicts a farmer and his daughter, known for its portrayal of rural American life and its iconic, stern expressions."),
  ];
}
