% SECURE DECLARATIVE UNBUNDLED
local NewWrapper in
   proc {NewWrapper Wrap Unwrap}
      local Key = {NewName} in
         fun {Wrap X}
         	fun {$ K}
         	   if (K==Key) then X end
         	end
	      end
   	   fun {Unwrap W}
   	      {W Key}
   	   end
      end
   end

   local Dict D2 D3 D4 D Val Val2 Wrap Unwrap Tree in
      fun {Tree K V L R}
         tree(key:K value:V left:L right:R)
      end  
      local
	      {NewWrapper Wrap Unwrap}
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
            {Wrap nil} 
         end
      	fun {Put D K V} 
            {Wrap {Insert K V {Unwrap D}}}
         end
      	proc {Get D K R}
            R = {Wrap {Lookup K {Unwrap D}}} 
         end
      	fun {Domain D} 
            nil
         end
      in
	     Dict=dictinoary(new:NewDict put:Put get:Get domain:Domain)
      end
      
      D = {Dict.new}
      D2 = {Dict.put D 'a' 4}
      D3 = {Dict.put D2 'b' 10}
      {Dict.get D3 'b' Val}    
      try
         D4 = {Dict.get {Tree 'c' 15 nil nil} 'c' Val2}
      catch Exc then
         {Browse Exc}
      end 
      {Browse D}
      {Browse D2}
      {Browse D3}
      {Browse Val}
   end
end

