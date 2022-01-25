class History {
  String? title;
  String? desc;

  History();

  Map<String, dynamic> toJson() => {'title': title, 'desc': desc};

  History.fromSnapshot(snapshot)
      : title = snapshot.data()['title'],
        desc = snapshot.data()['desc'];
}
