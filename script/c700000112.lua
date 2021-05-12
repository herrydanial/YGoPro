--奈落の落とし穴
function c700000112.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c700000112.target)
	e1:SetOperation(c700000112.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e2:SetTarget(c700000112.target)
	e2:SetOperation(c700000112.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c700000112.target2)
	e3:SetOperation(c700000112.activate2)
	c:RegisterEffect(e3)
end
function c700000112.filter(c,tp,ep)
	return c:IsFaceup() and c:GetAttack()>=1500
		and ep~=tp and c:IsDestructable() and c:IsAbleToRemove()
end
function c700000112.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return c700000112.filter(tc,tp,ep) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
end
function c700000112.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>=1500 then
		Duel.Destroy(tc,REASON_EFFECT,LOCATION_REMOVED)
	end
end
function c700000112.filter2(c,tp)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:GetSummonPlayer()~=tp
		and c:IsDestructable() and c:IsAbleToRemove()
end
function c700000112.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c700000112.filter2,1,nil,tp) end
	local g=eg:Filter(c700000112.filter2,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c700000112.filter3(c,e,tp)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:GetSummonPlayer()~=tp
		and c:IsRelateToEffect(e) and c:IsLocation(LOCATION_MZONE) and c:IsDestructable()
end
function c700000112.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c700000112.filter3,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT,LOCATION_REMOVED)
	end
end
