# Server Side Swift With Postgres For Create Product Services As Microservices

On almost engineer just strating, swift  familliar running on apple device on client-side. But since apple build SwiftNIO, swift unlock capability can running on server-side. In this project I try use vapor and postgres to create restfull api. vapor is web framework for server-side swift, and build on top of SwiftNIO.


## Rest Endpoint URL

### Read

I called all http method GET is Query, this is all endpoint url I've created:

Read all data:

    /product
    
Read one data by id:

    /product/{product_id}

Search data by term:

    /product/result?search_query={query}

### POST

    /product


### PUT

    /product/{product_id}
    

### DELETE

    /product/{product_id}
