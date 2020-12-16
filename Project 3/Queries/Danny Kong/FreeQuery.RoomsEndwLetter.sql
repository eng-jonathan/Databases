---------------------------------
--Proposition: Display all rooms that have a letter at the end of the room number
---------------------------------
SELECT RoomLocationKey, RoomLocation
FROM [Location].RoomLocation
WHERE RoomLocation LIKE N'%[A-Z]' AND RoomLocation <> 'TBA';