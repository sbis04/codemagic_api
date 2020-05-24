// To parse this JSON data, do
//
//     final applications = applicationsFromJson(jsonString);

import 'dart:convert';

CodemagicInfo applicationsFromJson(dynamic str) => CodemagicInfo.fromJson(str);

String applicationsToJson(CodemagicInfo data) => json.encode(data.toJson());

class CodemagicInfo {
  List<Application> applications;
  List<Build> builds;

  CodemagicInfo({
    this.applications,
    this.builds,
  });

  factory CodemagicInfo.fromJson(Map<String, dynamic> json) => CodemagicInfo(
        applications: List<Application>.from(
            json["applications"].map((x) => Application.fromJson(x))),
        builds: List<Build>.from(json["builds"].map((x) => Build.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "applications": List<dynamic>.from(applications.map((x) => x.toJson())),
        "builds": List<dynamic>.from(builds.map((x) => x.toJson())),
      };
}

class Application {
  String id;
  String appName;
  List<String> branches;
  String iconUrl;
  String lastBuildId;
  Repository repository;
  List<String> workflowIds;
  Map workflows;

  Application({
    this.id,
    this.appName,
    this.branches,
    this.iconUrl,
    this.lastBuildId,
    this.repository,
    this.workflowIds,
    this.workflows,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["_id"],
        appName: json["appName"],
        branches: List<String>.from(json["branches"].map((x) => x)),
        iconUrl: json["iconUrl"],
        lastBuildId: json["lastBuildId"],
        repository: Repository.fromJson(json["repository"]),
        workflowIds: List<String>.from(json["workflowIds"].map((x) => x)),
        workflows: json["workflows"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appName": appName,
        "branches": List<dynamic>.from(branches.map((x) => x)),
        "iconUrl": iconUrl,
        "lastBuildId": lastBuildId,
        "repository": repository.toJson(),
        "workflowIds": List<dynamic>.from(workflowIds.map((x) => x)),
        "workflows": workflows,
      };
}

class Repository {
  String htmlUrl;

  Repository({
    this.htmlUrl,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        htmlUrl: json["htmlUrl"],
      );

  Map<String, dynamic> toJson() => {
        "htmlUrl": htmlUrl,
      };
}

class Build {
  String id;
  List<Map> buildActions;
  Map config;
  String finishedAt;
  int index;
  String instanceType;
  String startedAt;
  String status;
  String workflowId;

  Build({
    this.id,
    this.buildActions,
    this.config,
    this.finishedAt,
    this.index,
    this.instanceType,
    this.startedAt,
    this.status,
    this.workflowId,
  });

  factory Build.fromJson(Map<String, dynamic> json) => Build(
        id: json["_id"],
        buildActions: List<Map>.from(json["buildActions"]),
        config: json["config"],
        finishedAt: json["finishedAt"],
        index: json["index"],
        instanceType: json["instanceType"],
        startedAt: json["startedAt"],
        status: json["status"],
        workflowId: json["workflowId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "buildActions": List<Map>.from(buildActions),
        "config": config,
        "finishedAt": finishedAt,
        "index": index,
        "instanceType": instanceType,
        "startedAt": startedAt,
        "status": status,
        "workflowId": workflowId,
      };
}
