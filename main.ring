# The Main File

load "Quran_ringController.ring"
media_url = ""

media_name ='' 

import System.GUI

cStyleSheet_combos = 'text-align:center;'

if IsMainSourceFile() {
	new App {
		StyleFusionBlack()
		openWindow(:Quran_ringController)
		exec()
	}
}

