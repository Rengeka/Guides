# ADR Sample

* Status: accepted
* Deciders: Stanislav Ciobanu
* Date: 2025-10-01

Technical Story: #12 Add relational database

## Context and Problem Statement

We need a reliable relational database to store user and order information.  
The requirements are:  
- ACID compliance.  
- Scalability for a growing number of users.  
- Support for complex queries and indexing.

## Decision Drivers

* Ensure data consistency across multiple services (reliability)
* Handle high user load and large datasets (scalability)
* Minimize learning curve and operational complexity (skills, maintenance)
* Budget constraints (operational cost)

## Considered Options

* SQLite
* PostgreSQL
* MySQL

## Decision Outcome

Chosen option: "PostgreSQL", because PostgreSQL ensures data consistency across multiple services (reliability)  
It can handle high user loads and complex queries (scalability)  
Team already has experience with PostgreSQL, reducing training and operational overhead (skills)  
SQLite cannot handle multi-user environments effectively  
MySQL lacks certain extensions and features required for our project (JSON, PostGIS)

### Positive Consequences

* Reliable and transactional support.
* Support for complex queries and extensions.
* Large community and rich ecosystem of tools.

### Negative Consequences

* Team training required.
* Additional overhead for administration.

## Links

* https://adr.github.io/madr/
* https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
* https://github.com/joelparkerhenderson/architecture_decision_record
* https://marketplace.visualstudio.com/items?itemName=jameshamann.adr-manager
* https://medium.com/@thomasrussell/documenting-architecture-decisions-with-adr-650d118156bc
