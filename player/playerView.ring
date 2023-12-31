# Form/Window View - Generated Source Code File 
# Generated by the Ring 1.18 Form Designer
# Date : 22/12/2023
# Time : 22:08:30

Load "stdlibcore.ring"
Load "guilib.ring"

import System.GUI

if IsMainSourceFile() { 
	new App {
		StyleFusion()
		new playerView { win.show() } 
		exec()
	}
}

class playerView from WindowsViewParent
	win = new MainWindow() { 
		move(19,20)
		resize(400,181)
		setWindowTitle("Player")
		setstylesheet("background-color:;") 

		setWindowFlags(Qt_Window | Qt_WindowTitleHint | Qt_WindowMinimizeButtonHint | Qt_WindowCloseButtonHint | Qt_WindowStaysOnTopHint) 
		lbl_audioname = new label(win) {
			move(59,15)
			resize(309,29)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("Arial,15,-1,5,50,0,0,0,0,0,Regular")
			setfont(oFont)
			oFont.delete()
			setText("سورة طه - محمد صديق المنشاوي")
			setAlignment(Qt_AlignLeft |  Qt_AlignVCenter)
		}
		btn_play = new pushbutton(win) {
			move(4,29)
			resize(50,44)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("arial")
			setfont(oFont)
			oFont.delete()
			setText("▶")
			setClickEvent(Method(:btn_play_click))
			setBtnImage(btn_play,"")
			
		}
		player_slider = new slider(win) {
			move(60,42)
			resize(315,21)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("Arial")
			setfont(oFont)
			oFont.delete()
			setOrientation(1)
			setMaximum(100)
			setactionTriggeredEvent("")
			setrangeChangedEvent("")
			setsliderMovedEvent(Method(:player_slider_change))
			setsliderPressedEvent("")
			setsliderReleasedEvent("")
			setvalueChangedEvent("")
			
		}
		player_time_current = new label(win) {
			move(65,72)
			resize(53,20)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("Arial")
			setfont(oFont)
			oFont.delete()
			setText("00:00:00")
			setAlignment(Qt_AlignHCenter |  Qt_AlignVCenter)
		}
		btn_volume_mute = new pushbutton(win) {
			move(120,70)
			resize(32,32)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("Arial,12,-1,5,50,0,0,0,0,0,Regular")
			setfont(oFont)
			oFont.delete()
			setText("")
			setClickEvent(Method(:MuteaudioToggle))
			setBtnImage(btn_volume_mute,"")
			
		}
		player_vol_slider = new slider(win) {
			move(153,69)
			resize(79,30)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("Arial")
			setfont(oFont)
			oFont.delete()
			setOrientation(1)
			setMaximum(100)
			setactionTriggeredEvent("")
			setrangeChangedEvent("")
			setsliderMovedEvent("")
			setsliderPressedEvent("")
			setsliderReleasedEvent("")
			setvalueChangedEvent(Method(:updateVolume))
			
		}
		player_time_end = new label(win) {
			move(319,72)
			resize(63,19)
			setstylesheet("color:;background-color:;")
			oFont = new qfont("",0,0,0)
			oFont.fromstring("Arial")
			setfont(oFont)
			oFont.delete()
			setText("00:00:00")
			setAlignment(Qt_AlignHCenter |  Qt_AlignVCenter)
		}
		Play_plyerSlider_layout = new QHBoxLayout() {
			AddWidget(btn_play)
			AddWidget(player_slider)
			
		}
		Currenttime_volume_endtime_layout = new QHBoxLayout() {
			AddWidget(player_time_current)
			AddWidget(btn_volume_mute)
			AddWidget(player_vol_slider)
			AddWidget(player_time_end)
			
		}
		Main_layout = new QVBoxLayout() {
			AddWidget(lbl_audioname)
			AddLayout(Play_plyerSlider_layout)
			AddLayout(Currenttime_volume_endtime_layout)
			
		}

		oMWLayoutWidget = new qWidget() { setLayout(Main_layout) }
		setCentralWidget(oMWLayoutWidget) 
	}

# End of the Generated Source Code File...