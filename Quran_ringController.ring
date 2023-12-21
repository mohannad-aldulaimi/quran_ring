# Form/Window Controller - Source Code File

load "Quran_ringView.ring"
load 'jsonlib.ring'
load 'internetlib.ring'

load 'player/playerController.ring'
media_url = ""//"https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/001.mp3"
media_name ='' //'سورة طه - محمد صديق المنشاوي'

import System.GUI

cStyleSheet_combos = 'text-align:center;'

if IsMainSourceFile() {
	new App {
		StyleFusionBlack()
		openWindow(:Quran_ringController)
		exec()
	}
}

class Quran_ringController from windowsControllerParent

	oView = new Quran_ringView
	//reciters_Widget
	nReciterNumber = 0
	cMoshaf_SERVER = ''
	cSoura_url = ''
	cReciter_name=''
	aAvi_sowers = []
	oView.sura_Widget.hide()
	oView.sura_Widget.setstylesheet(cStyleSheet_combos)
	oView.reciters_Widget.setstylesheet(cStyleSheet_combos)

	oView.Label3.hide()
	oView.Label5.hide()
	oView.moshaf_Widget4.hide()

	Sura_player = new qMediaplayer()
	cResiters = download('https://mp3quran.net/api/v3/reciters')
	

	if cResiters != ''
		aResiters = Json2list(cResiters)[1][2]
	else
		aResiters = []
	ok
	oView.reciters_Widget.addItem('اختر قارئ',0)
	if len(aResiters) > 0
		for x=1 to len(aResiters)
		//? 'X : '+X
			oView.reciters_Widget.addItem(aResiters[x]['name'],x)
		next
		oView{  
			lbl_Reciters_COunt.settext(""+(reciters_Widget.count()-1)+' '+'قارئاََ')
		}
	else
	? 'aResiters length: '+len(aResiters)
	ok
	//moshaf_Widget4
	//currentIndex


	func GetMoshafs
		oView.Sura_Widget.hide()	
		oView.moshaf_Widget4.hide()

		oView.Label3.hide()
		oView.Label5.hide()

		nCurrent_index = oView.reciters_Widget.currentIndex()-1
		if nCurrent_index = 0 return ok

		oView.moshaf_Widget4.setCurrentIndex(0)

		this.nReciterNumber = nCurrent_index
		//Removeing All Moshafs
			//for x=1 to oView.moshaf_Widget4.count()
				//oView.moshaf_Widget4.RemoveItem(x)
			//next
			oView.moshaf_Widget4.clear()
		// Filling data
			aMoshfs = aResiters[nCurrent_index]['moshaf']
			for x=1 to len(aMoshfs)
				oView.moshaf_Widget4.addItem(aMoshfs[x]['name'],x)
			next
		oView.moshaf_Widget4.show()
		oView{  
			lbl_Moshfs_COunt8.settext(""+moshaf_Widget4.count()+' '+'مصحف')
		}

	func GetSura
		if nReciterNumber = 0 return ok
		nMoshafIndex = oView.moshaf_Widget4.currentindex()
		if nMoshafIndex = 0 return ok
		
				this.aAvi_sowers = []
		this.cReciter_name = aResiters[nReciterNumber]['name']
		this.cMoshaf_SERVER = aResiters[nReciterNumber]['moshaf'][nMoshafIndex]['server']
		aSuras = split(aResiters[nReciterNumber]['moshaf'][nMoshafIndex]['surah_list'], ',')
//		cAllSuras = download('https://mp3quran.net/api/v3/suwar')
		cAllSuras = read('all_Souars.json')

		if callSuras  != ''
			aAllSuras = json2list(callSuras)['suwar']
		else
			aAllSuras = []
		ok
		if len(aAllSuras) < 1 return ok
		//Removeing All Suras
			//for x=1 to (len(this.aAvi_sowers )-1)//oView.Sura_Widget.count()
				//oView.Sura_Widget.RemoveItem(x)
			//next
			oView.Sura_Widget.clear()
		// Filling data
		oView.Sura_Widget.addItem('اختر سورة',0)
			for x=1 to len(aAllSuras)
				for y=1 to len(aSuras)
					if aAllSuras[x]['id']=aSuras[y]
						 oView.Sura_Widget.addItem(aAllSuras[x]['name'],x)
						 this.aAvi_sowers + [ aAllSuras[x]['id'] , aAllSuras[x]['name']] 
					ok
				next
			next
			oView.Sura_Widget.setCurrentIndex(1)
		oView{
			lbl_Suras_COunt9.settext(""+(Sura_Widget.count()-1)+' '+'سورة')
		}
		oView.Sura_Widget.show()

		oView.Label3.show()
		oView.Label5.show()
	func prepare_Sura
		oView {
			if len(this.aAvi_sowers) > 0
				this.cSoura_url = this.cMoshaf_SERVER+this.Add_Degit(this.aAvi_sowers[(self.Sura_Widget.currentindex()-1)][1])+'.mp3'
				lbl_sura_name.setText(this.aAvi_sowers[(self.Sura_Widget.currentindex()-1)][2])
				media_url = this.cSoura_url 
				media_name = 'سورة '
				media_name += this.aAvi_sowers[(self.Sura_Widget.currentindex()-1)][2]
				media_name += ' - '
				media_name += this.cReciter_name
			ok
		}

	func Add_Degit nNum
		cOut = ''
		for x=1 to (3-len(string(nNum)))
			cOut+= '0'
		next
		cOut = ""+cOut+nNum
		return cOut

	func play_sura
		oView {
		if this.cSoura_url = '' return ok
			/*this.Sura_player{
				setMedia(new qurl(this.cSoura_url))	
			}
			if btn_play_sura.text() = '⏸️'
				btn_play_sura.setText('▶️')
				this.Sura_player.pause()
			else
				btn_play_sura.setText('⏸️')
				this.Sura_player.play()
			ok*/
			openWindow(:playerController)
		}
