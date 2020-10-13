class Location {
  String id;
  String name;
  String avatar;
  bool wifi;
  bool mealTray;
  bool unlimitedDrinks;

  Location({this.id, this.name, this.avatar, this.wifi, this.mealTray,
      this.unlimitedDrinks});


  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['location']['id'],
      name: json['location']['name'],
      avatar: json['location']['avatar'],
      wifi: json['location']['wifi'],
      mealTray: json['location']['mealTray'],
      unlimitedDrinks: json['location']['unlimitedDrinks'],
    );
  }

  @override
  String toString() {
    return 'Location{id: $id, name: $name, avatar: $avatar, wifi: $wifi, mealTray: $mealTray, unlimitedDrinks: $unlimitedDrinks}';
  }
}