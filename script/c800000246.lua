--バスター・ブレイダー
function c800000246.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c800000246.val)
	c:RegisterEffect(e1)
end
function c800000246.val(e,c)
	return Duel.GetMatchingGroupCount(c800000246.filter,c:GetControler(),0,LOCATION_GRAVE+LOCATION_MZONE,nil)*500
end
function c800000246.filter(c)
	return c:IsRace(RACE_DRAGON) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
