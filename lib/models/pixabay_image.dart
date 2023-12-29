class PixabayImage {
  final String largeImageUrl;
  final String webformatUrl;
  final int views;
  final int downloads;
  final int favorites;
  final int likes;
  final int comments;
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final int webformatWidth;
  final int webformatHeight;
  final String fullHDURL;
  final String imageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int userId;
  final String user;
  final String userImageURL;

  PixabayImage({
    required this.largeImageUrl,
    required this.webformatUrl,
    this.views = 0,
    this.downloads = 0,
    this.favorites = 0,
    this.likes = 0,
    this.comments = 0,
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.fullHDURL,
    required this.imageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  factory PixabayImage.fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      largeImageUrl: json['largeImageURL'] ?? '',
      webformatUrl: json['webformatURL'] ?? '',
      views: json['views'] ?? 0,
      downloads: json['downloads'] ?? 0,
      favorites: json['favorites'] ?? 0,
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      id: json['id'] ?? 0,
      pageURL: json['pageURL'] ?? '',
      type: json['type'] ?? '',
      tags: json['tags'] ?? '',
      previewURL: json['previewURL'] ?? '',
      previewWidth: json['previewWidth'] ?? 0,
      previewHeight: json['previewHeight'] ?? 0,
      webformatWidth: json['webformatWidth'] ?? 0,
      webformatHeight: json['webformatHeight'] ?? 0,
      fullHDURL: json['fullHDURL'] ?? '',
      imageURL: json['imageURL'] ?? '',
      imageWidth: json['imageWidth'] ?? 0,
      imageHeight: json['imageHeight'] ?? 0,
      imageSize: json['imageSize'] ?? 0,
      userId: json['user_id'] ?? 0,
      user: json['user'] ?? '',
      userImageURL: json['userImageURL'] ?? '',
    );
  }
}
