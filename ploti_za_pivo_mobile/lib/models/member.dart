

class Member{
  late String name;
  late bool payed;
  late double amountPayed;

  Member(this.name,this.payed,this.amountPayed);

  @override
  bool operator ==(Object other) => other is Member && other.name == name;

  @override
  int get hashCode => name.hashCode;

}