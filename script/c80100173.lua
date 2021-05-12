--イグナイト・バースト
--Igknight Burst
function c80100173.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80100173.target1)
	e1:SetOperation(c80100173.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80100173,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c80100173.condition)
	e2:SetTarget(c80100173.target2)
	e2:SetOperation(c80100173.operation)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	-- tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetDescription(aux.Stringid(80100173,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c80100173.thcon)
	e3:SetTarget(c80100173.thtg)
	e3:SetOperation(c80100173.thop)
	c:RegisterEffect(e3)
end
function c80100173.desfilter(c)
	return c:IsSetCard(0xc7) and c:IsDestructable()
end
function c80100173.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tn=Duel.GetTurnPlayer()
	local ph=Duel.GetCurrentPhase()
	local g=Duel.GetMatchingGroup(c80100133.desfilter,tp,LOCATION_ONFIELD,0,nil)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
		
	if (tn==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)) 
		and g:GetCount()>0
		and g1:GetCount()>1
		and Duel.SelectYesNo(tp,aux.Stringid(80100173,1)) then
		e:GetHandler():RegisterFlagEffect(80100173,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(80100173,2))
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,1,0,0)
	end
end
function c80100173.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c80100173.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(80100173)==0 
		and Duel.IsExistingMatchingCard(c80100133.desfilter,tp,LOCATION_ONFIELD,0,1,nil) 
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c80100133.desfilter,tp,LOCATION_ONFIELD,0,nil)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
	e:GetHandler():RegisterFlagEffect(80100173,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,1,0,0)
end
function c80100173.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(80100173)==0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c80100133.desfilter,tp,LOCATION_ONFIELD,0,1,3,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		local ct=Duel.Destroy(g,REASON_EFFECT)
		if ct>0 then
			local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,ct,ct,nil)
			if g1 then 
				Duel.BreakEffect()
				Duel.HintSelection(g1)
				local ct=Duel.SendtoHand(g1,nil,REASON_EFFECT)
			end
		end
	end
end
function c80100173.thcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c80100173.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc7) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c80100173.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c4450854.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c80100173.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c4450854.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

