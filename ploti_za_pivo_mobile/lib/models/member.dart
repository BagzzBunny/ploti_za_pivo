

class Member{
  late String name;
  late bool payed;
  late double amountPayed;

  Member(this.name,this.payed,this.amountPayed);

  Member.fromJson(Map<String,dynamic> json){
    name = json['name'];
    payed = json['payed'];
    amountPayed = json['amountPayed'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'payed' : payed,
      'amountPayed' : amountPayed,
    };
  }

  @override
  bool operator ==(Object other) => other is Member && other.name == name;

  @override
  int get hashCode => name.hashCode;

}