--ドラゴンに乗るワイバーン
function c700000118.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,700000084,700000083,true,true)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c700000118.dircon)
	c:RegisterEffect(e2)
end
function c700000118.filter(c)
	return c:IsFaceup() and c:IsAttribute(0xf8)
end
function c700000118.dircon(e)
	return not Duel.IsExistingMatchingCard(c700000118.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
