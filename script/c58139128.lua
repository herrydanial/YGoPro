--墓守の祈祷師
function c58139128.initial_effect(c)
	--def up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c58139128.defval)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_CHAIN_ACTIVATING)
	e2:SetOperation(c58139128.disop)
	c:RegisterEffect(e2)
	--cannot activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c58139128.econ)
	e3:SetValue(c58139128.efilter1)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCondition(c58139128.econ)
	e4:SetTarget(c58139128.etarget)
	e4:SetValue(c58139128.efilter2)
	c:RegisterEffect(e4)
	
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetCondition(c58139128.con)
	e5:SetValue(c58139128.efilter)
	c:RegisterEffect(e5)
	
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(58139128,0))
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_REMOVED)
	e6:SetCost(c58139128.cost)
--	e6:SetTarget(c58139128.target)
--	e6:SetOperation(c58139128.operation)
	c:RegisterEffect(e6)
end

function c58139128.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return true --e:GetHandler():IsAbleToRemoveAsCost() 
	end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
end

function c58139128.filter_i(c)
	return c:IsFaceup() and c:IsCode(47355498)
end
function c58139128.con(e)
	return Duel.IsExistingMatchingCard(c58139128.filter_i,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(47355498)
end
function c58139128.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end

function c58139128.filter(c)
	return c:IsSetCard(0x2e) or c:IsSetCard(0x91)
end
function c58139128.defval(e,c)
	return Duel.GetMatchingGroupCount(c58139128.filter,c:GetControler(),LOCATION_GRAVE+LOCATION_REMOVED,0,nil)*300
end
function c58139128.disop(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if (re:IsActiveType(TYPE_MONSTER) or re:IsActiveType(TYPE_SPELL) or re:IsActiveType(TYPE_TRAP)) and not re:GetHandler():IsSetCard(0x2e) and loc==LOCATION_GRAVE then
		Duel.NegateEffect(ev)
	end
end
function c58139128.actfilter(c)
	return c:IsFaceup() and c:IsCode(47355498)
end
function c58139128.econ(e)
	return Duel.IsExistingMatchingCard(c58139128.actfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(47355498)
end
function c58139128.efilter1(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c58139128.etarget(e,c)
	return c:IsType(TYPE_FIELD)
end
function c58139128.efilter2(e,re,tp)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
