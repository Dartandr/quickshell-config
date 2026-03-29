const config = {

  battery: true, // show battery in bar

  defaultWallpaper: "", // if new monitor connected this wallpaper will applyed instead of white screen
  monitors: [
    {
        name: "", // screen name
        wallpaper: "" // absolute path to wallpaper
    }
  ],

  volumeScreen: "", // screen name where volume control will be displayed

  notification:{
    sound: "", // absolute path to notification sound wav only
    monitor: "", // screen name where notifications will be displayed
    disableSoundFor: [] // array of string, apps name where disable notification
  }

}