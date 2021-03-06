--トライゲート・ウィザード
--Trigate Wizard
--Script by mercury233
function c100332042.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c100332042.matfilter,2)
	c:EnableReviveLimit()
	--double damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100332042.damcon)
	e1:SetOperation(c100332042.damop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100332042,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c100332042.rmcon)
	e2:SetTarget(c100332042.rmtg)
	e2:SetOperation(c100332042.rmop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100332042,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c100332042.negcon)
	e3:SetTarget(c100332042.negtg)
	e3:SetOperation(c100332042.negop)
	c:RegisterEffect(e3)
	--
	if not Card.GetMutualLinkedGroup then
		function aux.mutuallinkfilter(c,mc)
			local lg=c:GetLinkedGroup()
			return lg and lg:IsContains(mc)
		end
		function Card.GetMutualLinkedGroup(c)
			local lg=c:GetLinkedGroup()
			if not lg then return nil end
			return lg:Filter(aux.mutuallinkfilter,nil,c)
		end
		function Card.GetMutualLinkedCount(c)
			local lg=c:GetLinkedGroup()
			if not lg then return 0 end
			return lg:FilterCount(aux.mutuallinkfilter,nil,c)
		end
	end
end
function c100332042.matfilter(c)
	return not c:IsType(TYPE_TOKEN)
end
function c100332042.damcon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetMutualLinkedGroup()
	local tc=eg:GetFirst()
	return ep~=tp and lg:IsContains(tc) and tc:GetBattleTarget()~=nil
end
function c100332042.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
function c100332042.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedCount()>=2
end
function c100332042.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c100332042.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c100332042.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and c:GetMutualLinkedCount()>=3 and Duel.IsChainNegatable(ev)
end
function c100332042.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c100332042.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
