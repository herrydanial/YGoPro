--悪魔竜ブラック・デーモンズ・ドラゴン
--Black Dragon Archfiend
function c80100148.initial_effect(c)
	--fusion material
	c:SetSPSummonOnce(80100148)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(c80100148.fusfilter1),aux.FilterBoolFunction(c80100148.fusfilter2),true)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c80100148.aclimit)
	e1:SetCondition(c80100148.actcon)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80100148,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c80100148.damcon)
	e2:SetTarget(c80100148.damtg)
	e2:SetOperation(c80100148.damop)
	c:RegisterEffect(e2)
end
function c80100148.fusfilter1(c)
	return c:GetLevel()==6 and c:IsType(TYPE_NORMAL) and c:IsSetCard(0x45)
end
function c80100148.fusfilter2(c)
	return c:IsType(TYPE_NORMAL) and c:IsSetCard(0x3b)
end
function c80100148.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c80100148.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c80100148.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0 and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c80100148.tgfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsSetCard(0x3b) and c:IsAbleToDeck()
end
function c80100148.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetControler()==tp and chkc:IsLocation(LOCATION_GRAVE) and c80100148.tgfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c80100148.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetBaseAttack())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c80100148.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)>0 then
		Duel.BreakEffect()
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
