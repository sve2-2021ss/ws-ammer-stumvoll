// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum State: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case upcoming
  case running
  case finished
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "UPCOMING": self = .upcoming
      case "RUNNING": self = .running
      case "FINISHED": self = .finished
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .upcoming: return "UPCOMING"
      case .running: return "RUNNING"
      case .finished: return "FINISHED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: State, rhs: State) -> Bool {
    switch (lhs, rhs) {
      case (.upcoming, .upcoming): return true
      case (.running, .running): return true
      case (.finished, .finished): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [State] {
    return [
      .upcoming,
      .running,
      .finished,
    ]
  }
}

public final class JobQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Job($jobId: ID!) {
      job(id: $jobId) {
        __typename
        id
        name
        startedAt
        finishedAt
        state
        logs
        issuer {
          __typename
          id
          name
        }
        changes {
          __typename
          id
          message
          changer {
            __typename
            id
            name
          }
        }
        stages {
          __typename
          id
          order
          name
          state
          startedAt
          finishedAt
        }
      }
    }
    """

  public let operationName: String = "Job"

  public let operationIdentifier: String? = "68e5d86f4f23b1e51d62dbca217f67bab5ee6039e001160cdbd03f492b88a40c"

  public var jobId: GraphQLID

  public init(jobId: GraphQLID) {
    self.jobId = jobId
  }

  public var variables: GraphQLMap? {
    return ["jobId": jobId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("job", arguments: ["id": GraphQLVariable("jobId")], type: .object(Job.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(job: Job? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "job": job.flatMap { (value: Job) -> ResultMap in value.resultMap }])
    }

    public var job: Job? {
      get {
        return (resultMap["job"] as? ResultMap).flatMap { Job(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "job")
      }
    }

    public struct Job: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["JobById"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("startedAt", type: .scalar(Int.self)),
          GraphQLField("finishedAt", type: .scalar(Int.self)),
          GraphQLField("state", type: .nonNull(.scalar(State.self))),
          GraphQLField("logs", type: .scalar(String.self)),
          GraphQLField("issuer", type: .nonNull(.object(Issuer.selections))),
          GraphQLField("changes", type: .nonNull(.list(.nonNull(.object(Change.selections))))),
          GraphQLField("stages", type: .nonNull(.list(.nonNull(.object(Stage.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String? = nil, startedAt: Int? = nil, finishedAt: Int? = nil, state: State, logs: String? = nil, issuer: Issuer, changes: [Change], stages: [Stage]) {
        self.init(unsafeResultMap: ["__typename": "JobById", "id": id, "name": name, "startedAt": startedAt, "finishedAt": finishedAt, "state": state, "logs": logs, "issuer": issuer.resultMap, "changes": changes.map { (value: Change) -> ResultMap in value.resultMap }, "stages": stages.map { (value: Stage) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var startedAt: Int? {
        get {
          return resultMap["startedAt"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "startedAt")
        }
      }

      public var finishedAt: Int? {
        get {
          return resultMap["finishedAt"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "finishedAt")
        }
      }

      public var state: State {
        get {
          return resultMap["state"]! as! State
        }
        set {
          resultMap.updateValue(newValue, forKey: "state")
        }
      }

      public var logs: String? {
        get {
          return resultMap["logs"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "logs")
        }
      }

      public var issuer: Issuer {
        get {
          return Issuer(unsafeResultMap: resultMap["issuer"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "issuer")
        }
      }

      public var changes: [Change] {
        get {
          return (resultMap["changes"] as! [ResultMap]).map { (value: ResultMap) -> Change in Change(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Change) -> ResultMap in value.resultMap }, forKey: "changes")
        }
      }

      public var stages: [Stage] {
        get {
          return (resultMap["stages"] as! [ResultMap]).map { (value: ResultMap) -> Stage in Stage(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Stage) -> ResultMap in value.resultMap }, forKey: "stages")
        }
      }

      public struct Issuer: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(GraphQLID.self)),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID? = nil, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID? {
          get {
            return resultMap["id"] as? GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct Change: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Change"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
            GraphQLField("changer", type: .nonNull(.object(Changer.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, message: String, changer: Changer) {
          self.init(unsafeResultMap: ["__typename": "Change", "id": id, "message": message, "changer": changer.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var changer: Changer {
          get {
            return Changer(unsafeResultMap: resultMap["changer"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "changer")
          }
        }

        public struct Changer: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(GraphQLID.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID? {
            get {
              return resultMap["id"] as? GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Stage: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Stage"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("order", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("state", type: .nonNull(.scalar(State.self))),
            GraphQLField("startedAt", type: .scalar(Int.self)),
            GraphQLField("finishedAt", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, order: Int, name: String, state: State, startedAt: Int? = nil, finishedAt: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Stage", "id": id, "order": order, "name": name, "state": state, "startedAt": startedAt, "finishedAt": finishedAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var order: Int {
          get {
            return resultMap["order"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "order")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var state: State {
          get {
            return resultMap["state"]! as! State
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var startedAt: Int? {
          get {
            return resultMap["startedAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "startedAt")
          }
        }

        public var finishedAt: Int? {
          get {
            return resultMap["finishedAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "finishedAt")
          }
        }
      }
    }
  }
}

public final class JobsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Jobs($pipelineId: ID!) {
      pipeline(id: $pipelineId) {
        __typename
        jobs {
          __typename
          id
          name
          state
          startedAt
          finishedAt
        }
      }
    }
    """

  public let operationName: String = "Jobs"

  public let operationIdentifier: String? = "b8493fadd56b8d781dbfba05e0b0943865b324755ba9c0a4941a90fa34ef8dd2"

  public var pipelineId: GraphQLID

  public init(pipelineId: GraphQLID) {
    self.pipelineId = pipelineId
  }

  public var variables: GraphQLMap? {
    return ["pipelineId": pipelineId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pipeline", arguments: ["id": GraphQLVariable("pipelineId")], type: .object(Pipeline.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pipeline: Pipeline? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "pipeline": pipeline.flatMap { (value: Pipeline) -> ResultMap in value.resultMap }])
    }

    public var pipeline: Pipeline? {
      get {
        return (resultMap["pipeline"] as? ResultMap).flatMap { Pipeline(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "pipeline")
      }
    }

    public struct Pipeline: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pipeline"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("jobs", type: .nonNull(.list(.nonNull(.object(Job.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(jobs: [Job]) {
        self.init(unsafeResultMap: ["__typename": "Pipeline", "jobs": jobs.map { (value: Job) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var jobs: [Job] {
        get {
          return (resultMap["jobs"] as! [ResultMap]).map { (value: ResultMap) -> Job in Job(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Job) -> ResultMap in value.resultMap }, forKey: "jobs")
        }
      }

      public struct Job: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Job"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("state", type: .nonNull(.scalar(State.self))),
            GraphQLField("startedAt", type: .scalar(Int.self)),
            GraphQLField("finishedAt", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String? = nil, state: State, startedAt: Int? = nil, finishedAt: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Job", "id": id, "name": name, "state": state, "startedAt": startedAt, "finishedAt": finishedAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var state: State {
          get {
            return resultMap["state"]! as! State
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var startedAt: Int? {
          get {
            return resultMap["startedAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "startedAt")
          }
        }

        public var finishedAt: Int? {
          get {
            return resultMap["finishedAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "finishedAt")
          }
        }
      }
    }
  }
}

public final class PipelinesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Pipelines {
      pipelines {
        __typename
        id
        name
        jobs {
          __typename
          state
        }
      }
    }
    """

  public let operationName: String = "Pipelines"

  public let operationIdentifier: String? = "619e21d70493252d15bc815e3cca9033878029c2a9ec53cf4c183e77ff791b6a"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pipelines", type: .nonNull(.list(.nonNull(.object(Pipeline.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pipelines: [Pipeline]) {
      self.init(unsafeResultMap: ["__typename": "Query", "pipelines": pipelines.map { (value: Pipeline) -> ResultMap in value.resultMap }])
    }

    public var pipelines: [Pipeline] {
      get {
        return (resultMap["pipelines"] as! [ResultMap]).map { (value: ResultMap) -> Pipeline in Pipeline(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Pipeline) -> ResultMap in value.resultMap }, forKey: "pipelines")
      }
    }

    public struct Pipeline: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pipeline"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("jobs", type: .nonNull(.list(.nonNull(.object(Job.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, jobs: [Job]) {
        self.init(unsafeResultMap: ["__typename": "Pipeline", "id": id, "name": name, "jobs": jobs.map { (value: Job) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var jobs: [Job] {
        get {
          return (resultMap["jobs"] as! [ResultMap]).map { (value: ResultMap) -> Job in Job(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Job) -> ResultMap in value.resultMap }, forKey: "jobs")
        }
      }

      public struct Job: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Job"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("state", type: .nonNull(.scalar(State.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(state: State) {
          self.init(unsafeResultMap: ["__typename": "Job", "state": state])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var state: State {
          get {
            return resultMap["state"]! as! State
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }
      }
    }
  }
}
