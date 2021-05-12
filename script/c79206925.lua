--墓守の異能者
function c79206925.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x2e),2,true)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c79206925.valcheck)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c79206925.atkcon)
	e2:SetOperation(c79206925.atkop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE+LOCATION_FZONE,0)
	e3:SetCondition(c79206925.indcon)
	e3:SetTarget(c79206925.indtg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(79206925,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,79206925)
	e4:SetTarget(c79206925.regtg)
	e4:SetOperation(c79206925.regop)
	c:RegisterEffect(e4)	
	--imune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetCondition(c79206925.con)
	e5:SetValue(c79206925.efilter)
	c:RegisterEffect(e5)
	--atk up
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c79206925.atkval)
	c:RegisterEffect(e6)
	--def up
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_UPDATE_DEFENSE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(c79206925.atkval)
	c:RegisterEffect(e7)
	
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DAMAGE_STEP_END)
	e5:SetCondition(c79206925.rmcon)
	e5:SetTarget(c79206925.rmtg)
	e5:SetOperation(c79206925.rmop)
	c:RegisterEffect(e5)
end
function c79206925.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return c==Duel.GetAttacker() and bc and c:IsStatus(STATUS_OPPO_BATTLE) and bc:IsOnField() and bc:IsRelateToBattle()
end
function c79206925.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c79206925.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end

function c79206925.atkval(e,c)
	local tot = Duel.GetMatchingGroupCount(c79206925.filter,1-c:GetControler(),LOCATION_DECK,0,nil)
	local tod = Duel.GetMatchingGroupCount(c79206925.filter,1-c:GetControler(),LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD+LOCATION_HAND,0,nil)
	local lif = Duel.GetLP(1-c:GetControler())/tot
	local val1 = Duel.GetMatchingGroupCount(c79206925.filter,1,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD+LOCATION_HAND,0,nil)
	local val2 = Duel.GetMatchingGroupCount(c79206925.filter,0,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD+LOCATION_HAND,0,nil)
	local val3 = val1 * val2
	return lif * tod
	end
end
function c79206925.filter(c)
	return true
end
function c79206925.con(e)
	return Duel.IsExistingMatchingCard(c79206925.filter_i,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(47355498)
end
function c79206925.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c79206925.valcheck(e,c)
	local lv=c:GetMaterial():GetSum(Card.GetOriginalLevel)
	e:SetLabel(lv)
end
function c79206925.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return true
end
function c79206925.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local val=e:GetLabelObject():GetLabel()*100
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c79206925.indcon(e)
	return Duel.IsEnvironment(47355498)
end
function c79206925.indtg(e,c)
	return c==e:GetHandler() or c:IsLocation(LOCATION_FZONE)
end
function c79206925.thfilter(c)
	return (c:IsSetCard(0x2e) and c:IsType(TYPE_MONSTER)) or c:IsSetCard(0x91)
end
function c79206925.regtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79206925.thfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c79206925.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c79206925.thcon)
	e1:SetOperation(c79206925.thop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c79206925.thfilter2(c)
	return c79206925.thfilter(c) and c:IsAbleToHand()
end
function c79206925.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c79206925.thfilter2,tp,LOCATION_DECK,0,1,nil)
end
function c79206925.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,79206925)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c79206925.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
