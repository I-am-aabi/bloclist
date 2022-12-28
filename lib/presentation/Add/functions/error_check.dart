String ErrorCheck(List data) {
  String field = '';
  if (data[0].isEmpty &&
      data[1].isEmpty &&
      data[2].isEmpty &&
      data[3].isEmpty &&
      data[4]!.isEmpty) {
    field = 'Every field';
    return field;
  } else if (data[0].isEmpty) {
    field = 'Name';
     return field;
  } else if (data[1].isEmpty) {
    field = 'Age';
   return field;
  } else if (data[2].isEmpty) {
    field = 'Place';
   return field;
  } else if (data[3].isEmpty) {
    field = 'Phone number';
     return field;
  } else if (data[4] == null) {
    field = 'Image';
     return field;
  }
  else{
    return 'success';
  }
}
