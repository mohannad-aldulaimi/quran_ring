# Form/Window Controller - Source Code File
# https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/020.mp3
load "playerView.ring"
media_url = "https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/001.mp3"
media_name = 'سورة طه - محمد صديق المنشاوي'

import System.GUI
btn_style = '
GPushButton{text-align:center;font-size:50px;color:blue;border-radius : 50; border:2px solid blue ;}
GPushButton:hover{color:yellow;border-radius : 50; border:2px solid yellow }
'
btn_style = substr(btn_style , nl ,'')
if IsMainSourceFile() {
	new App {
		StyleFusionBlack()
		openWindow(:playerController)
		exec()
	}
}
class playerController from windowsControllerParent
	cMediaURL = media_url
	is_played=0
	
	display_widget = new qDesktopwidget()
	
	oView = new playerView

	if IsMainSourceFile()
		 setWinIcon(oView.win,"../Quran_Logo.ico")
	else
		 setWinIcon(oView.win,"Quran_Logo.ico")
	ok
	oView.win.installEventFilter( new QAllEvents(oView.win) { setCloseEvent(method('pclose_event')) } ) 

	oView.lbl_audioname.setText(media_name)
	oView.win.setWindowTitle(media_name)

	oView.win{
		setgeometry(((display_widget.width()-width())/2),((display_widget.height()-height())/2),500,120)
	}

	oView.btn_play.setstylesheet(btn_style)
	oView.btn_play.setminimumwidth(50)
	oView.btn_play.setmaximumwidth(50)
	oView.btn_play.setmaximumheight(50)

	oView.Player_slider.setPageStep(0)

    oView.Player_slider.setTickInterval(0.01)
    oView.Player_slider.setSingleStep(0.01)
	
	mediaplayer = new qMediaplayer() {
		setMedia( new qurl(this.cMediaURL))
		setVolume(50)
	}

	oView.player_vol_slider.setvalue(50)

	Timer_Updater = new qTimer(oView.win)
            {
                setinterval(1000)
                settimeoutevent(method("eve_update_time_and_pos"))
                start()
            }

	func eve_update_time_and_pos
		this.setTotalDuration()
		nTimePos = this.mediaPlayer.position()
		ntotal_duration= (this.mediaplayer.duration())

		if nTimePos = 0 return ok
		//? 'current Postion:'+nTimePos

		//? (nTimePos/ntotal_duration)*100

		oView.player_slider.setValue(((nTimePos/ntotal_duration)*100))

		oView.player_time_current.setText(""+GetTime(nTimePos))

	func player_slider_change
		oView {			
			nCurrentValue = player_slider.value()

			ntotal_duration= (this.mediaplayer.duration())

			ntotal_current_pos= (this.mediaplayer.position())

			nSetPosTo = (nCurrentValue*ntotal_duration)/100
			
			//? 'Total duration : '+ntotal_duration
			//ntotal_duration
			//player_slider.setMaximum(100)
			//? 'Setting Postion to : '+nSetPosTo

//			this.mediaplayer.setPosition(nSetPosTo*60*1000)
			this.mediaplayer.setPosition(nSetPosTo)
		}

	func btn_play_click
		this.toggle_btn_play()
	func toggle_btn_play

		oView {
			if btn_play.text() != "⏸"
				if this.cMediaURL != ''
	 				this.mediaplayer.play() 
					this.is_played=1
					btn_play.setText(trim("⏸"))
				ok
			else
				this.is_played=0
				this.mediaplayer.pause()

				btn_play.setText(trim( "▶"))	
			ok
		}

	func updateVolume
//
		nVolume = oView.player_vol_slider.value()
		this.mediaplayer.setvolume(nVolume)
		if nVolume >= 50
			oView.btn_volume_mute.setText('🔊')
		but nVolume < 50 and nVolume > 5
			oView.btn_volume_mute.setText('🔉')
		else
			oView.btn_volume_mute.setText('🔇')
		ok

		func MuteaudioToggle
			if oView.btn_volume_mute.text() = '🔇'
				oView.player_vol_slider.setValue(50)
			else
				oView.player_vol_slider.setValue(0)
			ok 


func setTotalDuration

		nDuration = this.mediaPlayer.duration()
		this.oView.player_time_end.setText(this.getTime(nDuration))

func Add_Degit nNum
	cOut = ''
	for x=1 to (2-len(string(nNum)))
		cOut+= '0'
	next
	cOut = ""+cOut+nNum
	return cOut
func GetTime total_seconds
	total_seconds = total_seconds/1000
	hours = Add_Degit(ceil(total_seconds / 3600) - 1)
	remaining_seconds = total_seconds % 3600

	minutes =Add_Degit(ceil( remaining_seconds / 60) - 1)
	seconds = Add_Degit(floor(remaining_seconds % 60))

	return ""+hours+':'+minutes+":"+seconds


func pclose_event
	this.mediaplayer.stop()
