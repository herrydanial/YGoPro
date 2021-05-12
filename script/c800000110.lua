--サクリファイス
function c800000110.initial_effect(c)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(800000110,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c800000110.eqcon)
	e1:SetTarget(c800000110.eqtg)
	e1:SetOperation(c800000110.eqop)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetCondition(c800000110.adcon)
	e2:SetValue(c800000110.atkval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SET_DEFENSE)
	e3:SetCondition(c800000110.adcon)
	e3:SetValue(c800000110.defval)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c800000110.damcon)
	e4:SetOperation(c800000110.damop)
	c:RegisterEffect(e4)
end
function c800000110.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return c800000110.can_equip_monster(e:GetHandler())
end
function c800000110.eqfilter(c)
	return c:GetFlagEffect(800000110)~=0
end
function c800000110.can_equip_monster(c)
	local g=c:GetEquipGroup():Filter(c800000110.eqfilter,nil)
	return g:GetCount()==0
end
function c800000110.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c800000110.eqlimit(e,c)
	return e:GetOwner()==c
end
function c800000110.equip_monster(c,tp,tc)
	if not Duel.Equip(tp,tc,c,false) then return end
	--Add Equip limit
	tc:RegisterFlagEffect(800000110,RESET_EVENT+RESETS_STANDARD,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c800000110.eqlimit)
	tc:RegisterEffect(e1)
	--substitute
	local e2=Effect.CreateEffect(c)
 	e2:SetType(EFFECT_TYPE_EQUIP)
 	e2:SetCode(EFFECT_DESTROY_SUBSTITUTE)
 	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
 	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
 	e2:SetValue(c800000110.repval)
 	tc:RegisterEffect(e2)
end
function c800000110.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsType(TYPE_MONSTER) and tc:IsControler(1-tp) then
		c800000110.equip_monster(c,tp,tc)
	end
end
function c800000110.repval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c800000110.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c800000110.eqfilter,nil)
	return g:GetCount()>0 and ep==tp
		and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c800000110.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,ev,REASON_EFFECT)
end
function c800000110.adcon(e)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c800000110.eqfilter,nil)
	return g:GetCount()>0
end
function c800000110.atkval(e,c)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c800000110.eqfilter,nil)
	local atk=g:GetFirst():GetTextAttack()
	if g:GetFirst():IsFacedown() or bit.band(g:GetFirst():GetOriginalType(),TYPE_MONSTER)==0 or atk<0 then
		return 0
	else
		return atk
	end
end
function c800000110.defval(e,c)
	local c=e:GetHandler()
	local g=c:GetEquipGroup():Filter(c800000110.eqfilter,nil)
	local def=g:GetFirst():GetTextDefense()
	if g:GetFirst():IsFacedown() or bit.band(g:GetFirst():GetOriginalType(),TYPE_MONSTER)==0 or def<0 then
		return 0
	else
		return def
	end
end
