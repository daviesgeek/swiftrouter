class Route {

  let method : String
  let url : String
  let handler : Handler

  init(method: String, url: String, handler: Handler) {
    self.method = method
    self.url = url
    self.handler = handler
  }

}