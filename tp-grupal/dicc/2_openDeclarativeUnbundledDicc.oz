% OPEN DECLARATIVE UNBUNDLED
local Dict D2 D3 D4 D Val Val2 Tree in
   fun {Tree K V L R}
      tree(key:K value:V left:L right:R)
   end   
   local  
      fun {Insert K V T}
         case T of nil then {Tree K V nil nil}
            [] tree(key:Y value:W left:L right:R) andthen K==Y then 
               case W of nil then {Tree Y V L R}
               else {Tree Y W|V L R}
               end
            [] tree(key:Y value:W left:L right:R) andthen K<Y then {Tree Y W {Insert K V L} R}
            [] tree(key:Y value:W left:L right:R) andthen K>Y then {Tree Y W L {Insert K V R}}
            else nil
         end
      end
      fun {Lookup K T}
         case T of nil then nil
            [] tree(key:Y value:V left:L right:R) andthen K==Y then V
            [] tree(key:Y value:V left:L right:R) andthen K<Y then {Lookup K L}
            [] tree(key:Y value:V left:L right:R) andthen K>Y then {Lookup K R}
            else nil
         end
      end
      fun {NewDict} 
         nil 
      end
      fun {Put D K V} 
         {Insert K V D}
      end
      proc {Get D K R} 
         R = {Lookup K D}          
      end
      fun {Domain D}
         fun {Length L}
            case L of nil then 0
            [] H|T then 1+{Length T}
            else 1
            end
         end   
         fun {Compare A B}
            case A of keydata(key:K value_length:V) then
               case B of keydata(key:L value_length:U) andthen U>V then true
               [] keydata(key:K value_length:U) andthen U<V then false
               else false
               end
            else nil
            end
         end
         fun {OrderAux Max ListAux Accumulated Return}
            local Aux in
               case ListAux of nil then 
                  Return = Accumulated
                  Aux = Max
               [] H|T then
                  if ({Compare Max H}) then
                     Aux = {OrderAux H T Max|Accumulated Return}                           
                  else 
                     Aux = {OrderAux Max T H|Accumulated Return}
                  end
               else 
                  Aux = nil
               end
               Aux
            end
         end
         fun {Order L}  
            local R in              
               case L of nil then nil
               [] H|T then
                  {OrderAux H T nil ?R}|{Order R} 
               else nil
               end                     
            end
         end
         proc {DomainD D ?S1 Sn}
            case D of nil then S1=Sn
            [] tree(key:K value:V left:L right:R) then 
               local S2 S3 in
                  {DomainD L S1 S2}
                  S2=keydata(key:K value_length:{Length V})|S3
                  {DomainD R S3 Sn}
               end
            else
               skip
            end
         end R
      in 
         {DomainD D R nil}
         {Order R}
      end
   in
      Dict=dictionary(new:NewDict put:Put get:Get domain:Domain)
   end
   D = {Dict.new}
   D2 = {Dict.put D 'a' 4}
   D3 = {Dict.put D2 'b' 10}
   {Dict.get {Tree 'c' 15 nil nil} 'c' Val2}
   {Dict.get D3 'a' Val}
   D4 = {Dict.put D3 'b' 14}
   {Browse D}
   {Browse D2}
   {Browse D3}
   {Browse Val}   
   {Browse Val2}   
   {Browse {Dict.domain D4}}   
end

