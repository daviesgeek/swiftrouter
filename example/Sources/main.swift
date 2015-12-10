import swiftrouter

let router = Router()

router.get("/", ctrl: MainController.self, method: MainController.index)

router.serve(8080)