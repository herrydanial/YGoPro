--体力増強剤スーパーZ
function c700000111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c700000111.condition)
	e1:SetTarget(c700000111.target)
	e1:SetOperation(c700000111.activate)
	c:RegisterEffect(e1)
end
function c700000111.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetBattleDamage(tp)>=2000
end
function c700000111.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,4000)
end
function c700000111.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,4000,REASON_EFFECT)
end
