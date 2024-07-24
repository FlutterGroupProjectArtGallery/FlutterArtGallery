class ContemporaryArtData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const ContemporaryArtData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class ContemporaryArtCategory {
  static const List<ContemporaryArtData> artEntries = [
    ContemporaryArtData(
        "cart1",
        "Contemporary Arts",
        "The Physical Impossibility of Death in the Mind of Someone Living",
        "Damien Hirst",
        "A 1991 installation featuring a shark suspended in formaldehyde. It explores themes of mortality and the human condition."),
    ContemporaryArtData(
        "cart2",
        "Contemporary Arts",
        "Balloon Dog (Orange)",
        "Jeff Koons",
        "A 1994-2000 sculpture that exemplifies Koons' fascination with pop culture and consumerism. Its shiny, balloon-like form has become iconic in contemporary art."),
    ContemporaryArtData(
        "cart3",
        "Contemporary Arts",
        "Untitled (L.A. Women)",
        "David Hockney",
        "Part of a series from the 1980s, this painting reflects Hockney’s interest in depicting modern life and relationships through vibrant colors and composition."),
    ContemporaryArtData(
        "cart4",
        "Contemporary Arts",
        "Girl with a Pearl Earring (Reinterpretation)",
        "Johannes Vermeer (Contemporary Take)",
        "This iconic 17th-century painting has been reinterpreted by many contemporary artists, reflecting ongoing fascination with Vermeer’s work."),
    ContemporaryArtData(
        "cart5",
        "Contemporary Arts",
        "For the Love of God",
        "Damien Hirst",
        "A 2007 artwork featuring a platinum skull encrusted with diamonds. It addresses themes of mortality and luxury."),
    ContemporaryArtData(
        "cart6",
        "Contemporary Arts",
        "I Am Not a Joke",
        "Jean-Michel Basquiat",
        "A painting by Basquiat that combines graffiti influences with abstract and symbolic elements, showcasing his distinctive style."),
    ContemporaryArtData(
        "cart7",
        "Contemporary Arts",
        "The Gates",
        "Christo and Jeanne-Claude",
        "A 2005 installation in Central Park featuring 7,503 gates draped in orange fabric. It transformed the landscape and engaged viewers in a unique experience."),
    ContemporaryArtData(
        "cart8",
        "Contemporary Arts",
        "Composition VIII",
        "Wassily Kandinsky",
        "A 1923 painting that explores abstract forms and colors, reflecting Kandinsky’s contributions to the development of modern abstract art."),
    ContemporaryArtData(
        "cart9",
        "Contemporary Arts",
        "The Persistence of Memory (Contemporary Reinterpretation)",
        "Salvador Dalí (Reinterpretation)",
        "Dalí’s iconic 1931 surrealist painting has been revisited and reinterpreted by various contemporary artists exploring themes of time and perception."),
    ContemporaryArtData(
        "cart10",
        "Contemporary Arts",
        "Untitled (Black)",
        "Mark Rothko",
        "A painting from Rothko’s later years, featuring his signature color field style. It reflects his exploration of emotional depth through color and form."),
  ];
}
