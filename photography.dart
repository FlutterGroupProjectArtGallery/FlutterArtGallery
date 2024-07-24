class PhotographyData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const PhotographyData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class PhotographyCategory {
  static const List<PhotographyData> photographyEntries = [
    PhotographyData("pho1", "Photography", "Migrant Mother", "Dorothea Lange",
        "A 1936 photograph capturing the hardships of the Great Depression through the face of a destitute mother. It remains an iconic image of social realism."),
    PhotographyData(
        "pho2",
        "Photography",
        "Lunch atop a Skyscraper",
        "Charles C. Ebbets",
        "A 1932 photograph showing construction workers casually eating lunch on a beam high above New York City, highlighting the bravery and camaraderie of early skyscraper workers."),
    PhotographyData("pho3", "Photography", "The Falling Man", "Richard Drew",
        "A 2001 photograph of a man falling from the World Trade Center during the 9/11 attacks, capturing the tragic moment with stark impact."),
    PhotographyData(
        "pho4",
        "Photography",
        "Raising the Flag on Iwo Jima",
        "Joe Rosenthal",
        "A 1945 photograph depicting U.S. Marines raising the American flag on Iwo Jima, a symbol of victory and patriotism during World War II."),
    PhotographyData("pho5", "Photography", "Afghan Girl", "Steve McCurry",
        "A 1984 photograph of a young Afghan refugee with piercing green eyes, known for its powerful depiction of human resilience and suffering."),
    PhotographyData("pho6", "Photography", "Bliss", "Charles O'Rear",
        "A 1996 photograph of rolling green hills with a blue sky, famously used as the default wallpaper for Windows XP."),
    PhotographyData("pho7", "Photography", "Dali Atomicus", "Philippe Halsman",
        "A 1948 photograph of Salvador Dalí with flying objects, capturing the surreal and dynamic essence of Dalí’s work."),
    PhotographyData(
        "pho8",
        "Photography",
        "Gandhi at the Spin Wheel",
        "Margaret Bourke-White",
        "A 1946 photograph showing Mahatma Gandhi spinning cotton, symbolizing his campaign for self-reliance and independence."),
    PhotographyData(
        "pho9",
        "Photography",
        "The Tetons and Snake River",
        "Ansel Adams",
        "A 1942 black-and-white photograph showcasing the grandeur of the American landscape with dramatic light and shadow."),
    PhotographyData(
        "pho10",
        "Photography",
        "A Man on the Moon",
        "Neil Armstrong",
        "A 1969 photograph capturing the first human steps on the lunar surface, representing one of humanity’s greatest achievements."),
  ];
}
