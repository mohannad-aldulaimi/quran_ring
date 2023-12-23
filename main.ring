# The Main File

load "Quran_ringController.ring"
media_url = ""

media_name ='' 

import System.GUI

cStyleSheet_combos = 'text-align:center;'

if IsMainSourceFile() {
	oApp = new App {
		StyleFusionBlack()
		setLayoutDirection(1)
		openWindow(:Quran_ringController)
		exec()
	}
}

