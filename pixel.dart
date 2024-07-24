class PixelData {
  final String imageName; // Now the first property
  final String category;
  final String name;
  final String artist;
  final String description;

  const PixelData(
      this.imageName, this.category, this.name, this.artist, this.description);
}

class PixelCategory {
  static const List<PixelData> pixelEntries = [
    PixelData("pixel1", "Pixel", "Sunrise Over Mountain", "Kazuha",
        "This particular pattern features a geometric design with a mountain range and a sun. The background is filled with light blue stitches, and the mountain range is stitched in shades of brown, dark gray, and black. The sun is a bright yellow circle at the top of the pattern."),
    PixelData("pixel2", "Pixel", "Contemplation", "Ryan",
        "This pixel art portrait depicts a man with brown skin and short, black hair. He has a thoughtful expression on his face and is looking upwards. He has a short beard and mustache, and he is wearing a gold earring in his left ear. His shirt is a dark blue and has a collar."),
    PixelData("pixel3", "Pixel", "Parasol", "Michy",
        "The woman is holding a green parasol in her right hand. She is wearing a long, white dress with a blue sash around her waist. Her hair is short and brown, and she has a peaceful expression on her face. The flowers in the field are stitched in a variety of colors, including pink, blue, yellow, and purple. The background is a light blue."),
    PixelData("pixel4", "Pixel", "Sunset by the Beach", "Anonymous",
        "This vibrant pixel art captures a serene sunset over the ocean, framed by two silhouetted palm trees. The scene features a gradient sky transitioning from a warm orange to soft pink, highlighting a bright yellow sun descending into the tranquil blue waters. The use of simple, pixelated blocks adds a nostalgic, retro feel to this picturesque depiction of tropical evening."),
    PixelData("pixel5", "Pixel", "Pixel Wave", "John",
        "This dynamic pixel art portrays a powerful wave, reminiscent of classic Japanese wave paintings but rendered in a minimalistic, pixelated style. The wave, composed of varying shades of blue and white, contrasts sharply against a dark background, emphasizing its movement and energy. The meticulous arrangement of pixel blocks creates a sense of motion and depth, capturing the essence of the ocean's raw power in a modern, digital format."),
    PixelData("pixel6", "Pixel", "GutsiGeng Pixel", "Guccio",
        "This captivating pixel art features a coiled snake, designed with an intriguing mix of olive green and bright orange segments, outlined with white accents. The snake's sinuous body forms a striking pattern against the dark background, enhancing its visual impact. The pixelated style lends a unique, digital charm to the depiction, while the careful color selection and arrangement bring a sense of depth and realism to the snake's scales. This piece beautifully combines simplicity with detailed artistry, creating a compelling representation of the snake in pixel form."),
    PixelData("pixel7", "Pixel", "KoiXel", "Mark",
        "This enchanting pixel art showcases two koi fish swimming gracefully in a serene pond, surrounded by lush green foliage. The vibrant reds and whites of the koi stand out against the swirling blue waters, creating a harmonious balance of colors. The pixelated style adds a unique texture to the scene, capturing the fluidity of the water and the elegance of the koi with a modern, digital twist. This piece beautifully portrays the tranquility and natural beauty of a traditional koi pond in a contemporary pixel art format."),
    PixelData("pixel8", "Pixel", "Liberty", "Garcia",
        "This artwork depicts a pixelated portrait of the Statue of Liberty, a well-known symbol of freedom and democracy. The use of pixels creates a blocky, retro aesthetic, referencing the early days of video games and computer graphics. The statue's blue and green colors contrast with the black background, making it the focal point of the image. This piece represents the enduring ideals of liberty translated into the modern digital age."),
    PixelData("pixel9", "Pixel", "MonaLisa", "Arnello",
        "This artwork is a pixel art rendition of the famous painting, the Mona Lisa, by Leonardo da Vinci. The artwork translates the subtle shading and details of the original portrait into a mosaic of colorful squares. The instantly recognizable smile and mysterious gaze of the Mona Lisa are preserved in this blocky, yet charming, reimagining of a timeless masterpiece."),
    PixelData("pixel10", "Pixel", "Anguished Pixels", "Stephen Mark",
        "This pixel art captures the raw emotion and existential dread of Edvard Munch’s iconic painting, 'The Scream.' The subject’s face, contorted in a silent scream, is rendered in a palette of dark blues, yellows, and greens. The swirling sky and bridge in the background are translated into blocky shapes, adding to the overall sense of anxiety and unease. Despite the limitations of the pixel format, this piece effectively conveys the intense emotions of the original work."),
  ];
}
