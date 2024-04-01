class PunchModel {
  String status;
  String date;
  String punchInTime;
  String punchOutTime;
  String id;

  PunchModel( this.status,this.date,this.punchInTime,this.punchOutTime,this.id,);
}
class GetUserModel{
  String id;
  String name;
  String companyId;
  GetUserModel(this.id,this.name,this.companyId);
}