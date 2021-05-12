--紅玉の宝札
--Card of Red Jewel
function c80100160.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,80100160+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c80100160.cost)
	e1:SetTarget(c80100160.target)
	e1:SetOperation(c80100160.activate)
	c:RegisterEffect(e1)
end
function c80100160.filter(c)
	return c:IsSetCard(0x3b) and c:GetLevel()==7 and c:IsAbleToGraveAsCost()
end
function c80100160.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80100160.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c80100160.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c80100160.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c80100160.tgfilter(c)
	return c:IsSetCard(0x3b) and c:GetLevel()==7 and c:IsAbleToGrave()
end
function c80100160.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)	
	if Duel.Draw(p,d,REASON_EFFECT)>0 
		and Duel.IsExistingMatchingCard(c80100160.tgfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(80100160,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c80100160.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.BreakEffect()
		Duel.SendtoGrave(g1,REASON_EFFECT)
	end
end
