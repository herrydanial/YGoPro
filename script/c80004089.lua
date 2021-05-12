--Kaiju Capture Mission
function c80004089.initial_effect(c)
	c:SetCounterLimit(0x37,3)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80004089.apostg)
	e1:SetOperation(c80004089.posop)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80004089,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c80004089.poscon)
	e2:SetTarget(c80004089.postg)
	e2:SetOperation(c80004089.posop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(80004089,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,80004089)
	e3:SetCondition(c80004089.condition)
	e3:SetTarget(c80004089.target)
	e3:SetOperation(c80004089.operation)
	c:RegisterEffect(e3)
end

function c80004089.poscon(e)
	return e:GetHandler():GetCounter(0x37)<3
end
function c80004089.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet() and c:IsSetCard(0xd3)
end
function c80004089.apostg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c80004089.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80004089.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	if e:GetHandler():GetCounter(0x37)<3 and Duel.SelectYesNo(tp,aux.Stringid(80004089,0)) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectTarget(tp,c80004089.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
		e:GetHandler():RegisterFlagEffect(80004089,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	else e:SetProperty(0) end
end
function c80004089.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c80004089.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80004089.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
		and e:GetHandler():GetFlagEffect(80004089)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80004089.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(80004089,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c80004089.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if Duel.ChangePosition(tc,POS_FACEDOWN_DEFENCE) then
			e:GetHandler():AddCounter(0x37,1)
		end
	end
end

function c80004089.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_DESTROY+REASON_EFFECT)==REASON_DESTROY+REASON_EFFECT and rp==1-tp
end
function c80004089.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c80004089.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end