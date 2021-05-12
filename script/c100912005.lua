--EM小判竜
--Performapal Drago Remora
--Script by nekrozar
function c100912005.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100912005,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c100912005.condition)
	e1:SetTarget(c100912005.target)
	e1:SetOperation(c100912005.operation)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100912005.atktg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--indes
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c100912005.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c100912005.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:GetSummonLocation()==LOCATION_EXTRA
end
function c100912005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c100912005.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100912005.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c100912005.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100912005.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLED)
		e1:SetOwnerPlayer(tp)
		e1:SetCondition(c100912005.rmcon)
		e1:SetOperation(c100912005.rmop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
function c100912005.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tp==e:GetOwnerPlayer() and tc and tc:IsControler(1-tp)
end
function c100912005.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c100912005.atktg(e,c)
	return c:IsRace(RACE_DRAGON) and c~=e:GetHandler()
end