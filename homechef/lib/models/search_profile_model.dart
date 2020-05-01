class SearchProfile {
  String saveDiet;
  List<String> allergies;

 SearchProfile({
   this.saveDiet = 'Vegan',
   this.allergies
 });

  String get getSaveDiet => saveDiet;

}