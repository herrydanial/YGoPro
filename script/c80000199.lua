--Raidraptor - Devil Eagle
function c80000199.initial_effect(c)
	-- xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xba),3,2)
	c:EnableReviveLimit()
	
	-- damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetDescription(aux.Stringid(80000199,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,80000199)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c80000199.cost)
	e1:SetTarget(c80000199.target)
	e1:SetOperation(c80000199.operation)
	c:RegisterEffect(e1)
end


function c80000199.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c80000199.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c80000199.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c80000199.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80000199.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80000199.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	local batk=tc:GetBaseAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,batk)
end
function c80000199.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local batk=tc:GetBaseAttack()
		local dam=Duel.Damage(1-tp,batk,REASON_EFFECT)
	end
end