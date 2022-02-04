class CuriumLife {

  List<ImageInfo> listOFImageInfo = [ImageInfo("img_01",2,2,2),ImageInfo("img_02",2,1,1),];

  List<String> c1 = [
    "Unable to identify 2 structures or only 1 structure seen",
    "2 structures seen but some overlap",
    "2 structures clearly seen entering GB"
  ];
  List<String> c2 = [
    "Fibrofatty tissue in triangle obscures view of structures",
    "Some obscurement of triangle",
    "Hepatocystic triangle cleared of all fibrofatty tissue and other structures except the cystic duct and cystic artery"
  ];
  List<String> c3 = [
    "Not visible",
    "Visible but overlapped by structures or not clearly shown",
    "Bottom 1/3 of gallbladder is clearly demonstrated and cystic plate is shown"
  ];

  ImageInfo getImageInfo(String name) => listOFImageInfo[0];
}

class ImageInfo {
  String imageName;
  int c1Score;
  int c2Score;
  int c3Score;

  ImageInfo(this.imageName, this.c1Score, this.c2Score, this.c3Score);
}
