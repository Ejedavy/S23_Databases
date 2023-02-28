CREATE TABLE Book (
  book varchar PRIMARY KEY,
  publisher varchar
);

CREATE TABLE Teacher3 (
  teacher varchar PRIMARY KEY,
  school varchar,
  room varchar,
  grade varchar
);

CREATE TABLE LoanBook3 (
  course varchar,
  book varchar,
  teacher varchar,
  loandate timestamptz,
  PRIMARY KEY (course, teacher)
);

ALTER TABLE LoanBook3 ADD FOREIGN KEY (book) REFERENCES Book (book);

ALTER TABLE LoanBook3 ADD FOREIGN KEY (teacher) REFERENCES Teacher3 (teacher);


select b.book, t.school from Book as b , Loanbook3 as lb, Teacher3 as t
where b.book = lb.book and lb.teacher = t.teacher;

select min(loandate) from (teacher3 as t JOIN LoanBook3 as l ON t.teacher = l.teacher)
GROUP By school;