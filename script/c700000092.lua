--バーバリアン1号
function c700000092.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c700000092.value)
	c:RegisterEffect(e1)
end
function c700000092.filter(c)
	return c:IsFaceup() and c:IsCode(700000091)
end
function c700000092.value(e,c)
	return Duel.GetMatchingGroupCount(c700000092.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
