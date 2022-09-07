
//Query
String readRepo =
"""
      query graph_ql  {
      user (login : "mohamedyousefkhedr")
      {
      
       avatarUrl(size: 200)
                location
                name
                url
                email
                login
                repositories {
                  totalCount
                }
                followers {
                  totalCount
                }
                following {
                  totalCount
                }
              }
      viewer {
              repositories(last: 12) {
                 
                  nodes {
                    id
                    name
                    nameWithOwner
                  }
                
              }
            }
          }
      """;
      

