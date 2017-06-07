% SECURE DECLARATIVE BUNDLED
local NewDict D2 D3 D Val Tree in
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
            nil 
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
   {Browse D}
   {Browse D2}
   {Browse D3}
   {Browse Val}
end


