class FirebaseConfig{
  final String?  appName;
  final String momoConfigCollection;
  final String userCollection;
  final String propertyCollection;
  final String contractCollection;

  const FirebaseConfig({
    this.appName,
    required this.momoConfigCollection,
    required this.userCollection
    ,required this.propertyCollection
    ,required this.contractCollection
  });

}