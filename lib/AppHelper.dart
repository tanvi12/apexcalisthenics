bool compareArrays(List arrayTags, List tags) {
  bool match = true;
  for(int i=0;i<tags.length;i++){
    bool allMatch = false;
    for(int j=0;j<arrayTags.length;j++){
      if(tags[i]==arrayTags[j]){
        allMatch = true;
        break;
      }

    }
    if(!allMatch){
      match = false;
      break;
    }
  }
  return match;
}