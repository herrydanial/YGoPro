--バスター·ブレイダー
function c700000048.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c700000048.val)
	c:RegisterEffect(e1)
end
function c700000048.val(e,c)
	return Duel.GetMatchingGroupCount(c700000048.filter,c:GetControler(),0,LOCATION_GRAVE+LOCATION_MZONE,nil)*500
end
function c700000048.filter(c)
	return c:IsRace(RACE_DRAGON) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
