class TrendingItems{
  final String itemPhoto;
  final String itemTitle;
  final String itemDescription;
  final String itemTimeRequired;
  final String itemRating;
  final String cookUserName;
  final String cookPhoto;
  final String userFirstName;
  final String userLastName;


  TrendingItems({
    required this.itemPhoto,
    required this.itemTitle,
    required this.itemDescription,
    required this.itemTimeRequired,
    required this.itemRating,
    required this.cookUserName,
    required this.cookPhoto,
    required this.userFirstName,
    required this.userLastName
  });

  factory TrendingItems.fromJson(Map<String, dynamic> json){
    return TrendingItems(
      itemPhoto: json['photo'],
      itemTitle: json['title'],
      itemDescription: json['description'],
      itemTimeRequired: json['timeRequired'],
      itemRating: json['rating'],
      cookUserName: json['user']['username'],
      cookPhoto: json['user']['profilePhoto'],
      userFirstName: json['user']['firstName'],
      userLastName: json['user']['lastName'],
    );
    }
}