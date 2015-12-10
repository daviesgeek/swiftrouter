public struct Response {

  var status = Status.OK
  var headers = [String: String]()
  var body = ""

  public init(status: Status, headers: [String: String], body: String) {
    self.status = status
    self.headers = headers
    self.body = body
  }

  public init(_ content: String) {
    body = content
  }

  public init(_ status: Status) {
    self.status = status
    self.body = status.description
  }
}