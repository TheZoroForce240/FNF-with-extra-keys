function start(song) -- do nothing

end

function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
	_G['defaultStrum'..id..'Y'] = getActorY(id)
	_G['defaultStrum'..id..'Z'] = getActorAngle(id)	
	setActorAngle(0,id)
end

function update(elapsed)
    if difficulty == 2 and curStep > 400 then
        local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,17 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end

    elseif difficulty == 0 and curStep > 400 then
        local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,17 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end

    end

end

function beatHit(beat) -- do nothing

end


--alright heres a guide on how this changeMania() stuff works

--first of all, the song HAS to be set to 9k, this is because you wouldn't be able switch to higher key amounts mid song, only lower and back up. also because i dont wanna figure out the positions for every single fucking mania, fuck that
--probably gonna add a way to change the amount of keys you start with when using this, so you dont always start with 9k

--list of mania

--   0-8 you DON'T wanna do, these are the song set ones, and shouldn't be used with the changeMania function
--0 || 4K
--1 || 6K
--2 || 9K
--3 || 5K
--4 || 7K
--5 || 8K
--6 || 1K
--7 || 2K
--8 || 3K

--    10-18 are the ones you wanna use inside the changeMania function 
--10 || 4K
--11 || 6K
--12 || 9K
--13 || 5K
--14 || 7K
--15 || 8K
--16 || 1K
--17 || 2K
--18 || 3K


--some limitations to be aware of

--1. long note sizes dont change, so they dont create awful trails
--2. note type sizes dont change, when i tested it, they became really small, so youre just gonna have to deal with the sizes not changing.
--3. the song has to still be charted as if its 9k, you're just gonna have to only use the arrow colors that are used for that key amount used at the part of the song, 
--there is a feature of the randomization that you can change to always work where it automatically fixes the arrow positions based on what it changed to, just make it so it doesnt check if randomization is enabled (inside Note.hx, in update)



function stepHit(step) -- do nothing
	if curStep == 1 then 
		changeMania(16)
	elseif curStep == 56 then 
		changeMania(17)
	elseif curStep == 125 then 
		changeMania(10)
	elseif curStep == 189 then 
		changeMania(11)
	elseif curStep == 252 then 
		changeMania(15)
	elseif curStep == 323 then 
		changeMania(12)
	elseif curStep == 390 then  
		changeMania(10)
	elseif curStep == 410 then 
		changeMania(12)
	end
end

function playerTwoTurn()
    tweenCameraZoom(1.3,(crochet * 4) / 1000)
end

function playerOneTurn()
    tweenCameraZoom(1,(crochet * 4) / 1000)
end