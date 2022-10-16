class Book {
  int year;
  int month;
  String title, lowT;
  int sum;
  float TSLA;
  float ran1, ran2;
  boolean show;
  boolean fit=false;
  Book(int year, int month, String title, int sum, float TSLA, float ran1, float ran2, boolean show) {
    this.year=year;
    this.month=month;
    this.title=title;
    this.sum=sum;
    this.TSLA=TSLA;
    this.ran1=ran1;
    this.ran2=ran2;
    this.show=show;
    this.lowT =title.toLowerCase();
  }

  void check() {
    if (searchT.length()==0) {
      fit=true;
    } else {
      for (int i=0; i<lowT.length(); i++) {
        if (i<searchT.length()) {
          char t = lowT.charAt(i);
          char s = searchT.charAt(i);
          if (t==s) {
            fit=true;
          } else {
            fit=false;
            i=lowT.length();
          }
        }
      }
    }
  }
}
