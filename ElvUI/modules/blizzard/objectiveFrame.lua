local E, L, DF = unpack(select(2, ...))
local B = E:GetModule('Blizzard');

local ObjectiveFrameHolder = CreateFrame("Frame", "ObjectiveFrameHolder", E.UIParent)
ObjectiveFrameHolder:SetWidth(130)
ObjectiveFrameHolder:SetHeight(22)
ObjectiveFrameHolder:SetPoint('TOPRIGHT', E.UIParent, 'TOPRIGHT', -135, -300)

function B:ObjectiveFrameHeight()
	ObjectiveTrackerFrame:Height(E.db.general.objectiveFrameHeight)
end

local function GetSide(frame)
	local x, y = frame:GetCenter()
	local screenWidth = GetScreenWidth()
	local screenHeight = GetScreenHeight()
	
	if not frame:GetCenter() then
		return false
	end
	
	if x < (screenWidth / 2) then
		return true
	elseif x > (screenWidth / 2)then
		return false
	else
		return false
	end
	return false
end

function B:MoveObjectiveFrame()
	E:CreateMover(ObjectiveFrameHolder, 'ObjectiveFrameMover', L['Objective Frame'])
	ObjectiveFrameHolder:SetAllPoints(ObjectiveFrameMover)

	ObjectiveTrackerFrame:ClearAllPoints()
	ObjectiveTrackerFrame:SetPoint('TOP', ObjectiveFrameHolder, 'TOP')
	B:ObjectiveFrameHeight()
	ObjectiveTrackerFrame:SetClampedToScreen(false)
	hooksecurefunc(ObjectiveTrackerFrame,"SetPoint",function(_,_,parent)
		if parent ~= ObjectiveFrameHolder then
			ObjectiveTrackerFrame:ClearAllPoints()
			ObjectiveTrackerFrame:SetPoint('TOP', ObjectiveFrameHolder, 'TOP')
		end
	end)
	hooksecurefunc("BonusObjectiveTracker_AnimateReward", function(block)
		local rewardsFrame = ObjectiveTrackerBonusRewardsFrame;
		rewardsFrame:ClearAllPoints();
		if E.db.general.bonusObjectiveAuto then
			local left = GetSide(ObjectiveTrackerFrame)
			if left then
				rewardsFrame:SetPoint("TOPLEFT", block, "TOPRIGHT", -10, -4); 
			else
				rewardsFrame:SetPoint("TOPRIGHT", block, "TOPLEFT", 10, -4);
			end
		else
			if E.db.general.bonusObjectivePosition == "RIGHT" then
				rewardsFrame:SetPoint("TOPLEFT", block, "TOPRIGHT", -10, -4);
			else
				rewardsFrame:SetPoint("TOPRIGHT", block, "TOPLEFT", 10, -4);
			end
		end
	end)
end