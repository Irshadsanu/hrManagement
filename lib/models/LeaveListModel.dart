class LeaveListModel{
  String id;
  String leaveType;
  String startDate;
  String endDate;
  String reason;
  String day;
  String status;
  String applydate;
  String dateFormat;
  String timeFormat;

  String description;
  String numberOfDays;

  LeaveListModel(this.id,this.leaveType,this.startDate,
      this.endDate,this.reason,this.day,this.status,
      this.applydate,this.description,this.dateFormat,this.timeFormat,this.numberOfDays);
}

class LeaveDateModel{

  String dateFormat;
  DateTime date;

  LeaveDateModel(this.dateFormat, this.date);
}
class AdminLeaveListModel{
  String id;
  String leaveType;
  String startDate;
  String endDate;
  String reason;
  String day;
  String status;
  String applydate;
  String dateFormat;
  String timeFormat;
  String empName;
  String numberOfDays;
  String description;
  String subcompany;
  AdminLeaveListModel(this.id,this.leaveType,this.startDate,
      this.endDate,this.reason,this.day,this.status,
      this.applydate,this.description,this.dateFormat,this.timeFormat,this.empName,this.numberOfDays,this.subcompany);
}
