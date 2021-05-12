--アロマージ－ローズマリー
function c800000188.initial_effect(c)
	--active limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c800000188.accon)
	e1:SetValue(c800000188.actlimit)
	c:RegisterEffect(e1)
	--position change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RECOVER)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c800000188.poscon)
	e2:SetTarget(c800000188.postg)
	e2:SetOperation(c800000188.posop)
	c:RegisterEffect(e2)
end
function c800000188.accon(e)
	local tp=e:GetHandlerPlayer()
	local ac=Duel.GetAttacker()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp) and ac and ac:IsControler(tp) and ac:IsRace(RACE_PLANT)
end
function c800000188.actlimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c800000188.poscon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c800000188.filter(c)
	return c:IsFaceup() and c:IsCanChangePosition()
end
function c800000188.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c800000188.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c800000188.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c800000188.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
