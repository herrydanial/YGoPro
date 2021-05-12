--Blue-Eyes Twin Burst Dragon
function c80003111.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,2,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c80003111.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c80003111.sprcon)
	e2:SetOperation(c80003111.sprop)
	c:RegisterEffect(e2)
	--battle immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--attack twice
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e5:SetCondition(c80003111.dircon)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_ATTACK)
	e6:SetCondition(c80003111.atkcon)
	c:RegisterEffect(e6)
	--banish
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(80003111,0))
	e7:SetCategory(CATEGORY_REMOVE)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_DAMAGE_STEP_END)
	e7:SetCondition(c80003111.descon)
	e7:SetTarget(c80003111.destg)
	e7:SetOperation(c80003111.desop)
	c:RegisterEffect(e7)
end

function c80003111.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION 
		or (Duel.IsExistingMatchingCard(c80003111.sprfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,2,nil,e:GetHandler()) and e:GetHandler():IsLocation(LOCATION_EXTRA))
end
function c80003111.sprfilter(c,fc)
	return c:IsCode(89631139) and c:IsAbleToGraveAsCost() and c:IsCanBeFusionMaterial(fc)
end
function c80003111.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c80003111.sprfilter,tp,LOCATION_MZONE,0,2,nil,c)
end
function c80003111.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c80003111.sprfilter,tp,LOCATION_MZONE,0,2,2,nil,c)
	c:SetMaterial(g1)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c80003111.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c80003111.atkcon(e)
	return e:GetHandler():IsDirectAttacked()
end

function c80003111.descon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==Duel.GetAttacker() and d and d:IsRelateToBattle()
end
function c80003111.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackTarget():IsAbleToRemove() and Duel.GetAttackTarget():IsLocation(LOCATION_ONFIELD) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,Duel.GetAttackTarget(),1,0,0)
end
function c80003111.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		Duel.Remove(d,POS_FACEUP,REASON_EFFECT)
	end
end