# Form/Window Controller - Source Code File

# Loading View and main libraries
	load "Quran_ringView.ring"
	load 'jsonlib.ring'
	load 'internetlib.ring'
# Loading The Player Controller
	load 'player/playerController.ring'

# '========================================='
# Global Variables
	media_url = "" //"https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/020.mp3"
	media_name ='' //'سورة طه - محمد صديق المنشاوي'
# Importing the GUI package for object library
	import System.GUI

# Checking if this is the main source file 
	if IsMainSourceFile() { # This method comes from 'stdlibcore.ring' witch loaded from View file
		new App { # start new Qt App
			StyleFusionBlack() # Apply dark mode colors
			openWindow(:Quran_ringController) # Opening the window of controller class 
			exec() # Start the main loop
		}
	}

class Quran_ringController from windowsControllerParent
? '
|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|           Ring Quran Application         |
|         Made By : Mohannad Alayash       |
|  Contact : mohannadazazalayash@gmail.com |
|             Date : 22/12/2023            |
|__________________________________________|
'
	# class Attributes
		oView = new Quran_ringView
		nReciterNumber = 0
		cMoshaf_SERVER = ''
		cSoura_url = ''
		cReciter_name=''
		aAvi_sowers = []	
	# center to screan
		oDesktop = new qdesktopwidget()
		oView.win{
			move((oDesktop.width()-width())/2,(oDesktop.height()-height())/2)
		}
	# doing styles for minimum width
		oView.win.setminimumwidth(600)
		oView.reciters_Widget.setminimumwidth(250)
		oView.moshaf_Widget4.setminimumwidth(250)
		oView.sura_Widget.setminimumwidth(250)
	# Hiding the widgets at the begin of execution
		oView.sura_Widget.hide()	
		oView.Label3.hide()
		oView.Label5.hide()
		oView.moshaf_Widget4.hide()
	# initialize the built-in player
		Sura_player = new qMediaplayer()
		# 'Note :' We do not need it because we are using out side player
	# Starting of getting reciters	
		cResiters = download('https://mp3quran.net/api/v3/reciters')
	# check if there is no internt connection or any problem in api
		if cResiters != ''                # [firstRow][reciters]
			aResiters = Json2list(cResiters)[1][2]
		else
			aResiters = [] # empty list if there was any connection error
		ok
	# adding the first row witch apear to user
		oView.reciters_Widget.addItem('اختر قارئ',0)
	# check if there were reciters or not
		if len(aResiters) > 0
			# filling the reciters names to the combobox
				for x=1 to len(aResiters)
					oView.reciters_Widget.addItem(aResiters[x]['name'],x)
				next
			# writing the number of avalible reciters
				oView{  
					lbl_Reciters_COunt.settext(""+(reciters_Widget.count()-1)+' '+'قارئاََ')
				}
				# we used '-1' to avoid the first item in the dropdown that contian 'اختر قارئ'
		else
			# Printing the length if there was problem in api
				? 'aResiters length: '+len(aResiters)
		ok

	func GetMoshafs
		# hiding
			oView.Sura_Widget.hide()
			oView.moshaf_Widget4.hide()

			oView.Label3.hide()
			oView.Label5.hide()

			nCurrent_index = oView.reciters_Widget.currentIndex()-1
			# we used '-1' to avoid the first item in the dropdown that contian 'اختر قارئ'
		# check if the user did not choose the first item 
			if nCurrent_index = 0 return ok
		# reseting the index of moshafs
			oView.moshaf_Widget4.setCurrentIndex(0)
		# set the number of reciter id because we need it when we get sower endpoint
			this.nReciterNumber = nCurrent_index
		//Removeing All Moshafs if the user decided to choose another reciter
			oView.moshaf_Widget4.clear()
		// Filling Moshafs data
			aMoshfs = aResiters[nCurrent_index]['moshaf']
			# remember nCurrent_index is the reciter id
			for x=1 to len(aMoshfs)
				oView.moshaf_Widget4.addItem(aMoshfs[x]['name'],x)
			next
		# make the moshafs combobox visibile
			oView.moshaf_Widget4.show()
		# writing the number of moshafs availabe for this reciters
		# كتابة عدد القراءات المتوفرة لهذا القارئ
			oView{  
				lbl_Moshfs_COunt8.settext(""+moshaf_Widget4.count()+' '+'مصحف')
			}

	func GetSura
		# avoiding the problem if there were no reciters yet
			if nReciterNumber = 0 return ok
		nMoshafIndex = oView.moshaf_Widget4.currentindex()
		# check if it was there is no moshafs for this reciter
			if nMoshafIndex = 0 return ok
		# reset of the avalible sowers for the reciter if user changed the moshaf 	
			this.aAvi_sowers = []
		# seting the reciter name and his server
			this.cReciter_name = aResiters[nReciterNumber]['name']
			this.cMoshaf_SERVER = aResiters[nReciterNumber]['moshaf'][nMoshafIndex]['server']
		# getting the sowers of this reciter of this moshaf as string like '1,2,3 ...' so converted to list using split
			aSuras = split(aResiters[nReciterNumber]['moshaf'][nMoshafIndex]['surah_list'], ',')
		# getting all sowers data from server
			//cAllSuras = download('https://mp3quran.net/api/v3/suwar')
		# getting all sowers data from file
			cAllSuras = read('all_Souars.json')
		# check if there was a problem in api 'when we use api'
			if callSuras  != ''
				aAllSuras = json2list(callSuras)['suwar']
			else
				aAllSuras = []
			ok
			if len(aAllSuras) < 1 return ok
		//Removeing All Sowers
			oView.Sura_Widget.clear()
		// Filling data
		# Adding the first item
		oView.Sura_Widget.addItem('اختر سورة',0)
			for x=1 to len(aAllSuras)
				for y=1 to len(aSuras)
					if aAllSuras[x]['id']=aSuras[y]
						 oView.Sura_Widget.addItem(aAllSuras[x]['name'],x)
					# adding the sura to avalible sowers as list contain [id , name]
						 this.aAvi_sowers + [ aAllSuras[x]['id'] , aAllSuras[x]['name']] 
					ok
				next
			next
		# reset the choose to first item
			oView.Sura_Widget.setCurrentIndex(1)
		# writing the number of availabe sowers
			oView{
				lbl_Suras_COunt9.settext(""+(Sura_Widget.count()-1)+' '+'سورة')
			}
		# make required widgets visibile
			oView.Sura_Widget.show()
	
			oView.Label3.show()
			oView.Label5.show()
	func prepare_Sura
		oView {
		# check if there is sowers or not
			if len(this.aAvi_sowers) > 0
				this.cSoura_url = this.cMoshaf_SERVER+this.Add_Degit(this.aAvi_sowers[(self.Sura_Widget.currentindex()-1)][1])+'.mp3'
				lbl_sura_name.setText('سورة '+this.aAvi_sowers[(self.Sura_Widget.currentindex()-1)][2])
			# setting the media URL to send it to the player
				media_url = this.cSoura_url 
			# setting the media name to send it to the player
				media_name =  win.windowtitle()+' | '
				media_name += 'سورة '
				media_name += this.aAvi_sowers[(self.Sura_Widget.currentindex()-1)][2]
				media_name += ' - '
				media_name += this.cReciter_name
			ok
		}

	func Add_Degit nNum
	# e.g 1 will be returned as "001" and 10 returned "010" and 110 returned "110"
		cOut = '' 
		for x=1 to (3-len(string(nNum)))
			cOut+= '0'
		next
		cOut = ""+cOut+nNum
		return cOut

	func play_sura
		oView {
		# check if there is a URL or not
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

		# open the player window after setting the global variables
			if lastWindow().ObjectID() > 1
				lastWindow().mediaPlayer.stop()
				lastWindow().oView.win.Close()
				OpenWindow(:playerController)
			else
				OpenWindow(:playerController)
			ok
		}
