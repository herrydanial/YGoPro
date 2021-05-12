--Demon Emperor Angmar
function c80007002.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80007002,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c80007002.condition)
	e1:SetCost(c80007002.cost)
	e1:SetTarget(c80007002.target)
	e1:SetOperation(c80007002.operation)
	c:RegisterEffect(e1)
end

function c80007002.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c80007002.filter(c,tp)
	return c:IsType(TYPE_SPELL) and c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(c80007002.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c80007002.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c80007002.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80007002.filter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c80007002.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetCode())
end
function c80007002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80007002.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.SelectMatchingCard(tp,c80007002.thfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel())
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
