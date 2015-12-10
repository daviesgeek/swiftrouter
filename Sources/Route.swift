class Route {

  let method : String
  let url : String
  let handler : Handler

  init(method: String, url: String, handler: Handler) {
    self.method = method
    self.url = url
    self.handler = handler
  }

  init(method: String, url: String, handler: String) {
    self.method = method
    self.url = url

    // let method = handler.characters.split{ $0 == "@" }.map(String.init)

    self.handler = { req in
      return Response("string handler hasn't been implemented")
    }
  }
}