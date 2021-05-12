--Ultimate Xyz
--scripted by:urielkama
--cleaned and fixed by MLD
function c511004124.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511004124.cost)
	e1:SetTarget(c511004124.target)
	e1:SetOperation(c511004124.operation)
	c:RegisterEffect(e1)
end
function c511004124.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c511004124.cfilter(c,tp)
	local g=c:GetOverlayGroup()
	local sum=0
	local gc=g:GetFirst()
    while gc do
       	local atk=gc:GetAttack()
       	if atk<0 then atk=0 end
       	sum=sum+atk
       	gc=g:GetNext()
    end
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and g:GetCount()>0 
		and Duel.IsExistingTarget(c511004124.filter,tp,0,LOCATION_MZONE,1,nil,sum)
end
function c511004124.filter(c,sum)
	return c:GetAttack()<sum
end
function c511004124.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local sum=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
		return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511004124.filter(chkc,sum) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511004124.cfilter,tp,LOCATION_MZONE,0,1,nil,tp)
	end
	e:SetLabel(0)
	local tc=Duel.SelectMatchingCard(tp,c511004124.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	local og=tc:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_COST)
	local sum=0
	local gc=og:GetFirst()
	while gc do
		local atk=gc:GetAttack()
		if atk<0 then atk=0 end
		sum=sum+atk
		gc=og:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511004124.filter,tp,0,LOCATION_MZONE,1,1,nil,sum)
	Duel.SetTargetParam(sum)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetAttack())
end
function c511004124.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
 		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
 			if atk<0 then atk=0 end
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
 	end
end
 