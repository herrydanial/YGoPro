--Cyber Harpie Lady
function c840000006.initial_effect(c)
    --change name
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND)
	e1:SetValue(76812113)
	c:RegisterEffect(e1)
end