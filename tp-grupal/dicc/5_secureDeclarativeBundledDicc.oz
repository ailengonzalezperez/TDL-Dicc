% SECURE DECLARATIVE BUNDLED
local NewDict D2 D3 D4 D Val Tree in
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
      fun {DictOps D}
        	fun {Put K V} 
            {DictOps {Insert K V D}} 
         end
        	proc {Get K R}
   	     R = {Lookup K D} 
         end
         fun {Domain}
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
         dictionary(put:Put get:Get domain:Domain) 
      end
   in
      fun {NewDict} 
         {DictOps nil}
      end
   end
   D = {NewDict}
   D2 = {D.put 'a' 4}
   D3 = {D2.put 'b' 10}
   {D3.get 'a' Val}
   D4 = {D3.put 'b' 4}
   {Browse D}
   {Browse D2}
   {Browse D3}
   {Browse Val}
   {Browse {D4.domain}}
end


