--真青眼の究極竜
function c56532353.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,3,true,true)
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCountLimit(2,56532353)
	e1:SetCondition(c56532353.atcon)
	e1:SetCost(c56532353.atcost)
	e1:SetOperation(c56532353.atop)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
--	e2:SetCondition(c56532353.condition)
	e2:SetCost(c56532353.cost)
	e2:SetTarget(c56532353.target)
	e2:SetOperation(c56532353.operation)
	c:RegisterEffect(e2)
	
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
--	e3:SetValue(1)
	c:RegisterEffect(e3)
	
		--special summon rule
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetCondition(c56532353.spcon)
	e4:SetOperation(c56532353.spop)
	c:RegisterEffect(e4)
end
function c56532353.spfilter(c,fc)
	return c:IsFusionCode(89631139) and c:IsCanBeFusionMaterial(fc) and c:IsAbleToGraveAsCost()
end
function c56532353.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c56532353.spfilter,tp,LOCATION_MZONE,0,3,nil,c)
end
function c56532353.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c56532353.spfilter,tp,LOCATION_MZONE,0,2,3,nil,c)
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_COST)
end
function c56532353.costfilter(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c56532353.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and Duel.GetAttacker()==c and c:IsChainAttackable(0)
		and not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,c)
end
function c56532353.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56532353.costfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c56532353.costfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c56532353.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c56532353.filter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsSetCard(0xdd)
end
function c56532353.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c56532353.filter,1,nil,tp)
		and Duel.IsChainNegatable(ev)
end
function c56532353.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
--	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.SendtoHand(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c56532353.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c56532353.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
