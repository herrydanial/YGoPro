--ペンデュラム・コール
function c800000278.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,800000278+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c800000278.condition)
	e1:SetCost(c800000278.cost)
	e1:SetTarget(c800000278.target)
	e1:SetOperation(c800000278.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(800000278,ACTIVITY_CHAIN,c800000278.chainfilter)
end
function c800000278.chainfilter(re,tp,cid)
	local rc=re:GetHandler()
	local loc=Duel.GetChainInfo(cid,CHAININFO_TRIGGERING_LOCATION)
	return not (re:GetActiveType()==TYPE_PENDULUM+TYPE_SPELL and not re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and bit.band(loc,LOCATION_PZONE)==LOCATION_PZONE and rc:IsSetCard(0x98))
end
function c800000278.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCustomActivityCount(800000278,tp,ACTIVITY_CHAIN)==0
end
function c800000278.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c800000278.thfilter(c)
	return c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c800000278.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c800000278.thfilter,tp,LOCATION_DECK,0,nil)
		return g:GetClassCount(Card.GetCode)>=2
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c800000278.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c800000278.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetClassCount(Card.GetCode)>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetTargetRange(LOCATION_PZONE,0)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x98))
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
	end
end
