class RealismData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const RealismData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class RealismCategory {
  static const List<RealismData> realismEntries = [
    RealismData("rea1", "Realism", "The Stone Breakers", "Gustave Courbet",
        "A 1849 painting depicting laborers breaking stones, highlighting the everyday life and struggles of the working class with realistic detail."),
    RealismData("rea2", "Realism", "Olympia", "Édouard Manet",
        "A 1863 painting challenging traditional representations of the female nude, presenting a realistic and controversial depiction of a nude woman."),
    RealismData("rea3", "Realism", "The Gross Clinic", "Thomas Eakins",
        "A 1875 painting showing a surgical procedure in progress, noted for its realistic portrayal of medical practice and human anatomy."),
    RealismData("rea4", "Realism", "American Gothic", "Grant Wood",
        "A 1930 painting portraying a farmer and his daughter with realistic detail, symbolizing rural American life and values."),
    RealismData("rea5", "Realism", "Nighthawks", "Edward Hopper",
        "A 1942 painting capturing a nighttime scene in a diner, known for its realistic portrayal of isolation and urban life."),
    RealismData(
        "rea6",
        "Realism",
        "The Anatomy Lesson of Dr. Nicolaes Tulp",
        "Rembrandt van Rijn",
        "A 1632 painting depicting a public dissection, celebrated for its detailed and realistic depiction of anatomy and the human condition."),
    RealismData("rea7", "Realism", "The Milkmaid", "Johannes Vermeer",
        "A 1658-1660 painting depicting a maid pouring milk, showcasing Vermeer’s skill in capturing everyday domestic life with realistic detail."),
    RealismData("rea8", "Realism", "The Harvesters", "Pieter Bruegel the Elder",
        "A 1565 painting showing peasants harvesting crops, noted for its realistic depiction of rural life and seasonal labor."),
    RealismData(
        "rea9",
        "Realism",
        "Portrait of Adele Bloch-Bauer I",
        "Gustav Klimt",
        "A 1907 painting characterized by its realistic portrayal of a woman with intricate detail and use of gold leaf."),
    RealismData("rea10", "Realism", "The Arnolfini Portrait", "Jan van Eyck",
        "A 1434 painting featuring a detailed and realistic depiction of a couple, known for its meticulous attention to detail and use of symbolism."),
  ];
}
