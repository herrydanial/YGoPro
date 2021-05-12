--Swordsman of Doom Lithmus
function c12388.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c12388.efilter)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--change attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c12388.condition)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetValue(3000)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c12388.condition)
	e4:SetCode(EFFECT_SET_DEFENCE)
	e4:SetValue(3000)
	c:RegisterEffect(e4)
end
function c12388.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end

function c12388.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP)
end
function c12388.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c12388.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end