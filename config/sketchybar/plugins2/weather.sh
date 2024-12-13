sketchybar --set $NAME \
  label="加载中..." \
  icon.color=0xff5edaff

# fetch weather data
#LOCATION="Boston"
#REGION="Massachusetts"
#COUNTRY="US"

# Line below replaces spaces with +
#LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
LOCATION_ESCAPED="Cambridge-Massachusetts"
WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")

# Fallback if empty
if [ -z $WEATHER_JSON ]; then
  sketchybar --set $NAME label="$LOCATION"
  #return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_F' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{16\}\).*/\1.../')

sketchybar --set $NAME \
  label="$TEMPERATURE$(echo '°')F • $WEATHER_DESCRIPTION"
