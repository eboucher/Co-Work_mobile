class Location {
  String id;
  String name;
  String city;
  String avatar;
  bool wifi;
  bool mealTray;
  bool unlimitedDrinks;

  Location({this.id, this.name, this.city, this.avatar, this.wifi, this.mealTray,
      this.unlimitedDrinks});


  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      avatar: json['avatar'],
      wifi: json['wifi'],
      mealTray: json['mealTray'],
      unlimitedDrinks: json['unlimitedDrinks'],
    );
  }

  @override
  String toString() {
    return 'Location{id: $id, name: $name, city: $city, avatar: $avatar, wifi: $wifi, mealTray: $mealTray, unlimitedDrinks: $unlimitedDrinks}';
  }
}