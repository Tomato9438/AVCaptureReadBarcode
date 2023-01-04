//
//  Preferences.swift
//  New
//
//  Created by Tom Bluewater on 11/11/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation

class Preferences {
    static func createData(path: String) {
        var statement: OpaquePointer? = nil
        sqlite3_open(path, &statement);
        let sqlCreate = "CREATE TABLE IF NOT EXISTS data (ID INTEGER PRIMARY KEY AUTOINCREMENT, field text, value text)";
        sqlite3_exec(statement, (sqlCreate as NSString).utf8String, nil, nil, nil);
        //sqlite3_close(statement)
        
        // Start Inserting fields
        for i in 0..<99 {
            if sqlite3_open(path, &statement) == SQLITE_OK {
                let sqlInsert = "INSERT INTO data (field,value) VALUES (?,?)"
                if sqlite3_prepare_v2(statement, sqlInsert, -1, &statement, nil) != SQLITE_OK {
                    //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                    //print("error preparing insert: \(errMsg)")
                }
                sqlite3_bind_text(statement, 1, "Value" + String(i), -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                
                if i == 98 {
                    sqlite3_bind_text(statement, 2, "-1", -1,unsafeBitCast(-1, to: sqlite3_destructor_type.self)) // enter a special value in "0"
                }
                else {
                    sqlite3_bind_text(statement, 2, "0", -1,unsafeBitCast(-1, to: sqlite3_destructor_type.self))
                }
                
                sqlite3_step(statement)
                sqlite3_finalize(statement)
            }
        }
        //sqlite3_close(statement)
        // End Inserting fields
    }
    
    static func readData(path: String, field: String) -> String {
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "Select value FROM data WHERE field = ?"
            if sqlite3_prepare_v2(statement, sql,-1, &statement, nil) != SQLITE_OK {
                //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                //print("error preparing data update: \(errMsg)")
                return "0"
            }
            
            sqlite3_bind_text(statement, 1, field, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            var value = String()
            while (sqlite3_step(statement) == SQLITE_ROW) {
                /*
                 let field0 = sqlite3_column_text(statement, 0)
                 value = String(cString: UnsafeRawPointer(field0!).assumingMemoryBound(to: CChar.self))
                 */
                value = ((sqlite3_column_text(statement, 0)) != nil) ? String(cString: sqlite3_column_text(statement, 0)) : ""
            }
            sqlite3_finalize(statement)
            //sqlite3_close(statement)
            return value
        } else {
            //sqlite3_close(statement)
            return "0"
        }
    }
    
    static func updateData(path: String, field: String, value: String) {
        var statement: OpaquePointer? = nil
        if sqlite3_open(path, &statement) == SQLITE_OK {
            let sql = "UPDATE data SET value = ? WHERE field = ?"
            if sqlite3_prepare_v2(statement, sql, -1, &statement, nil) != SQLITE_OK {
                //let errMsg = String.init(validatingUTF8: sqlite3_errmsg(statement))
                //print("error preparing data update: \(errMsg)")
            }
            sqlite3_bind_text(statement, 1, value, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 2, field, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_step(statement)
            sqlite3_finalize(statement)
            //sqlite3_close(statement)
        } else {
            print("The database not open...")
            //sqlite3_close(statement)
        }
    }
}

/*
 Value1 xxx
 Value2 xxx
 Value3 xxx
 Value4 xxx
 Value5 xxx
 Value6 xxx
 Value7 xxx
 Value8 xxx
 Value9 xxx
 Value10 xxx
 Value11 xxx
 Value12 xxx
 Value13 xxx
 Value14 xxx
 Value15 xxx
 Value16 xxx
 Value17 xxx
 Value18 xxx
 Value19 xxx
 Value20 xxx
 Value21 xxx
 Value22 xxx
 Value23 xxx
 Value24 xxx
 Value25 xxx
 Value26
 Value27
 Value28
 Value29
 Value30
 Value31
 Value32
 Value33
 Value34
 Value35
 Value36
 Value37
 Value38
 Value39
 Value40
 */

//let prefFile = filePath1(name: "Preferences")
//READ: Preferences.readData(path: prefFile, field: "Value1")
//SAVE: Preferences.updateData(path: prefFile, field: "Value1", value: XXX)
