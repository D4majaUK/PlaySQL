USE TEST
INSERT INTO Hello(id, first, last) VALUES (6, 'Boris', 'Becker')
INSERT INTO Hello(id, first, last) VALUES (7, 'Kanye', 'West')
INSERT INTO Hello(id, first, last) VALUES (8, 'Donald', 'Trump')
INSERT INTO Hello(id, first, last) VALUES (9, 'Barrack', 'Obama')
INSERT INTO Hello(id, first, last) VALUES (10, 'Brad', 'Pott')
UPDATE Hello
SET Last = 'Pitt'
WHERE Hello.First = 'Brad' AND Hello.Last = 'Pott'
