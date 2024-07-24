class PaintingData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const PaintingData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class PaintingCategory {
  static const List<PaintingData> paintingEntries = [
    PaintingData("pai1", "Painting", "The Starry Night", "Vincent van Gogh",
        "A 1889 painting depicting a swirling night sky over a quiet town, renowned for its emotional intensity and bold use of color."),
    PaintingData(
        "pai2",
        "Painting",
        "The Persistence of Memory",
        "Salvador Dalí",
        "A 1931 surrealist masterpiece featuring melting clocks in a dreamlike landscape, exploring the fluidity of time."),
    PaintingData(
        "pai3",
        "Painting",
        "Girl with a Pearl Earring",
        "Johannes Vermeer",
        "A 1665 painting that captures the mysterious beauty of a young girl with a pearl earring, known for its exquisite use of light."),
    PaintingData("pai4", "Painting", "The Night Watch", "Rembrandt van Rijn",
        "A 1642 painting depicting a militia company in action, celebrated for its dynamic composition and masterful use of light and shadow."),
    PaintingData("pai5", "Painting", "The Birth of Venus", "Sandro Botticelli",
        "A 1485 painting showing the goddess Venus emerging from the sea, known for its beauty and mythological significance."),
    PaintingData("pai6", "Painting", "American Gothic", "Grant Wood",
        "A 1930 painting depicting a farmer and his daughter, recognized for its portrayal of rural American life and its iconic, austere figures."),
    PaintingData("pai7", "Painting", "The School of Athens", "Raphael",
        "A fresco from 1509-1511 depicting classical philosophers in an architectural setting, reflecting Renaissance ideals of knowledge and wisdom."),
    PaintingData("pai8", "Painting", "The Kiss", "Gustav Klimt",
        "A 1907-1908 painting characterized by its ornate use of gold and intricate patterns, symbolizing love and intimacy."),
    PaintingData(
        "pai9",
        "Painting",
        "Les Demoiselles d'Avignon",
        "Pablo Picasso",
        "A 1907 painting that marks a significant departure from traditional perspective and form, introducing Cubism to the art world."),
    PaintingData("pai10", "Painting", "Water Lilies Series", "Claude Monet",
        "A series of paintings depicting Monet’s garden pond, showcasing his interest in light, color, and reflection."),
  ];
}
