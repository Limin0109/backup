class OnBoarding {
  final String title;
  final String focus;
  final String subtitle;
  final String image;

  OnBoarding({
    required this.title,
    required this.focus,
    required this.subtitle,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'BioFuture helps you organize your',
    focus: 'bioinformatics information',
    subtitle:
        'A One-Stop-Center in bioinformatics where it\n gathers data, algorithms, codes and outputs.',
    image: 'lib/images/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'Organize your\n bioinformatics information is',
    focus: 'easy',
    subtitle:
        'BioFuture is designed for users to upload and\n download bioinformatics related information.',
    image: 'lib/images/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Organize your\n bioinformatics information is',
    focus: 'free from doubt',
    subtitle:
        'BioFuture is a platform for communication of\n researchers and professionals in the field of\n bioinformatics.',
    image: 'lib/images/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Join a supportive community',
    focus: '~ BioFuture ~',
    subtitle:
        'A place for you to forge new friendship,\n exchange knowledge,\n and share your ideas.',
    image: 'lib/images/onboarding_image_4.png',
  ),
];
