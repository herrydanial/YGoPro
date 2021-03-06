--永の王 オルムガンド

--Scripted by nekrozar
function c100413033.initial_effect(c)
	c:SetUniqueOnField(1,0,100413033)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2,nil,nil,99)
	c:EnableReviveLimit()
	--base atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c100413033.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100413033,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,100413033)
	e3:SetCost(c100413033.drcost)
	e3:SetTarget(c100413033.drtg)
	e3:SetOperation(c100413033.drop)
	c:RegisterEffect(e3)
end
function c100413033.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c100413033.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100413033.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c100413033.ofilter(c,tp)
	return not c:IsType(TYPE_TOKEN) and (c:IsControler(tp) or c:IsAbleToChangeControler())
end
function c100413033.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local td=Duel.Draw(tp,1,REASON_EFFECT)
	local ed=Duel.Draw(1-tp,1,REASON_EFFECT)
	local cp=c:GetControler()
	if td+ed>0 and c:IsRelateToEffect(e) then
		local sg=Group.CreateGroup()
		local tg1=Duel.GetMatchingGroup(c100413033.ofilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,aux.ExceptThisCard(e),cp)
		if td>0 and tg1:GetCount()>0 then
			Duel.ShuffleHand(tp)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local tc1=tg1:Select(tp,1,1,nil):GetFirst()
			if tc1 and not tc1:IsImmuneToEffect(e) then
				tc1:CancelToGrave()
				sg:AddCard(tc1)
			end
		end
		local tg2=Duel.GetMatchingGroup(c100413033.ofilter,1-tp,LOCATION_HAND+LOCATION_ONFIELD,0,aux.ExceptThisCard(e),cp)
		if ed>0 and tg2:GetCount()>0 then
			Duel.ShuffleHand(1-tp)
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_XMATERIAL)
			local tc2=tg2:Select(1-tp,1,1,nil):GetFirst()
			if tc2 and not tc2:IsImmuneToEffect(e) then
				tc2:CancelToGrave()
				sg:AddCard(tc2)
			end
		end
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Overlay(c,sg)
		end
	end
end
