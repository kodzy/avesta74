
function hasPlayerLeft(cid)
	if (getDistanceToCreature(cid) > 4) then
		return true
	end

	return false
end

function getNextPlayer()
	if (not(isQueueEmpty())) then
		nextPlayer = getQueuedPlayer()
		if (nextPlayer) then
			if (getDistanceToCreature(nextPlayer) <= 4) then
				setFocus(nextPlayer)
				greet(nextPlayer)
				updateIdle()
				return
			else
				getNextPlayer()
			end
		end
	end
	
	setFocus(0)
	resetIdle()
end

function greet(cid)
	selfSay('Welcome to Edron Furniture Store, ' .. getCreatureName(cid) .. '.')
end

function _selfSay(message)
	selfSay(message)
	updateIdle()
end

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	unqueuePlayer(cid)
end

function onCreatureMove(cid, oldPos, newPos)
end

function onCreatureSay(cid, type, msg)
	if (getFocus() == 0) then
		if ((msgcontains(msg, 'hi') or msgcontains(msg, 'hello')) and getDistanceToCreature(cid) <= 4) then
			setFocus(cid)
			updateIdle()
			greet(cid)
		end
	else
		if (getFocus() ~= cid and (msgcontains(msg, 'hi') or msgcontains(msg, 'hello')) and getDistanceToCreature(cid) <= 4) then
			selfSay('One moment please, ' .. getCreatureName(cid) .. '.')
			queuePlayer(cid)
		
		elseif (msgcontains(msg, 'bye') or msgcontains(msg, 'farewell')) then
			selfSay('Good bye.')
			getNextPlayer()
		
		elseif (msgcontains(msg, 'name')) then
			_selfSay('My name is Edvard. I run this store.')
		
		elseif (msgcontains(msg, 'job')) then
			_selfSay('Have you moved to a new home? I\'m the specialist for equipping it.')
		
		elseif (msgcontains(msg, 'time')) then
			_selfSay('It is ' .. getTibiaTime() .. '. Do you need a clock for your house?')
		
		elseif (msgcontains(msg, 'news')) then
			_selfSay('You mean my specials, don\'t you?')
		
		elseif (msgcontains(msg, 'special')) then
			_selfSay('My offers are permanently extraordinary cheap.')
		
		elseif (msgcontains(msg, 'offer') or msgcontains(msg, 'goods') or 
			msgcontains(msg, 'furniture') or msgcontains(msg, 'equipment')) then
			_selfSay('I sell statues, tables, chairs, flowers, pillows, pottery, instruments, decoration, tapestries and containers.')
		end
	end
end

function onThink()
	if (getFocus() ~= 0) then
		if (isIdle() or hasPlayerLeft(getFocus())) then
			selfSay('Good bye.')
			getNextPlayer()
		end
	end
end

