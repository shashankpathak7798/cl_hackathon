import 'dart:convert';

import 'package:equatable/equatable.dart';

GetResponseForQueryResponseModel getResponseForQueryResponseModelFromJson(
        String str) =>
    GetResponseForQueryResponseModel.fromJson(json.decode(str));

String getResponseForQueryResponseModelToJson(
        GetResponseForQueryResponseModel data) =>
    json.encode(data.toJson());

class GetResponseForQueryResponseModel {
  final String? explaination;

  GetResponseForQueryResponseModel({
    this.explaination,
  });

  factory GetResponseForQueryResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetResponseForQueryResponseModel(
        explaination: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": explaination,
      };
}

class Result extends Equatable {
  final String? empId;
  final String? empName;
  final String? gender;
  final String? dateOfJoining;
  final String? designation;
  final String? task;
  final String? taskPriority;

  const Result({
    this.empId,
    this.empName,
    this.gender,
    this.dateOfJoining,
    this.designation,
    this.task,
    this.taskPriority,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        empId: json["empId"],
        empName: json["empName"],
        gender: json["gender"],
        dateOfJoining: json["dateOfJoining"],
        designation: json["designation"],
        task: json["task"],
        taskPriority: json["taskPriority"],
      );

  Map<String, dynamic> toJson() => {
        "empId": empId,
        "empName": empName,
        "gender": gender,
        "dateOfJoining": dateOfJoining,
        "designation": designation,
        "task": task,
        "taskPriority": taskPriority,
      };

  @override
  List<Object?> get props =>
      [empId, empName, gender, dateOfJoining, designation, task, taskPriority];
}
