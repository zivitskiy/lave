import Vapor

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<Response> in
        let filepath = req.application.directory.publicDirectory + "index.html"
        return req.fileio.collectFile(at: filepath).map { file in
            var headers = HTTPHeaders()
            headers.add(name: .contentType, value: "text/html; charset=utf-8")
            let body = Response.Body(buffer: file)
            return Response(status: .ok, headers: headers, body: body)
        }
    }
}
