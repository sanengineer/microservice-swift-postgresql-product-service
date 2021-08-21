import Vapor
import Fluent

struct ProductsController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        
        let products = routes.grouped("product")
        let productsAuth = products.grouped(UserAuthMiddleware())
        
        // Query Routes
        productsAuth.get(":product_id", use: readOneHandler)
        productsAuth.get(use: readAllHandler)
        productsAuth.get("result", use: searchHandler)
        productsAuth.get("category", ":category_id", use: searchByCategoryID)
    }
    
    // Query Functions
    func readAllHandler(_ req: Request) throws -> EventLoopFuture<[Product]> {
        Product.query(on: req.db).sort(\.$name, .ascending).all()
    }
    
    func readOneHandler(_ req: Request) throws -> EventLoopFuture<Product> {
        Product.find(req.parameters.get("product_id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    func searchByCategoryID(_ req: Request) throws -> EventLoopFuture<[Product]> {
        let category_id = req.parameters.get("category_id", as: UUID.self)
        
        return Product
            .query(on: req.db)
            .filter(\.$categories_id == category_id)
            .all()
    }
    
    func searchHandler(_ req: Request) throws -> EventLoopFuture<[Product]> {
    
    guard let searchQuery = req.query[String.self, at: "search_query"] else { throw Abort(.badRequest)}
        return Product.query(on: req.db)
            .filter(\.$name ~~ searchQuery)
            .all()
    }
}
