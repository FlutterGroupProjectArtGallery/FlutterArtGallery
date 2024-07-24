class GraphicData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const GraphicData(this.imageName, this.category, this.name, this.artist, this.description);
}

class GraphicCategory {
  static const List<GraphicData> graphicEntries = [
    GraphicData("gra1", "Graphic", "Helvetica", "Max Miedinger",
        "A typeface created in 1957 that has become synonymous with modern graphic design due to its clean, versatile appearance."),
    GraphicData("gra2", "Graphic", "The Great Wave off Kanagawa (Reinterpretation)", "Katsushika Hokusai (Graphic Interpretation)",
        "Hokusai’s iconic woodblock print has been adapted into various graphic forms, showcasing its enduring influence on visual culture."),
    GraphicData("gra3", "Graphic", "Polaroid", "Andy Warhol",
        "A series of graphic artworks by Warhol, utilizing the Polaroid camera to create iconic and repetitive images of celebrities."),
    GraphicData("gra4", "Graphic", "Obama Hope Poster", "Shepard Fairey",
        "A graphic design created for the 2008 Obama presidential campaign, known for its striking use of color and bold message."),
    GraphicData("gra5", "Graphic", "Bauhaus Typography", "Herbert Bayer",
        "A pioneering approach to typography from the Bauhaus school, emphasizing simplicity and functionality in graphic design."),
    GraphicData("gra6", "Graphic", "The Ten Faces of Innovation", "Tom Kelley",
        "A graphic representation of the key roles in innovation, visually depicting the concepts from Kelley’s influential book on design thinking."),
    GraphicData("gra7", "Graphic", "Guerilla Girls Posters", "Guerilla Girls",
        "A series of provocative posters created by this anonymous group of feminist artists, using graphic design to critique art world sexism."),
    GraphicData("gra8", "Graphic", "Beatrix Potter’s Illustrations", "Beatrix Potter",
        "Illustrations from Potter’s beloved children’s books, known for their charming and detailed graphic style."),
    GraphicData("gra9", "Graphic", "MTV Logo", "Frank Olinsky",
        "The iconic MTV logo designed in 1981, which became a symbol of the network’s cultural impact and graphic identity."),
    GraphicData("gra10", "Graphic", "Crate & Barrel Catalog Covers", "Various Designers",
        "Graphic designs for the Crate & Barrel catalog that feature clean, modern aesthetics reflecting contemporary design trends."),
  ];
}
