// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PipelinesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Pipelines {
      pipelines {
        __typename
        id
        name
      }
    }
    """

  public let operationName: String = "Pipelines"

  public let operationIdentifier: String? = "8df4275ed95660667a0378e6852fb2dd433bef53291d2688c9f4b4cdb9f9c430"

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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String) {
        self.init(unsafeResultMap: ["__typename": "Pipeline", "id": id, "name": name])
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
    }
  }
}
