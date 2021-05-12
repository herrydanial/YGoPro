--バーバリアン2号
function c700000091.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c700000091.value)
	c:RegisterEffect(e1)
end
function c700000091.filter(c)
	return c:IsFaceup() and c:IsCode(700000092)
end
function c700000091.value(e,c)
	return Duel.GetMatchingGroupCount(c700000091.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
