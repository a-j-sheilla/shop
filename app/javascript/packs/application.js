import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
// app/javascript/packs/application.js

import "../channels"
import "../global"
import "../products"


Rails.start()
Turbolinks.start()
ActiveStorage.start()

