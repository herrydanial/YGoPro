--Soul Exchange
function c700000005.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c700000005.target)
	e1:SetOperation(c700000005.activate)
	c:RegisterEffect(e1)
end
function c700000005.filter(c)
	return not (c:IsHasEffect(EFFECT_UNRELEASABLE_SUM) or c:IsHasEffect(EFFECT_UNRELEASABLE_NONSUM))
end
function c700000005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c700000005.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000005.filter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c700000005.filter,tp,0,LOCATION_MZONE,1,3,e:GetHandler())
end
function c700000005.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
	if tc and tc:IsRelateToEffect(e) then
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_RELEASE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	    tc:RegisterEffect(e1)
	end
tc=g:GetNext()
end
end