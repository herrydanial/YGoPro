--Illidan Stormrage
--By DeharaRules
function c1234512345.initial_effect(c)
	--Summon
	aux.AddXyzProcedure(c,nil,4,0)
	c:EnableReviveLimit()
	--Attack Up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41098335,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c1234512345.condition)
	e1:SetOperation(c1234512345.operation)
	c:RegisterEffect(e1)
	--Immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e2:SetValue(c1234512345.efilter)
	c:RegisterEffect(e2)
	--Pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
	--Negate Card Effects
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(61257789,0))
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c1234512345.discon)
	e4:SetTarget(c1234512345.distg)
	e4:SetOperation(c1234512345.disop)
	c:RegisterEffect(e4)
	--Negate Summon
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_SUMMON)
	e5:SetCondition(c1234512345.condition2)
	e5:SetTarget(c1234512345.target2)
	e5:SetOperation(c1234512345.operation2)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e7)
    --Cannot Switch Controller
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e8)
	--Cannot be Target
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	--Destruction Burn
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(82301904,1))
	e10:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e10:SetType(EFFECT_TYPE_QUICK_O)
	e10:SetCode(EVENT_CHAINING)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c1234512345.sgtg)
	e10:SetOperation(c1234512345.sgop)
	c:RegisterEffect(e10)
	--Cannot be Removed
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e11)
	--Cannot Send to Grave
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e12)
	--Cannot Return to Hand
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e13)
	--Cannot Return to Deck
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e14)
	--Cannot be Tributed
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetCode(EFFECT_UNRELEASABLE_SUM)
	e15:SetValue(1)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e16)
	--spsumon_cannot_be_negated
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e17:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e17)
	--Special Summon opponent's turn
	local e18=Effect.CreateEffect(c)
	e18:SetDescription(aux.Stringid(1234512345,0))
	e18:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e18:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e18:SetCode(EVENT_PREDRAW)
	e18:SetRange(LOCATION_EXTRA)
	e18:SetCountLimit(1,1234512345)
	e18:SetCondition(c1234512345.accon)
	e18:SetTarget(c1234512345.actg)
	e18:SetOperation(c1234512345.acop)
	c:RegisterEffect(e18)
	--reflect battle dam
	local e19=Effect.CreateEffect(c)
	e19:SetType(EFFECT_TYPE_SINGLE)
	e19:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e19:SetValue(1)
	c:RegisterEffect(e19)
	--damage conversion
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_FIELD)
	e20:SetCode(EFFECT_REVERSE_DAMAGE)
	e20:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e20:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e20:SetTargetRange(1,0)
	e20:SetValue(c1234512345.rev)
	c:RegisterEffect(e20)
	--extra attack
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_SINGLE)
	e21:SetCode(EFFECT_EXTRA_ATTACK)
	e21:SetValue(200)
	c:RegisterEffect(e21)
	--Add to hand God Creator
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(95004025,1))
	e22:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e22:SetType(EFFECT_TYPE_IGNITION)
	e22:SetRange(LOCATION_MZONE)
	e22:SetTarget(c1234512345.thtg3)
	e22:SetOperation(c1234512345.thop3)
	c:RegisterEffect(e22)
	--Avoid BD
	local e23=Effect.CreateEffect(c)
	e23:SetType(EFFECT_TYPE_SINGLE)
	e23:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e23:SetValue(1)
	c:RegisterEffect(e23)
	--indes Battle
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_SINGLE)
	e24:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e24:SetValue(1)
	c:RegisterEffect(e24)
	--Direct Attack
	local e25=Effect.CreateEffect(c)
	e25:SetType(EFFECT_TYPE_SINGLE)
	e25:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e25)
	--Millennium Eye
	local e26=Effect.CreateEffect(c)
	e26:SetType(EFFECT_TYPE_FIELD)
	e26:SetCode(EFFECT_PUBLIC)
	e26:SetRange(LOCATION_EXTRA+LOCATION_MZONE)
	e26:SetTargetRange(0,LOCATION_HAND+LOCATION_SZONE)
	c:RegisterEffect(e26)
	--Search Final
	local e27=Effect.CreateEffect(c)
	e27:SetDescription(aux.Stringid(94212438,0))
	e27:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e27:SetType(EFFECT_TYPE_QUICK_O)
	e27:SetCode(EVENT_CHAINING)
	e27:SetRange(LOCATION_MZONE)
	e27:SetTarget(c1234512345.thtg2)
	e27:SetOperation(c1234512345.thop2)
	c:RegisterEffect(e27)
	--Disbale Field Spells
	local e28=Effect.CreateEffect(c)
	e28:SetType(EFFECT_TYPE_FIELD)
	e28:SetCode(EFFECT_CANNOT_ACTIVATE)
	e28:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e28:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e28:SetTargetRange(1,1)
	e28:SetValue(c1234512345.dfilter)
	c:RegisterEffect(e28)
	--Unaffected
	local e29=Effect.CreateEffect(c)
	e29:SetType(EFFECT_TYPE_SINGLE)
	e29:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e29:SetRange(LOCATION_MZONE)
	e29:SetCode(EFFECT_IMMUNE_EFFECT)
	e29:SetValue(c1234512345.unaffectedval)
	c:RegisterEffect(e29)
	--SPSummon Gods
	local e30=Effect.CreateEffect(c)
	e30:SetDescription(aux.Stringid(10000080,2))
	e30:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e30:SetType(EFFECT_TYPE_IGNITION)
	e30:SetRange(LOCATION_MZONE)
	e30:SetCountLimit(1,1234512345)
	e30:SetTarget(c1234512345.sptg)
	e30:SetOperation(c1234512345.spop)
	c:RegisterEffect(e30)
	--Counter Exodia
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_FIELD)
	e31:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e31:SetCode(EFFECT_FORBIDDEN)
	e31:SetRange(LOCATION_EXTRA+LOCATION_MZONE)
	e31:SetTargetRange(0x7f,0x7f)
	e31:SetTarget(c1234512345.distg2)
	c:RegisterEffect(e31)
	--Counter Death
	local e32=Effect.CreateEffect(c)
	e32:SetType(EFFECT_TYPE_FIELD)
	e32:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e32:SetCode(EFFECT_FORBIDDEN)
	e32:SetRange(LOCATION_EXTRA+LOCATION_MZONE)
	e32:SetTargetRange(0x7f,0x7f)
	e32:SetTarget(c1234512345.distg3)
	c:RegisterEffect(e32)
	--cannot lose (damage)
    local e33=Effect.CreateEffect(c)
    e33:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e33:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e33:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
    e33:SetCode(EVENT_DAMAGE)
    e33:SetCondition(c1234512345.surcon1)
    e33:SetOperation(c1234512345.surop1)
    c:RegisterEffect(e33)
	--cannot lose (deckout)
    local e34=Effect.CreateEffect(c)
    e34:SetType(EFFECT_TYPE_FIELD)
    e34:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e34:SetCode(EFFECT_DRAW_COUNT)
    e34:SetTargetRange(1,0)
    e34:SetValue(0)
    e34:SetCondition(c1234512345.surcon3)
    e34:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
    c:RegisterEffect(e34)
    --lp check
    local e35=Effect.CreateEffect(c)
    e35:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e35:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e35:SetCode(EVENT_ADJUST)
    e35:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
    e35:SetOperation(c1234512345.surop2)
    c:RegisterEffect(e35)
    local e36=Effect.CreateEffect(c)
    e36:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e36:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e36:SetCode(EVENT_CHAIN_SOLVED)
    e36:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
    e36:SetOperation(c1234512345.surop2)
    c:RegisterEffect(e36)
	--Add Kaiju to hand
	local e37=Effect.CreateEffect(c)
	e37:SetDescription(aux.Stringid(99330325,1))
	e37:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e37:SetType(EFFECT_TYPE_IGNITION)
	e37:SetRange(LOCATION_MZONE)
	e37:SetTarget(c1234512345.thtg4)
	e37:SetOperation(c1234512345.thop4)
	c:RegisterEffect(e37)
	--No Cost
	local e38=Effect.CreateEffect(c)
	e38:SetType(EFFECT_TYPE_FIELD)
	e38:SetCode(EFFECT_LPCOST_CHANGE)
	e38:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e38:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e38:SetTargetRange(1,0)
	e38:SetValue(c1234512345.costchange)
	c:RegisterEffect(e38)
	local e39=Effect.CreateEffect(c)
	e39:SetType(EFFECT_TYPE_FIELD)
	e39:SetCode(EFFECT_DISCARD_COST_CHANGE)
	e39:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e39:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e39:SetTargetRange(1,0)
	c:RegisterEffect(e39)
	--Activate SP/TR From Hand
	local e40=Effect.CreateEffect(c)
	e40:SetType(EFFECT_TYPE_FIELD)
	e40:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e40:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e40:SetTargetRange(LOCATION_HAND,0)
	c:RegisterEffect(e40)
	local e41=e40:Clone()
	e41:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e41)
	--Trap Search Loop
	local e42=Effect.CreateEffect(c)
	e42:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e42:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e42:SetCode(EVENT_LEAVE_FIELD)
	e42:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e42:SetCondition(c1234512345.thcon)
	e42:SetTarget(c1234512345.thtg)
	e42:SetOperation(c1234512345.thop)
	c:RegisterEffect(e42)
	--Spell Search Loop
	local e43=Effect.CreateEffect(c)
	e43:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e43:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e43:SetCode(EVENT_LEAVE_FIELD)
	e43:SetRange(LOCATION_MZONE+LOCATION_EXTRA)
	e43:SetCondition(c1234512345.thcon2)
	e43:SetTarget(c1234512345.thtg2)
	e43:SetOperation(c1234512345.thop2)
	c:RegisterEffect(e43)
end
function c1234512345.unaffectedval(e,te)
	local c=te:GetHandler()
	return not c:IsCode(1234512345) and not c:IsCode(53569894)
end
function c1234512345.distg3(e,c)
	return c:IsCode(14)
end
function c1234512345.distg2(e,c)
	return c:IsCode(33396948)
end
function c1234512345.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end
function c1234512345.accon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0
end
function c1234512345.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end	
end
function c1234512345.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c then
		Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		Duel.RaiseEvent(c,EVENT_CHAIN_SOLVED,c:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c1234512345.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c1234512345.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (d~=nil and a:GetControler()==tp and a:IsRelateToBattle())
		or (d~=nil and d:GetControler()==tp and d:IsFaceup() and d:IsRelateToBattle())
end
function c1234512345.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	if a:GetControler()==tp then
		e1:SetValue(d:GetAttack())
		a:RegisterEffect(e1)
	else
		e1:SetValue(a:GetAttack())
		d:RegisterEffect(e1)
	end
end
function c1234512345.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler()~=e:GetHandler() and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c1234512345.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c1234512345.disop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateActivation(ev) then return end
	if re:GetHandler():IsRelateToEffect(re) then 
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c1234512345.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c1234512345.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c1234512345.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c1234512345.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,0xe,0xe)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,g:GetCount()*300)
end
function c1234512345.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0xe,0xe)
	Duel.SendtoGrave(g,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
	Duel.BreakEffect()
	Duel.Damage(1-tp,ct*96234723,REASON_EFFECT)
end
function c1234512345.thfilter2(c,tp)
	return c:IsCode(94212438)
		and (c:IsAbleToHand() or c:GetActivateEffect():IsActivatable(tp))
end
function c1234512345.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1234512345.thfilter2,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1234512345.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(58984738,3))
	local g=Duel.SelectMatchingCard(tp,c1234512345.thfilter2,tp,LOCATION_DECK,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc then
		local b1=tc:IsAbleToHand()
		local b2=tc:GetActivateEffect():IsActivatable(tp)
		if b1 and (not b2 or Duel.SelectOption(tp,1190,1150)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local te=tc:GetActivateEffect()
			local tep=tc:GetControler()
			local cost=te:GetCost()
			if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		end
	end
end
function c1234512345.filter(c,e,tp)
	return c:IsCode(10000000) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c1234512345.filter2(c,e,tp)
	return c:IsCode(10000010) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c1234512345.filter3(c,e,tp)
	return c:IsCode(10000020) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c1234512345.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1234512345.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c1234512345.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c1234512345.filter3,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_DECK+LOCATION_HAND)
end
function c1234512345.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1234512345.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c1234512345.filter2,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
		if g2:GetCount()>0 then
			Duel.BreakEffect() 
			Duel.SpecialSummon(g2,0,tp,tp,true,false,POS_FACEUP)
		end
		local g3=Duel.SelectMatchingCard(tp,c1234512345.filter3,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
		if g3:GetCount()>0 then
			Duel.BreakEffect() 
			Duel.SpecialSummon(g3,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
function c1234512345.filter4(c)
	return c:IsCode(10000040) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c1234512345.thtg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1234512345.filter4,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1234512345.thop3(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1234512345.filter4,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1234512345.dfilter(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c1234512345.surcon1(e,tp,eg,ep,ev,re,r,rp)
return ep==tp and Duel.GetLP(tp)<=0
end
function c1234512345.surop1(e,tp,eg,ep,ev,re,r,rp)
Duel.SetLP(tp,1)
end
function c1234512345.surop2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if Duel.GetLP(tp)<=0 and not c:IsStatus(STATUS_DISABLED) then
Duel.SetLP(tp,1)
end
if Duel.GetLP(tp)==1 and c:IsStatus(STATUS_DISABLED) then
Duel.SetLP(tp,0)
end
end
function c1234512345.surcon3(e,tp,eg,ep,ev,re,r,rp)
local p=e:GetHandler():GetControler()
return Duel.GetFieldGroupCount(p,LOCATION_DECK,0)==0
end
function c1234512345.filter5(c)
	return c:IsSetCard(0xd3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c1234512345.thtg4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1234512345.filter5,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1234512345.thop4(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1234512345.filter5,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1234512345.costchange(e,re,rp,val)
	if re and re:IsHasType(EFFECT_TYPE_ACTIVATE) then
		return 0
	else
		return val
	end
end
function c1234512345.thcfilter(c,tp)
	return c:IsType(TYPE_TRAP)
		and c:GetPreviousControler()==tp and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousLocation(LOCATION_SZONE)
end
function c1234512345.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1234512345.thcfilter,1,nil,tp)
end
function c1234512345.thfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c1234512345.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1234512345.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1234512345.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1234512345.thcfilter2(c,tp)
	return c:IsType(TYPE_SPELL)
		and c:GetPreviousControler()==tp and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousLocation(LOCATION_SZONE)
end
function c1234512345.thcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1234512345.thcfilter2,1,nil,tp)
end
function c1234512345.thfilter2(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c1234512345.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1234512345.thop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1234512345.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end