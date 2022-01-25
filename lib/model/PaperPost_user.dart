class Post {
  String authorName;
  String authorImageUrl;
  String timeAgo;
  String imageUrl;

  Post({
    required this.authorName,
    required this.authorImageUrl,
    required this.timeAgo,
    required this.imageUrl,
  });
}

final List<Post> posts = [
  Post(
    authorName: 'Yae Sakura',
    authorImageUrl: 'lib/images/YaeChan.jpg',
    timeAgo: '10 mins',
    imageUrl: 'lib/images/YaeChanPDF.png',
  ),
  Post(
    authorName: 'Bojji',
    authorImageUrl: 'lib/images/Bocchi.jpg',
    timeAgo: '20 mins',
    imageUrl: 'lib/images/BocchiPDF.png',
  ),
  Post(
    authorName: 'Diluc Ragnvindr',
    authorImageUrl: 'lib/images/Diluc.jpg',
    timeAgo: '1 hour',
    imageUrl: 'lib/images/DilucPDF.png',
  ),
];
