--Thanos
--By DeharaRules
function c500.initial_effect(c)
    --Summon
	aux.AddXyzProcedure(c,nil,4,0)
	c:EnableReviveLimit()
	--Mind Stone (Mind Control)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(80117527,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e1:SetTarget(c500.target)
	e1:SetOperation(c500.operation)
	c:RegisterEffect(e1)
	--Power Stone (Boost Atk)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56832966,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCountLimit(1,500)
	e2:SetOperation(c500.atkop)
	c:RegisterEffect(e2)
	--Reality Stone (Add Card)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95004025,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e3:SetTarget(c500.target2)
	e3:SetOperation(c500.activate)
	c:RegisterEffect(e3)
	--Space Stone (Move My Monster)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(97729135,1))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e4:SetTarget(c500.seqtg)
	e4:SetOperation(c500.seqop)
	c:RegisterEffect(e4)
	--Space Stone (Move Opp Monster)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(97729135,0))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e5:SetTarget(c500.seqtg2)
	e5:SetOperation(c500.seqop2)
	c:RegisterEffect(e5)
	--Space Stone (Move My Spell/Trap)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(101011015,0))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e6:SetTarget(c500.seqtg3)
	e6:SetOperation(c500.seqop3)
	c:RegisterEffect(e6)
	--Space Stone (Move Opp Spell/Trap)
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(101011015,1))
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e7:SetTarget(c500.seqtg4)
	e7:SetOperation(c500.seqop4)
	c:RegisterEffect(e7)
	--Space Stone (Move From MZONE>SZONE)
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(7093411,1))
	e8:SetCategory(CATEGORY_LEAVE_MZONE)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e8:SetTarget(c500.target3)
	e8:SetOperation(c500.Operation2)
	c:RegisterEffect(e8)
	--Space Stone (Move From SZONE>MZONE)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(101011018,1))
	e9:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e9:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e9:SetType(EFFECT_TYPE_QUICK_O)
	e9:SetCode(EVENT_FREE_CHAIN)
	e9:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e9:SetTarget(c500.sptg)
	e9:SetOperation(c500.spop)
	c:RegisterEffect(e9)
	--Mind Stone (Millennium Eye)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_PUBLIC)
	e10:SetRange(LOCATION_EXTRA+LOCATION_MZONE+LOCATION_SZONE)
	e10:SetTargetRange(0,LOCATION_HAND+LOCATION_SZONE)
	c:RegisterEffect(e10)
	--Power Stone (Destroy Monsters or Spell/Trap)
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(276357,0))
	e11:SetCategory(CATEGORY_DESTROY)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e11:SetTarget(c500.target4)
	e11:SetOperation(c500.activate2)
	c:RegisterEffect(e11)
	--Soul Stone (Copy Name And Effect)
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(43387895,0))
	e12:SetType(EFFECT_TYPE_QUICK_O)
	e12:SetCode(EVENT_FREE_CHAIN)
	e12:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e12:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e12:SetTarget(c500.copytg)
	e12:SetOperation(c500.copyop)
	c:RegisterEffect(e12)
	--Time Stone (Skip/End Opp Turn)
	local e13=Effect.CreateEffect(c)
	e13:SetDescription(aux.Stringid(18326736,1))
	e13:SetType(EFFECT_TYPE_QUICK_O)
	e13:SetCode(EVENT_FREE_CHAIN)
	e13:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e13:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e13:SetCost(c500.cost)
	e13:SetOperation(c500.activate3)
	c:RegisterEffect(e13)
	--Snap Fingers
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(612115,0))
	e14:SetCategory(CATEGORY_REMOVED)
	e14:SetType(EFFECT_TYPE_QUICK_O)
	e14:SetCode(EVENT_FREE_CHAIN)
	e14:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e14:SetCost(c500.sgcost)
	e14:SetTarget(c500.sgtg)
	e14:SetOperation(c500.sgop)
	c:RegisterEffect(e14)
	--Reality Stone (Special Summon)
	local e15=Effect.CreateEffect(c)
	e15:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e15:SetDescription(aux.Stringid(34487429,3))
	e15:SetType(EFFECT_TYPE_QUICK_O)
	e15:SetCode(EVENT_FREE_CHAIN)
	e15:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e15:SetTarget(c500.target5)
	e15:SetOperation(c500.operation3)
	c:RegisterEffect(e15)
	--Reality Stone (Link Summon)
	local e16=Effect.CreateEffect(c)
	e16:SetDescription(aux.Stringid(65741786,0))
	e16:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e16:SetType(EFFECT_TYPE_QUICK_O)
	e16:SetCode(EVENT_FREE_CHAIN)
	e16:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e16:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e16:SetTarget(c500.lktg)
	e16:SetOperation(c500.lkop)
	c:RegisterEffect(e16)
	--Cannot Send to Grave
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_SINGLE)
	e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e17:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e17:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e17)
	--Immune
	local e18=Effect.CreateEffect(c)
	e18:SetType(EFFECT_TYPE_SINGLE)
	e18:SetCode(EFFECT_IMMUNE_EFFECT)
	e18:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e18:SetRange(LOCATION_MZONE+LOCATION_SZONE+LOCATION_EXTRA)
	e18:SetValue(c500.efilter)
	c:RegisterEffect(e18)
	--Pierce
	local e19=Effect.CreateEffect(c)
	e19:SetType(EFFECT_TYPE_SINGLE)
	e19:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e19)
	--Cannot Switch Controller
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_SINGLE)
	e20:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e20:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e20:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e20)
	--Cannot be Target
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_SINGLE)
	e21:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e21:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e21:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e21:SetValue(aux.tgoval)
	c:RegisterEffect(e21)
	--Cannot be Removed
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e22:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e22:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e22)
	--Cannot Return to Hand
	local e23=Effect.CreateEffect(c)
	e23:SetType(EFFECT_TYPE_SINGLE)
	e23:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e23:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e23:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e23)
	--Cannot Return to Deck
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_SINGLE)
	e24:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e24:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e24:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e24)
	--Cannot be Tributed
	local e25=Effect.CreateEffect(c)
	e25:SetType(EFFECT_TYPE_SINGLE)
	e25:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e25:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e25:SetCode(EFFECT_UNRELEASABLE_SUM)
	e25:SetValue(1)
	c:RegisterEffect(e25)
	local e26=e25:Clone()
	e26:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e26)
	--spsumon_cannot_be_negated
	local e27=Effect.CreateEffect(c)
	e27:SetType(EFFECT_TYPE_SINGLE)
	e27:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e27:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e27)
	--Special Summon opponent's turn
	local e28=Effect.CreateEffect(c)
	e28:SetDescription(aux.Stringid(1234512345,0))
	e28:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e28:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e28:SetCode(EVENT_PREDRAW)
	e28:SetRange(LOCATION_EXTRA)
	e28:SetCountLimit(1,500)
	e28:SetCondition(c500.accon)
	e28:SetTarget(c500.actg)
	e28:SetOperation(c500.acop)
	c:RegisterEffect(e28)
	--indes Battle
	local e29=Effect.CreateEffect(c)
	e29:SetType(EFFECT_TYPE_SINGLE)
	e29:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e29:SetValue(1)
	c:RegisterEffect(e29)
	--Direct Attack
	local e30=Effect.CreateEffect(c)
	e30:SetType(EFFECT_TYPE_SINGLE)
	e30:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e30)
	--Avoid BD
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_SINGLE)
	e31:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e31:SetValue(1)
	c:RegisterEffect(e31)
	--Unaffected
	local e32=Effect.CreateEffect(c)
	e32:SetType(EFFECT_TYPE_SINGLE)
	e32:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e32:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e32:SetCode(EFFECT_IMMUNE_EFFECT)
	e32:SetValue(c500.unaffectedval)
	c:RegisterEffect(e32)
	--Extra Attack
	local e33=Effect.CreateEffect(c)
	e33:SetType(EFFECT_TYPE_SINGLE)
	e33:SetCode(EFFECT_EXTRA_ATTACK)
	e33:SetValue(200)
	c:RegisterEffect(e33)
	--Counter Exodia
	local e34=Effect.CreateEffect(c)
	e34:SetType(EFFECT_TYPE_FIELD)
	e34:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e34:SetCode(EFFECT_FORBIDDEN)
	e34:SetRange(LOCATION_EXTRA+LOCATION_MZONE+LOCATION_SZONE)
	e34:SetTargetRange(0x7f,0x7f)
	e34:SetTarget(c500.distg2)
	c:RegisterEffect(e34)
	--Soul Stone (Riryoku)
	local e35=Effect.CreateEffect(c)
	e35:SetDescription(aux.Stringid(8581705,0))
	e35:SetCategory(CATEGORY_ATKCHANGE)
	e35:SetType(EFFECT_TYPE_QUICK_O)
	e35:SetCode(EVENT_FREE_CHAIN)
	e35:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e35:SetCode(EVENT_FREE_CHAIN)
	e35:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e35:SetTarget(c500.target6)
	e35:SetOperation(c500.activate4)
	c:RegisterEffect(e35)
	--Soul Stone (Burn)
	local e36=Effect.CreateEffect(c)
	e36:SetDescription(aux.Stringid(114932,0))
	e36:SetCategory(CATEGORY_DAMAGE)
	e36:SetType(EFFECT_TYPE_QUICK_O)
	e36:SetCode(EVENT_FREE_CHAIN)
	e36:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e36:SetCode(EVENT_FREE_CHAIN)
	e36:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e36:SetTarget(c500.damtg)
	e36:SetOperation(c500.damop)
	c:RegisterEffect(e36)
	--Damage Conversion
	local e37=Effect.CreateEffect(c)
	e37:SetType(EFFECT_TYPE_FIELD)
	e37:SetCode(EFFECT_REVERSE_DAMAGE)
	e37:SetRange(LOCATION_MZONE+LOCATION_EXTRA+LOCATION_SZONE)
	e37:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e37:SetTargetRange(1,0)
	e37:SetValue(c500.rev)
	c:RegisterEffect(e37)
	--Negate Card Effects
	local e38=Effect.CreateEffect(c)
	e38:SetDescription(aux.Stringid(1287123,0))
	e38:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e38:SetType(EFFECT_TYPE_QUICK_O)
	e38:SetCode(EVENT_CHAINING)
	e38:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e38:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e38:SetCondition(c500.discon)
	e38:SetTarget(c500.distg)
	e38:SetOperation(c500.disop)
	c:RegisterEffect(e38)
	--Negate Summon
	local e39=Effect.CreateEffect(c)
	e39:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e39:SetType(EFFECT_TYPE_QUICK_O)
	e39:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e39:SetCode(EVENT_SUMMON)
	e39:SetCondition(c500.condition2)
	e39:SetTarget(c500.target7)
	e39:SetOperation(c500.operation4)
	c:RegisterEffect(e39)
	local e40=e39:Clone()
	e40:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e40)
	local e41=e39:Clone()
	e41:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e41)
	--Disbale Field Spells
	local e42=Effect.CreateEffect(c)
	e42:SetType(EFFECT_TYPE_FIELD)
	e42:SetCode(EFFECT_CANNOT_ACTIVATE)
	e42:SetRange(LOCATION_MZONE+LOCATION_SZONE+LOCATION_EXTRA)
	e42:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e42:SetTargetRange(1,1)
	e42:SetValue(c500.dfilter)
	c:RegisterEffect(e42)
	--Space Stone (Change To Face Up/Face Down)
	local e43=Effect.CreateEffect(c)
	e43:SetDescription(aux.Stringid(94997874,0))
	e43:SetCategory(CATEGORY_POSITION)
	e43:SetType(EFFECT_TYPE_QUICK_O)
	e43:SetCode(EVENT_FREE_CHAIN)
	e43:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE+TIMING_STANDBY_PHASE)
	e43:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e43:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e43:SetTarget(c500.postg)
	e43:SetOperation(c500.posop)
	c:RegisterEffect(e43)
	local e44=e43:Clone()
	e44:SetDescription(aux.Stringid(11646785,0))
	e44:SetTarget(c500.postg2)
	e44:SetOperation(c500.posop2)
	c:RegisterEffect(e44)
end
function c500.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end
function c500.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(999999999)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,999999999)
end
function c500.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c500.distg2(e,c)
	return c:IsCode(33396948)
end
function c500.unaffectedval(e,te)
	local c=te:GetHandler()
	return not c:IsCode(500) and not c:IsCode(53569894)
end
function c500.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c500.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()~=tp and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c500.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
function c500.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(999999999)
		c:RegisterEffect(e1)
	end
end
function c500.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c500.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		e:GetHandler():CancelToGrave()
	end
end
function c500.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c500.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c500.filter(chkc) end
	if chk==0 then
		if e:GetHandler():IsLocation(LOCATION_HAND) then
			return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		else return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	end
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft>5 then ft=5 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectTarget(tp,c500.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,5,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_MZONE,g,g:GetCount(),0,0)
end
function c500.Operation2(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		if sg:GetCount()>ft then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
			local rg=sg:Select(tp,ft,ft,nil)
			sg=rg
		end
		local tc=sg:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
			tc=sg:GetNext()
		end
		Duel.RaiseEvent(sg,EVENT_CUSTOM+47408488,e,0,tp,0,0)
	end
end
function c500.filter2(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c500.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and chkc:IsCanBeSpecialSummoned(e,0,tp,true,true) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c500.filter2,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c500.filter2,tp,LOCATION_SZONE,0,1,ft,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c500.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sg=sg:Select(tp,ft,ft,nil)
	end
	local ct=Duel.SpecialSummon(sg,0,tp,tp,true,true,POS_FACEUP)
end
function c500.seqfilter(c)
	return c:IsFaceup() or c:IsFacedown()
end
function c500.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c500.seqfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c500.seqfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(97729135,1))
	Duel.SelectTarget(tp,c500.seqfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c500.seqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end
function c500.seqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil)
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp,LOCATION_REASON_CONTROL)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(97729135,0))
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c500.seqop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(tp) or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	local nseq=math.log(bit.rshift(s,16),2)
	Duel.MoveSequence(tc,nseq)
end
function c500.seqtg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c500.seqfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c500.seqfilter,tp,LOCATION_SZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE,tp,LOCATION_REASON_CONTROL)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(101011015,0))
	Duel.SelectTarget(tp,c500.seqfilter,tp,LOCATION_SZONE,0,1,1,nil)
end
function c500.seqop3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end
function c500.seqtg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_SZONE,1,nil)
		and Duel.GetLocationCount(1-tp,LOCATION_SZONE,1-tp,LOCATION_REASON_CONTROL)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(101011015,1))
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_SZONE,1,1,nil)
end
function c500.seqop4(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(tp) or Duel.GetLocationCount(1-tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	local nseq=math.log(bit.rshift(s,16),2)
	Duel.MoveSequence(tc,nseq)
end
function c500.target4(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local b1=Duel.GetFieldGroup(1-tp,LOCATION_MZONE,0):Filter(Card.IsPosition,nil,POS_ATTACK):GetCount()>0
	local b2=Duel.GetMatchingGroupCount(Card.IsType,tp,0,LOCATION_ONFIELD,c,TYPE_SPELL+TYPE_TRAP)>0
	if chk==0 then return b1 or b2 end
	local s=0
	if b1 and not b2 then
		s=Duel.SelectOption(tp,aux.Stringid(91501248,2))
	end
	if not b1 and b2 then
		s=Duel.SelectOption(tp,aux.Stringid(101011067,1))+1
	end
	if b1 and b2 then
		s=Duel.SelectOption(tp,aux.Stringid(91501248,2),aux.Stringid(101011067,1))
	end
	e:SetLabel(s)
	local g=nil
	if s==0 then
		g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	end
	if s==1 then
		g=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,c,TYPE_SPELL+TYPE_TRAP)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c500.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=nil
	if e:GetLabel()==0 then
		g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	end
	if e:GetLabel()==1 then
		g=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,aux.ExceptThisCard(e),TYPE_SPELL+TYPE_TRAP)
	end
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c500.copyfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c500.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_REMOVED) and c500.copyfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c500.copyfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_REMOVED,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_REMOVED,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c500.copyfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_REMOVED,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_REMOVED,1,1,c)
end
function c500.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and (tc:IsFaceup() or tc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_REMOVED)) then
		local code=tc:GetOriginalCode()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD,1)
	end
end
function c500.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c500.activate3(e,tp,eg,ep,ev,re,r,rp)
    if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
    Duel.SkipPhase(1-tp,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(1-tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(1-tp,PHASE_END,RESET_PHASE+PHASE_END,1)
end
function c500.sgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(1-tp,math.floor(Duel.GetLP(tp)/2))
end
function c500.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c500.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c500.filter3(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,true,POS_FACEUP)
end
function c500.target5(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c500.filter3,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
end
function c500.operation3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c500.filter3,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c500.lktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsLinkSummonable,tp,LOCATION_EXTRA,0,1,nil,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c500.lkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsControler(1-tp) or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsLinkSummonable,tp,LOCATION_EXTRA,0,nil,nil,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.LinkSummon(tp,sg:GetFirst(),nil,c)
	end
end
function c500.accon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0
end
function c500.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end	
end
function c500.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c then
		Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		Duel.RaiseEvent(c,EVENT_CHAIN_SOLVED,c:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c500.target6(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c500.activate4(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	Duel.SetLP(1-tp,Duel.GetLP(1-p)/2,REASON_EFFECT)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(Duel.GetLP(1-p))
		tc:RegisterEffect(e1)
	end
end
function c500.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler()~=e:GetHandler() and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c500.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c500.disop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateActivation(ev) then return end
	if re:GetHandler():IsRelateToEffect(re) then 
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c500.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c500.target7(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c500.operation4(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c500.dfilter(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c500.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c500.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
	end
end
function c500.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c500.postg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c500.posfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c500.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c500.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c500.posop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end