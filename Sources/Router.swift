import struct http4swift.HTTPRequest
import struct http4swift.HTTPServer
import struct http4swift.SocketAddress
import struct http4swift.Socket
import Foundation

public typealias Handler = (HTTPRequest) -> (Response)
public typealias HTTPRequest = http4swift.HTTPRequest

public class Router {

  var routes = [Route]()

  public init() { }

  public func get(url: String, handler: Handler) {
    routes.append(Route(method: "GET", url: url, handler: handler))
  }

  public func get<T>(url: String, ctrl: Controller.Type, method: (T -> Handler)) {
    let instance = ctrl.init()
    let handler = method(instance as! T)

    routes.append(Route(method: "GET", url: url, handler: handler))
  }

  public func serve(port: UInt16) {

    let addr = SocketAddress(port: port)
    guard let sock = Socket() else {
      print("Socket failed")
      return
    }

    guard let server = HTTPServer(socket: sock, addr: addr) else {
      print("Server failed")
      return
    }

    server.serve { (request, writer) in

      guard let url = NSURL(string: request.path) else {
        return
      }

      let params = self.parseParameters(url.query)

      var response: Response?

      for route in self.routes {
        if(route.method == request.method && route.url == url.path) {
          response = route.handler(request)
          break
        }
      }

      if response == nil {
        response = Response(Status.NotFound)
        response!.body = Status.NotFound.description
      }

      writer.write("HTTP/1.0 \(response!.status.rawValue) \(response!.status.description)\r\n")
      writer.write("Content-Length: \(response!.body.characters.count)\r\n")
      for header in response!.headers {
          writer.write("\(header.0): \(header.1)\r\n")
      }
      writer.write("\r\n")
      writer.write(response!.body)
    }

  }

  func parseParameters(paramString: String?) -> [String: String] {
    var params = [String : String]()
    guard let paramString = paramString else {
      return params
    }
    var components = paramString.componentsSeparatedByString("&")

    for i in 0..<components.count {
      var section = components[i].componentsSeparatedByString("=")
      params[section[0]] = section[1]
    }

    return params
  }

}