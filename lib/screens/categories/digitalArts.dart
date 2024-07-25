class DigitalArtData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const DigitalArtData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class DigitalArtCategory {
  static const List<DigitalArtData> digitalEntries = [
    DigitalArtData(
        "darts1",
        "Digital Arts",
        "The Garden of Earthly Delights",
        "Hieronymus Bosch (Digital Art)",
        "A digitally restored version of Bosch’s 15th-century triptych, highlighting the advancements in preserving and enhancing classic works through digital technology."),
    DigitalArtData(
        "darts2",
        "Digital Arts",
        "The Irony of Negro",
        "Kara Walker (Digital Format)",
        "A piece from Walker’s exploration of race and identity, adapted into digital media for modern exhibition formats."),
    DigitalArtData(
        "darts3",
        "Digital Arts",
        "Virtual Reality (VR) Art by KAWS",
        "KAWS",
        "KAWS has created interactive VR experiences that allow viewers to engage with his signature characters in immersive environments."),
    DigitalArtData("darts4", "Digital Arts", "Deep Dream", "Google",
        "An AI-generated artwork that utilizes neural networks to create surreal, dream-like images from existing photographs."),
    DigitalArtData(
        "darts5",
        "Digital Arts",
        "Everydays: The First 5000 Days",
        "Beeple (Mike Winkelmann)",
        "A groundbreaking 2021 NFT artwork consisting of a collage of daily digital art pieces created over 13 years. It sold for 69 million dollors, highlighting the rise of digital art in the blockchain era."),
    DigitalArtData(
        "darts6",
        "Digital Arts",
        "The Matrix Resurrections",
        "Lana Wachowski",
        "Concept art for the film that blends futuristic visuals with cutting-edge digital techniques to create its unique aesthetic."),
    DigitalArtData("darts7", "Digital Arts", "FRAMED", "Refik Anadol",
        "An installation that uses data and algorithms to generate real-time, ever-changing visual art, reflecting the fusion of technology and creativity."),
    DigitalArtData(
        "darts8",
        "Digital Arts",
        "AI-Generated Art",
        "Various Artists",
        "A collection of artworks created using artificial intelligence algorithms, exploring new possibilities in the realm of creativity."),
    DigitalArtData(
        "darts9",
        "Digital Arts",
        "The Big Bang of Data",
        "Manfred Mohr",
        "An algorithmic art piece that generates complex, geometric patterns, showcasing the intersection of mathematics and visual art."),
    DigitalArtData("darts10", "Digital Arts", "Rebirth", "Casey Reas",
        "A generative art piece created using custom algorithms to produce unique visual patterns, reflecting the capabilities of digital tools in art creation."),
  ];
}
