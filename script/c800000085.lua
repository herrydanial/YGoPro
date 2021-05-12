--クリフォート・アセンブラ
function c800000085.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c800000085.splimit)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(800000085,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c800000085.drcon)
	e3:SetTarget(c800000085.drtg)
	e3:SetOperation(c800000085.drop)
	c:RegisterEffect(e3)
	if not c800000085.global_check then
		c800000085.global_check=true
		c800000085[0]=0
		c800000085[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c800000085.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_MSET)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD)
		ge3:SetCode(EFFECT_MATERIAL_CHECK)
		ge3:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
		ge3:SetValue(c800000085.valcheck)
		Duel.RegisterEffect(ge3,0)
		ge1:SetLabelObject(ge3)
		ge2:SetLabelObject(ge3)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge4:SetOperation(c800000085.clearop)
		Duel.RegisterEffect(ge4,0)
	end
end
function c800000085.splimit(e,c)
	return not c:IsSetCard(0xaa)
end
function c800000085.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsSummonType(SUMMON_TYPE_ADVANCE) then
		local p=tc:GetSummonPlayer()
		c800000085[p]=c800000085[p]+e:GetLabelObject():GetLabel()
	end
end
function c800000085.valcheck(e,c)
	local ct=c:GetMaterial():FilterCount(Card.IsSetCard,nil,0xaa)
	e:SetLabel(ct)
end
function c800000085.clearop(e,tp,eg,ep,ev,re,r,rp)
	c800000085[0]=0
	c800000085[1]=0
end
function c800000085.drcon(e,tp,eg,ep,ev,re,r,rp)
	return c800000085[tp]>0
end
function c800000085.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,c800000085[tp]) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,c800000085[tp])
end
function c800000085.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Draw(tp,c800000085[tp],REASON_EFFECT)
end
