--RR－ミミクリー・レイニアス
function c800000166.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c800000166.lvcon)
	e1:SetTarget(c800000166.lvtg)
	e1:SetOperation(c800000166.lvop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,800000166)
	e2:SetCondition(c800000166.thcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c800000166.thtg)
	e2:SetOperation(c800000166.thop)
	c:RegisterEffect(e2)
	if not c800000166.global_check then
		c800000166.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		ge1:SetLabel(800000166)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(800000166)
		Duel.RegisterEffect(ge2,0)
	end
end
function c800000166.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(800000166)>0
end
function c800000166.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0xba)
end
function c800000166.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c800000166.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c800000166.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c800000166.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c800000166.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()==Duel.GetTurnCount() and not e:GetHandler():IsReason(REASON_RETURN)
end
function c800000166.thfilter(c)
	return c:IsSetCard(0xba) and not c:IsCode(800000166) and c:IsAbleToHand()
end
function c800000166.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c800000166.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c800000166.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c800000166.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
