# Simple Graph Description Language

## Overview

Mummy is a graph description language that specifies the objects in directed/undirected graphs. User can define graphs containing edge, and vertex attributes. This documentation will provide all the information necessary to understand how to use Mummy for declaring and querying graphs. Various types of queries can be expressed in Mummy, querying graphs will be discussed in the second part of this document. User can define in a few lines of code what it would take many lines of code in Java to express.

## 1.1 DEFINING DIRECTED GRAPHS

A directed graph is a set of vertices and a collection of directed edges that each connects an ordered pair of vertices. DirectedGraph is reserved keyword for defining directed graphs. 

    DirectedGraph dg_1 = { 
        // Creates an empty directed graph
    }

    DirectedGraph dg_2 = { 
        // Creates a directed graph with one vertex 
        vertex_1; 
    }

    DirectedGraph dg_3 = { 
        // Creates vertex_1 and vertex_2, then sets the direction of edge from 
        vertex_1 to vertex_2 
        vertex_1; 
        vertex_2;
        vertex_1 -> vertex_2;
    } 

    DirectedGraph dg_4 = { 
        // The edge between vertex_1 and vertex_2 is assigned to variable 
        “edge_1” 
        vertex_1; 
        vertex_2;
        edge_1 = vertex_1 -> vertex_2; 
    } 
## 1.2 DEFINING UNDIRECTED GRAPHS
An undirected graph is a set of vertex which are connected together, where all 
the edges are bidirectional. UndirectedGraph is reserved for defining undirected 
graphs.

    UndirectedGraph ug_1 = { 
        // Creates an empty undirected graph
    }

    UndirectedGraph ug_2 = { 
        // Creates an undirected graph with one vertex 
        vertex_1; 
    }

    UndirectedGraph ug_3 = { 
        // Creates vertex_1 vertex_2, then connects vertex_1 and vertex_2
        vertex_1 -- vertex_2;
        // Creates vertex_3, then connects vertex_1 and vertex_3s
        vertex_1 -- vertex_3;
     } 
    
    UndirectedGraph ug_4 = { 
        // The edge between vertex_1 and vertex_2 is assigned to variable “edge_1” 
        edge_1 = vertex_1 -- vertex_2; 
    } 

## 1.3 DEFINING VERTEX PROPERTIES

Mulitple properties can be attached to a vertex, where a property consist of a (name,value) pair. A property must be in the format of <String, ?>.  

    DirectedGraph dg = { 
        // Initializes student before assigning any property. 
        student; 
        // Attaches multiple properties 
        student[“name”] = “Mahmut”; 
        student[“ID”] = 12345;
    }  

## 1.4 DEFINING EDGE PROPERTIES

    UndirectedGraph friends = { 
        student_1; 
        student_2;
        student_3; 
        // Attaches multiple properties 
        student_1[“name”] = “Mehmet Ali”; 
        student_1[“ID”] = 119; 
        student_2[“name”] = “Yiğit”; 
        student_2[“ID”] = 120;
        student_3[“name”] = “Mahmut”; 
        student_3[“ID”] = 121; 
        
        edge_1 = student_1 -- student_2; 
        edge_2 = student_2 -- student_3; 
        // Attaches multiple properties to edges.
        student_1 -- student_3[“friendship_duration”] = 36;   # Friends for 36 months
        edge_1[“friendship_duration”] = 13;  # Friends for 31 months
        edge_2[“friendship_duration”] = 22;  # Friends for 22 months 
        edge_1[“project_partner”] = 1; # Project partners = True 
        edge_2[“project_partner”] = 0; # Project partners = False
    
    }

## 1.5 DYNAMIC TYPING
It supports a dynamic type system for the property values (property names should be strings). Strings, integers, and floats are supported as primitive types.
    

    UndirectedGraph ug = { 
        student;
        student[“name”] = “Mehmet Ali”;  // value as a string
        student[“ID”] = 119; // value as a integer
        student[“height”] = 1.8; // value as a float 
        student[“course_list”] = [“cs315”, “cs319”, “cs484”];  // value as a list
        
        // value as a set
        student[“classmates”] = (“Berk”, “Berke”, “Berkay”, “Berkecan”, “Ayberk” );
        
        // value as a map
        student[“expenses”] = {“clothing”: 200, “eating”: 150, “transportation”: 250};
    }
