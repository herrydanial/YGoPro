--真紅眼の凶雷皇－エビル・デーモン
--Red-Eyes Lightning Lord - Evil Archfiend
function c80100123.initial_effect(c)
	aux.EnableDualAttribute(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80100123,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c80100123.target)
	e1:SetOperation(c80100123.operation)
	c:RegisterEffect(e1)
end
function c80100123.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c73879377.dfilter(c,atk)
	return c:IsFaceup() and c:GetDefence()<atk and c:IsDestructable()
end
function c80100123.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c73879377.dfilter,tp,0,LOCATION_MZONE,nil,e:GetHandler():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c80100123.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c73879377.dfilter,tp,0,LOCATION_MZONE,nil,e:GetHandler():GetAttack())
	Duel.Destroy(g,REASON_EFFECT)
end
