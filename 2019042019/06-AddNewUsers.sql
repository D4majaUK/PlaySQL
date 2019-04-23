USE TEST
INSERT INTO Hello(id, first, last) VALUES (1, 'Boris', 'Becker')
INSERT INTO Hello(id, first, last) VALUES (1, 'Kanye', 'West')
INSERT INTO Hello(id, first, last) VALUES (1, 'Donald', 'Trump')
INSERT INTO Hello(id, first, last) VALUES (1, 'Barrack', 'Obama')
INSERT INTO Hello(id, first, last) VALUES (1, 'Brad', 'Pott')
UPDATE Hello
SET Last = 'Pitt'
WHERE Hello.First = 'Brad' AND Hello.Last = 'Pott'
