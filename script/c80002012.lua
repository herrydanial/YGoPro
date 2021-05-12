--Hidden Shot
function c80002012.initial_effect(c)

	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c80002012.cost)
	e1:SetTarget(c80002012.target)
	e1:SetOperation(c80002012.activate)
	c:RegisterEffect(e1)
end

function c80002012.filter(c)
	return c:IsSetCard(0x2016) and c:IsAbleToRemoveAsCost()
end
function c80002012.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80002012.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g = nil
	if dg:GetCount()<2 then
		g=Duel.SelectMatchingCard(tp,c80002012.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	else
		g=Duel.SelectMatchingCard(tp,c80002012.filter,tp,LOCATION_GRAVE,0,1,2,nil)
	end
	local ct=g:GetCount()
	e:SetLabel(ct)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c80002012.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=e:GetLabel()
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,ct,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c80002012.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(g,REASON_EFFECT)
end