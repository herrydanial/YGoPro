--法眼の魔術師
function c800000317.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--change scale
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(800000317,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c800000317.sctg)
	e2:SetOperation(c800000317.scop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(c800000317.sumsuc)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c800000317.indcon)
	e4:SetTarget(c800000317.indtg)
	e4:SetValue(aux.indoval)
	c:RegisterEffect(e4)
end
function c800000317.cfilter(c,tp)
	return c:IsType(TYPE_PENDULUM) and not c:IsPublic()
		and Duel.IsExistingTarget(c800000317.scfilter,tp,LOCATION_PZONE,0,1,nil,c)
end
function c800000317.scfilter(c,pc)
	return c:IsSetCard(0x98) and c:GetLeftScale()~=pc:GetLeftScale()
end
function c800000317.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_PZONE) and c800000317.scfilter(chkc,e:GetLabelObject()) end
	if chk==0 then return Duel.IsExistingMatchingCard(c800000317.cfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c800000317.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.ConfirmCards(1-tp,cg)
	Duel.ShuffleHand(tp)
	e:SetLabelObject(cg:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c800000317.scfilter,tp,LOCATION_PZONE,0,1,1,nil,cg:GetFirst())
end
function c800000317.scop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local pc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(pc:GetLeftScale())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		e2:SetValue(pc:GetRightScale())
		tc:RegisterEffect(e2)
	end
end
function c800000317.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(800000317,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end
function c800000317.indcon(e)
	local c=e:GetHandler()
	return c:GetFlagEffect(800000317)~=0 and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c800000317.indtg(e,c)
	return c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM)
end
