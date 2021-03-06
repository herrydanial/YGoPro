--妖仙獣の秘技
function c80100109.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c80100109.condition)
	e1:SetTarget(c80100109.target)
	e1:SetOperation(c80100109.activate)
	c:RegisterEffect(e1)
end
function c80100109.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xb3)
end
function c80100109.cfilter1(c)
	return c:IsFaceup() and not c:IsSetCard(0xb3)
end
function c80100109.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c80100109.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
		or Duel.IsExistingMatchingCard(c80100109.cfilter1,tp,LOCATION_MZONE,0,1,nil)
	then return false end
	return Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c80100109.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c80100109.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
