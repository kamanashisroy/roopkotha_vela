
function rehash() 
	OutputStream.write("Rehashing lua modules\n")
	return "vela/page/menu"
end

function exten_vela_page_menu(x) 
	local msg = "default <x href=\"velaxecute://ls\" label=Open></x><x href=\"velaxecute://history -b 99 \" label=Quit></x><x href=\"velafopen://velapp/about.txt\" label=About></x>\n"
	return(msg)
end
