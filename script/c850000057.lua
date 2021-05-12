--SNo.0 ホープ・ゼアル
function c850000057.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedureLevelFree(c,c850000057.mfilter,c850000057.xyzcheck,3,3,c850000057.ovfilter,aux.Stringid(850000057,0),c850000057.xyzop)
	--cannot disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(c850000057.effcon)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c850000057.effcon2)
	e3:SetOperation(c850000057.spsumsuc)
	c:RegisterEffect(e3)
	--atk & def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c850000057.atkval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
	--activate limit
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(850000057,1))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetRange(LOCATION_MZONE)
	e6:SetHintTiming(0,TIMING_DRAW_PHASE)
	e6:SetCountLimit(1)
	e6:SetCondition(c850000057.actcon)
	e6:SetCost(c850000057.actcost)
	e6:SetOperation(c850000057.actop)
	c:RegisterEffect(e6)
end
c850000057.xyz_number=0
function c850000057.mfilter(c,xyzc)
	return c:IsFaceup() and c:IsXyzType(TYPE_XYZ) and c:IsSetCard(0x48)
end
function c850000057.xyzcheck(g)
	return g:GetClassCount(Card.GetRank)==1
end
function c850000057.cfilter(c)
	return c:IsSetCard(0x95) and c:GetType()==TYPE_SPELL and c:IsDiscardable()
end
function c850000057.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c850000057.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c850000057.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c850000057.cfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c850000057.effcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c850000057.effcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c850000057.spsumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c850000057.chlimit)
end
function c850000057.chlimit(e,ep,tp)
	return tp==ep
end
function c850000057.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c850000057.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c850000057.actcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c850000057.actop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(aux.TRUE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
