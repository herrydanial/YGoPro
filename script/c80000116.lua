--Performage Higurumi
function c80000116.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	
	-- spsummon p zone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80000116,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,80000116)
	e2:SetCondition(c80000116.spcon)
	e2:SetTarget(c80000116.sptg)
	e2:SetOperation(c80000116.spop)
	c:RegisterEffect(e2)
	
	-- spsummon mon eff
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(80000116,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c80000116.condition)
	e3:SetTarget(c80000116.target)
	e3:SetOperation(c80000116.operation)
	c:RegisterEffect(e3)
end

--spsummon p zone
function c80000116.cfilter(c,tp)
	return c:IsSetCard(0xc6) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c80000116.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c80000116.cfilter,1,nil,tp)
end
function c80000116.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c80000116.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) then
			Duel.BreakEffect()
			Duel.Damage(tp,500,REASON_EFFECT)
		end
	end
end

--spsummon mon eff
function c80000116.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp
end
function c80000116.filter(c,e,tp)
	return c:IsSetCard(0xc6) and not c:IsCode(80000116) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80000116.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c80000116.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c80000116.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c80000116.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end