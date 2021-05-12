--アロマージ－ローズマリー
--Aromage Rosemary
function c80100136.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c80100136.aclimit)
	e1:SetCondition(c80100136.actcon)
	c:RegisterEffect(e1)
	--adchange
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80100136,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RECOVER)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c80100136.con)
	e2:SetTarget(c80100136.tg)
	e2:SetOperation(c80100136.op)
	c:RegisterEffect(e2)
end
function c80100136.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e) and re:IsActiveType(TYPE_MONSTER)
end
function c80100136.actcon(e)
	local tp=e:GetHandlerPlayer()
	local att=Duel.GetAttacker()
	return Duel.GetLP(tp)>Duel.GetLP(1-tp) and att:IsControler(tp) and c:IsRace(RACE_PLANT)
end
function c80100136.con(e,tp,eg,ep,ev,re,r,rp)
	return tp==ep
end
function c80100136.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c80100136.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENCE,POS_FACEDOWN_DEFENCE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end