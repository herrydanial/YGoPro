--墓守の番兵
function c37101832.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37101832,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c37101832.target)
	e1:SetOperation(c37101832.operation)
	c:RegisterEffect(e1)
end
function c37101832.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c37101832.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c37101832.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c37101832.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c37101832.filter,tp,0,LOCATION_MZONE+LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end

function c37101832.filter(c)
	return c:IsAbleToHand()
end
