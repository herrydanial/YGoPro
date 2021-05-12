--Magispecter Tempest
function c80000171.initial_effect(c)
	-- neg Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80000171,0))
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c80000171.sumcon)
	e1:SetCost(c80000171.cost)
	e1:SetTarget(c80000171.sumtg)
	e1:SetOperation(c80000171.sumop)
	c:RegisterEffect(e1)
	
	-- neg Effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80000171,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c80000171.effcon)
	e2:SetCost(c80000171.cost)
	e2:SetTarget(c80000171.efftg)
	e2:SetOperation(c80000171.effop)
	c:RegisterEffect(e2)
end

function c80000171.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_SPELLCASTER)
end
function c80000171.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c80000171.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c80000171.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end

--neg Summon
function c80000171.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c80000171.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c80000171.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end

--neg Effect
function c80000171.effcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c80000171.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c80000171.effop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()~=ev+1 then return	end
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end