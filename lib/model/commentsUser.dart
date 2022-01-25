class Comment {
  String authorName;
  String authorImageUrl;
  String text;

  Comment({
    required this.authorName,
    required this.authorImageUrl,
    required this.text,
  });
}

final List<Comment> comments = [
  Comment(
    authorName: 'Albedo',
    authorImageUrl: 'lib/images/Albedo.jpg',
    text: 'Nice Paper',
  ),
  Comment(
    authorName: 'ZhongLi',
    authorImageUrl: 'lib/images/ZhongLi.png',
    text: 'You are a LIFE SAVER!',
  ),
  Comment(
    authorName: 'Tartaglia',
    authorImageUrl: 'lib/images/Tartaglia.jpeg',
    text: 'Nice job bro',
  ),
];
