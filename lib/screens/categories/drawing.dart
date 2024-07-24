class DrawingData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const DrawingData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class DrawingCategory {
  static const List<DrawingData> drawingEntries = [
    DrawingData(
        "draw1",
        "Drawing",
        "Study of Human Proportions",
        "Leonardo da Vinci",
        "A detailed anatomical study from the Renaissance, showcasing Da Vinci’s deep understanding of human anatomy and proportion."),
    DrawingData(
        "draw2",
        "Drawing",
        "The School of Athens (Preliminary Study)",
        "Raphael",
        "A preliminary drawing for Raphael’s famous fresco, showcasing the detailed planning and composition for his depiction of classical philosophers. It reflects Raphael’s masterful use of line and form in preparing for one of the Renaissance’s iconic works."),
    DrawingData("draw3", "Drawing", "The Large Piece of Turf", "Albrecht Dürer",
        "A 1503 drawing that showcases Dürer’s incredible attention to detail and his skill in capturing the natural world with precision and beauty."),
    DrawingData("draw4", "Drawing", "Head of a Woman", "Leonardo da Vinci",
        "A drawing that highlights Da Vinci's mastery of capturing human emotion and anatomy with exquisite detail and sensitivity."),
    DrawingData("draw5", "Drawing", "Studies of Cats", "Leonardo da Vinci",
        "A series of drawings by Da Vinci that explore the anatomy and movement of cats, demonstrating his keen observational skills and interest in the natural world."),
    DrawingData(
        "draw6",
        "Drawing",
        "The Creation of Adam (Study)",
        "Michelangelo",
        "A preparatory drawing for the Sistine Chapel’s fresco, revealing Michelangelo’s detailed planning and understanding of human anatomy."),
    DrawingData("draw7", "Drawing", "Horse and Rider", "Leonardo da Vinci",
        "A study of a horse and rider that demonstrates Da Vinci’s fascination with dynamic movement and his skill in anatomical drawing."),
    DrawingData("draw8", "Drawing", "The Rhinoceros", "Albrecht Dürer",
        "A 1515 drawing based on a description and sketch of an Indian rhinoceros, showcasing Dürer's ability to create detailed and imaginative representations."),
    DrawingData("draw9", "Drawing", "Laocoon", "Peter Paul Rubens",
        "A detailed drawing by Rubens, depicting the dramatic scene of Laocoon and his sons, reflecting his skill in conveying intense emotion and movement."),
    DrawingData("draw10", "Drawing", "Two Studies of Hands", "Michelangelo",
        "Detailed studies of hands from the Renaissance master, illustrating his deep understanding of human anatomy and his skill in capturing the subtle nuances of gesture."),
  ];
}
