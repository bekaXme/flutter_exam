class OnboardingPageSecond {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final int order;

  OnboardingPageSecond({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.order,
  });

  factory OnboardingPageSecond.fromJson(Map<String, dynamic> json) {
    return OnboardingPageSecond(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      image: json['image'] as String,
      order: json['order'] as int,
    );
  }
}
