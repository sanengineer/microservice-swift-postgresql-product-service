import Vapor
import FluentPostgresDriver

func routes(_ app: Application) throws {
    
    let port: Int
    
    guard let serverHostname = Environment.get("PRODUCT_HOSTNAME") else {
        return print("No Env Server Hostname")
    }
    
    if let envPort = Environment.get("PRODUCT_PORT"){
        port = Int(envPort) ?? 8081
    } else {
        port = 8081
    }

    app.databases.use(
        .postgres(
            hostname: Environment.get("DB_HOSTNAME")!,
            username: Environment.get("DB_USERNAME")!,
            password: Environment.get("DB_PASSWORD")!,
            database: Environment.get("DB_NAME")!
        ),
        as: .psql)
    
    app.logger.logLevel = .debug
    app.http.server.configuration.hostname = serverHostname
    app.http.server.configuration.port = port
    
  
    try app.register(collection: ProductsController())
    
}
