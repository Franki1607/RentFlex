class FirebaseConfig{
  final String?  appName;
  final String userCollection;
  final String propertyCollection;

  const FirebaseConfig({
    this.appName,
    required this.userCollection
    ,required this.propertyCollection
  });

}