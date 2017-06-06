% OPEN DECLARATIVE UNBUNDLED
local Dicc D2 D3 D4 D Val in
   local
      local Tree in
         fun {Tree K V L R}
            tree(key:K value:V left:L right:R)
         end
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
      end
      fun {NewDicc} 
         nil 
      end
      fun {Put D K V} 
         {Insert K V D}
      end
      proc {Get D K R} 
         R = {Lookup K D}          
      end
      fun {Domain D} 
         proc {DomainD D ?S1 Sn}
            case D of nil then S1=Sn
            [] tree(key:K value:_ left:L right:R) then 
               local S2 S3 in
                  {DomainD L S1 S2}
                  S2=K|S3
                  {DomainD R S3 Sn}
               end
            end
         end R
      in 
         {DomainD D R nill} R
      end
   in
      Dicc=dicc(new:NewDicc put:Put get:Get domain:Domain)
   end
   D = {Dicc.new}
   D2 = {Dicc.put D 'a' 4}
   D3 = {Dicc.put D2 'b' 10}
   {Dicc.get D3 'a' Val}
   {Browse D}
   {Browse D2}
   {Browse D3}
   {Browse Val}   
end

