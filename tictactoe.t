var win : int := Window.Open ("graphics:500;500,title:Tic-Tac-Toe")
setscreen ("offscreenonly")
setscreen ("nobuttonbar")
setscreen ("nocursor")

var xs : array 1 .. 3, 1 .. 3 of boolean
var os : array 1 .. 3, 1 .. 3 of boolean

var isxturn : boolean := true

var x, y, b : int

var message:string

var count:int:=0

var cx, cy : int

var reply:string (1)

proc initialize
    cls

    for s : 1 .. 3
	for t : 1 .. 3
	    xs (s, t) := false
	    os (s, t) := false
	end for
    end for
    
    count:=0
    isxturn:=true

    drawline (200, 400, 200, 100, black)
    drawline (300, 400, 300, 100, black)
    drawline (100, 300, 400, 300, black)
    drawline (100, 200, 400, 200, black)
    View.Update
end initialize

proc drawo (x, y : int)
    drawfilloval (x * 100 + 50, y * 100 + 50, 45, 45, black)
    drawfilloval (x * 100 + 50, y * 100 + 50, 35, 35, white)
    View.Update
end drawo

proc drawx (x, y : int)
    Draw.ThickLine (x * 100 + 10, y * 100 + 10, x * 100 + 90, y * 100 + 90, 10, black)
    Draw.ThickLine (x * 100 + 10, y * 100 + 90, x * 100 + 90, y * 100 + 10, 10, black)
    View.Update
end drawx

proc continue
    put "Press escape to exit, or any other key to restart the game..." ..
    View.Update
    getch (reply)
end continue

fcn xwin (x, y : int) : boolean

    %check rows
    for i : 1 .. 3
	if xs (1, i) = true and xs (2, i) = true and xs (3, i) = true then
	    result true
	end if
    end for

    %check columns
    for i : 1 .. 3
	if xs (i, 1) = true and xs (i, 2) = true and xs (i, 3) = true then
	    result true
	end if
    end for

    %check diagonals
    if xs (1, 1) = true and xs (2, 2) = true and xs (3, 3) = true then
	result true
    elsif xs (1, 3) = true and xs (2, 2) = true and xs (3, 1) = true then
	result true
    end if

    result false
end xwin

fcn owin (x, y : int) : boolean

    %check rows
    for i : 1 .. 3
	if os (1, i) = true and os (2, i) = true and os (3, i) = true then
	    result true
	end if
    end for

    %check columns
    for i : 1 .. 3
	if os (i, 1) = true and os (i, 2) = true and os (i, 3) = true then
	    result true
	end if
    end for

    %check diagonals
    if os (1, 1) = true and os (2, 2) = true and os (3, 3) = true then
	result true
    elsif os (1, 3) = true and os (2, 2) = true and os (3, 1) = true then
	result true
    end if

    result false
end owin

proc main
    loop
	mousewhere (x, y, b)
	if b = 1 and x > 100 and x < 400 and y > 100 and y < 400 then
	    cx := x div 100
	    cy := y div 100
	    if xs (cx, cy) = false and os (cx, cy) = false then
		if isxturn = true then
		    drawx (cx, cy)
		    isxturn := false
		    xs (cx, cy) := true
		    count+=1
		    if xwin (cx, cy) then
			message:="Player 1 Wins!"
			exit
		    end if
		else
		    drawo (cx, cy)
		    isxturn := true
		    os (cx, cy) := true
		    count+=1
		    if owin (cx, cy) then
			message:="Player 2 Wins!"
			exit
		    end if
		end if
	    end if
     loop
	mousewhere (x,y,b)
     exit when b=0
     end loop
	end if
	if count>=9 then
	    message:="It's A Draw!"
	    exit
	end if
    end loop
end main

loop
    initialize
    main
    put message
    continue
    exit when reply=chr (27)
end loop
Window.Close (win)

