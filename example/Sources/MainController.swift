import swiftrouter

class MainController : Controller {
  required init(){}

  func index(request: HTTPRequest) -> Response {
    return Response("This is the index page")
  }
}