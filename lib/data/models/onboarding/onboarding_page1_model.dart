class OnboardingPageFirst {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final int order;

  OnboardingPageFirst({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.order,
  });

  factory OnboardingPageFirst.fromJson(Map<String, dynamic> json) {
    return OnboardingPageFirst(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      image: json['image'] as String,
      order: json['order'] as int,
    );
  }
}
