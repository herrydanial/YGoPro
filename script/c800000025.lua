--ブラック・マジシャン・ガール
function c800000025.initial_effect(c)
	aux.AddCodeList(c,46986414)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c800000025.val)
	c:RegisterEffect(e1)
end
function c800000025.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil,30208479,46986414)*300
end
