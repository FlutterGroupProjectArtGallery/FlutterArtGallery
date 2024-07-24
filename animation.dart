class AnimationData {
  final String imageName; // Now the first property
  final String name;
  final String artist;
  final String description;

  const AnimationData(this.imageName, this.name, this.artist, this.description);
}

class AnimationCategory {
  static const List<AnimationData> animationEntries = [
    AnimationData("ani1", "Steamboat Willie", "Walt Disney",
        "A pioneering animated short film from 1928 featuring Mickey Mouse. It was one of the first synchronized sound cartoons and marked Disney’s rise to prominence in animation."),
    AnimationData("ani2", "Toy Story", "John Lasseter",
        "Released in 1995, it was the first feature-length film entirely created using CGI. The film revolutionized animation and storytelling in cinema."),
    AnimationData("ani3", "Spirited Away", "Hayao Miyazaki",
        "A 2001 Japanese animated fantasy film that tells the story of a young girl navigating a world of spirits and gods. It won the Academy Award for Best Animated Feature."),
    AnimationData("ani4", "Akira", "Katsuhiro Otomo",
        "A groundbreaking 1988 Japanese animated film known for its detailed animation and complex dystopian narrative. It has been highly influential in both anime and international cinema."),
    AnimationData("ani5", "The Lion King", "Roger Allers and Rob Minkoff",
        "A 1994 Disney classic that combines a powerful story with memorable music and stunning animation. It remains one of the most beloved animated films of all time."),
    AnimationData("ani6", "My Neighbor Totoro", "Hayao Miyazaki",
        "A 1988 Japanese animated film that follows the magical adventures of two young sisters who discover a friendly forest spirit. It’s celebrated for its charming animation and heartwarming story."),
    AnimationData("ani7", "Finding Nemo", "Andrew Stanton",
        "This 2003 Pixar film showcases stunning underwater visuals and a touching story about a clownfish’s journey to find his son."),
    AnimationData("ani8", "WALL-E", "Andrew Stanton",
        "A 2008 Pixar film featuring a lonely robot in a post-apocalyptic world. The film is noted for its minimal dialogue and powerful environmental message."),
    AnimationData("ani9", "The Iron Giant", "Brad Bird",
        "A 1999 animated film that tells the story of a young boy and his friendship with a giant robot. It’s praised for its emotional depth and animation quality."),
    AnimationData("ani10", "Up", "Pete Docter",
        "A 2009 Pixar film that tells the story of an elderly man who fulfills his lifelong dream of adventure with a house lifted by balloons. The film is celebrated for its emotional depth and imaginative animation."),
  ];
}
