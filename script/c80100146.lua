--ＤＤＤ神託王ダルク
--D/D/D D'Arc the Oracle Overlord
function c80100146.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0xaf),2,true)
	--damage conversion
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c80100146.rev)
	c:RegisterEffect(e1)
end
function c80100146.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)>0
end