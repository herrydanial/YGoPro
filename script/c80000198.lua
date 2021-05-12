--Great Horn of Heaven
function c80000198.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c80000198.condition)
	e1:SetTarget(c80000198.target)
	e1:SetOperation(c80000198.activate)
	c:RegisterEffect(e1)
end
function c80000198.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return tp~=ep and Duel.GetCurrentChain()==0 and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c80000198.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c80000198.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	Duel.BreakEffect()
	if Duel.IsPlayerCanDraw(1-tp,1) and Duel.Draw(1-tp,1,REASON_EFFECT) then
		local ph=Duel.GetCurrentPhase()
		if ph==PHASE_MAIN1 then
			Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_MAIN1,1)
		else
			Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_MAIN2,1)
		end
	end
end