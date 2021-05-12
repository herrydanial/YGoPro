--法眼の魔術師
function c850000004.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--change scale
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(850000004,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c850000004.sctg)
	e2:SetOperation(c850000004.scop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(c850000004.sumsuc)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c850000004.indcon)
	e4:SetTarget(c850000004.indtg)
	e4:SetValue(aux.indoval)
	c:RegisterEffect(e4)
end
function c850000004.cfilter(c,tp)
	return c:IsType(TYPE_PENDULUM) and not c:IsPublic()
		and Duel.IsExistingTarget(c850000004.scfilter,tp,LOCATION_PZONE,0,1,nil,c)
end
function c850000004.scfilter(c,pc)
	return c:IsSetCard(0x98) and c:GetLeftScale()~=pc:GetLeftScale()
end
function c850000004.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_PZONE) and c850000004.scfilter(chkc,e:GetLabelObject()) end
	if chk==0 then return Duel.IsExistingMatchingCard(c850000004.cfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c850000004.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.ConfirmCards(1-tp,cg)
	Duel.ShuffleHand(tp)
	e:SetLabelObject(cg:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c850000004.scfilter,tp,LOCATION_PZONE,0,1,1,nil,cg:GetFirst())
end
function c850000004.scop(e,tp,eg,ep,ev,re,r,rp)
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
function c850000004.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(850000004,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end
function c850000004.indcon(e)
	local c=e:GetHandler()
	return c:GetFlagEffect(850000004)~=0 and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c850000004.indtg(e,c)
	return c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM)
end
