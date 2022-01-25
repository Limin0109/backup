class Tutorial {
  final String title;
  final String focus;
  final String subtitle;
  final String image;

  Tutorial({
    required this.title,
    required this.focus,
    required this.subtitle,
    required this.image,
  });
}

List<Tutorial> tutorialContents = [
  Tutorial(
    title: 'Connect with the Professionals',
    focus: 'bioinformatics information',
    subtitle:
        'Inquire informations, exchange and forge\n new collaborations in our private chat.',
    image: 'lib/images/Tutorial_Chat.gif',
  ),
  Tutorial(
    title: 'Customize your Profile',
    focus: 'easy',
    subtitle:
        'Customize your profile makes it easier\n for others to recognize and find you.',
    image: 'lib/images/Tutorial_Profile.gif',
  ),
  Tutorial(
    title: 'Upload your\n bioinformatics research paper',
    focus: 'fast and easy',
    subtitle:
        'Obtain of recommendation & review\n regarding the article\'s suitability for publication.',
    image: 'lib/images/Tutorial_UploadResearch.gif',
  ),
  /*
  Tutorial(
    title: 'Join a supportive community',
    focus: '~ BioFuture ~',
    subtitle: 'A place for you to forge new friendship,\n exchange knowledge,\n and share your ideas.',
    image: 'assets/onboarding_image_4.png',
  ),
  */
];
