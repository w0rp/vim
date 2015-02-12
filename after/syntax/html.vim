syn region  djangotagmarkers start="{{" end="}}"
syn region  djangovariablemarkers start="{%" end="%}"

hi def link djangotagmarkers PreProc
hi def link djangovariablemarkers PreProc

