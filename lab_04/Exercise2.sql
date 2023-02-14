-- TABLE
CREATE TABLE Course(
  Name VARCHAR(128) PRIMARY KEY,
  Credit INTEGER,
  University_Name VARCHAR(128) NOT NULL REFERENCES University(Name)
  
);

CREATE TABLE Enroll (
  STUDENT_ID INTEGER  REFERENCES Student(ID),
  COURSE_NAME VARCHAR(128)  REFERENCES Course(Name),
  PRIMARY KEY (STUDENT_ID, COURSE_NAME)  
);
CREATE TABLE Student(
   ID INTEGER PRIMARY KEY,
   Name VARCHAR(128),
   Native_language VARCHAR(128),
   University_Name VARCHAR(128) NOT NULL REFERENCES University(Name)
   
);
CREATE TABLE University(
  Name VARCHAR(128) PRIMARY KEY, 
  Location VARCHAR(128)
);

INSERT INTO University(Name,location) VALUES ('Innopolis Univeristy', 'Russia'),
											 ('MIT', 'USA'),
                                             ('Imperial College', 'UK');
                                             
INSERT INTO Student(ID, Name, native_language, university_name) VALUES (1, 'Abu', 'English', 'Innopolis Univeristy'),
																	   (2, 'Tanmay', 'Russian', 'MIT'),
                                                                       (3, 'David', 'English', 'Imperial College');
                                                                       
INSERT INTO Course(Name, credit, university_name) VALUES ('Linear Algebra', 8, 'Innopolis Univeristy'),
																	   ('Math Analysis', 8, 'MIT'),
                                                                       ('Databases', 12, 'Imperial College');
                                                                       
INSERT INTO Enroll(student_id, course_name) VALUES (3, 'Databases'),
													(2, 'Math Analysis'),
                                                    (1, 'Linear Algebra');
                                                                      
                                                                       
                                                                           
                    
-- QUERIES
SELECT * FROM University WHERE location = 'Russia';
SELECT Location FROM Student JOIN University ON Student.University_Name = University.Name AND Student.Native_Language = 'Russian';
SELECT ID FROM Student WHERE University_Name = 'Innopolis Univeristy';
SELECT Name, University_Name FROM Course WHERE Credit > 5;
SELECT University_Name, Location FROM UniversIty JOIN Student ON Student.Native_language = 'English' AND Student.University_Name = University.Name;
