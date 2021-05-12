--Flower Diva the Melodious Maestra
function c55555.initial_effect(c)
	--Summon
	aux.AddXyzProcedure(c,nil,4,0)
	c:EnableReviveLimit()
	--Damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(55555,1))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,55555)
	e5:SetCondition(c55555.damcon)
	e5:SetTarget(c55555.damtg)
	e5:SetOperation(c55555.damop)
	c:RegisterEffect(e5)
	--Immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c55555.efilter)
	c:RegisterEffect(e2)
	--Cannot be Target
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(1)
	c:RegisterEffect(e9)
    --Cannot be Destroyed by Card Effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e10:SetValue(1)
	c:RegisterEffect(e10)
	--Cannot be Removed
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e11)
	--Cannot Send to Grave
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e12)
	--Cannot Return to Hand
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e13)
	--Cannot Return to Deck
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e14)
	--Cannot be Tributed
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetCode(EFFECT_UNRELEASABLE_SUM)
	e15:SetValue(1)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e16)
end
function c55555.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c55555.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,55555)
end
function c55555.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,55555,REASON_EFFECT,true)
	Duel.Damage(1-tp,55555,REASON_EFFECT,true)
	Duel.RDComplete()
end
function c55555.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c55555.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end