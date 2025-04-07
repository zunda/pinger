import consumer from "channels/consumer"

const table = document.getElementById("ping-stats")
let count = 0
let countNode = undefined
let untilCell = undefined

const noteInput = document.getElementById("input-note")
let note = noteInput.value
let noteCell = undefined

const pingInterval = 10000 // msec
let periodicPinger = undefined

const echoChannel = consumer.subscriptions.create("EchoChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    addStatsRow()
    ping()
    periodicPinger = setInterval(ping, pingInterval)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    clearInterval(periodicPinger)
    const ts = new Date()
    untilCell.replaceChild(
     document.createTextNode(ts.toLocaleTimeString()),
     untilCell.childNodes[0]
    )
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const received_at = Date.now()
    const sent_at = data
    this.perform("report", { sent_at: sent_at, received_at: received_at, note: note })
    count++
    countNode.nodeValue = count.toString()
  }
});

function ping() {
  echoChannel.perform("ping", { ping: Date.now() })
}

function addHeader() {
  const header = ["Since", "Until", "Note", "Pings"]
  const row = table.insertRow(-1)
  for(var i = 0; i < header.length; i++) {
    const cell = document.createElement("th")
    cell.innerHTML = header[i]
    row.insertCell(-1).appendChild(cell)
  }
}
addHeader()

function addStatsRow() {
  const row = table.insertRow(1)

  const ts = new Date()
  const sinceCell = row.insertCell(-1)
  sinceCell.style.textAlign = "center"
  sinceCell.appendChild(document.createTextNode(ts.toLocaleTimeString()))

  untilCell = row.insertCell(-1)
  untilCell.style.textAlign = "center"
  untilCell.appendChild(document.createTextNode("-"))

  noteCell = row.insertCell(-1)
  noteCell.style.textAlign = "left"
  noteCell.appendChild(document.createTextNode(note))

  count = 0
  const countCell = row.insertCell(-1)
  countCell.style.textAlign = "right"
  countNode = document.createTextNode(count.toString())
  countCell.appendChild(countNode)
};

function updateNote() {
  note = noteInput.value
  noteCell.replaceChild(document.createTextNode(note), noteCell.childNodes[0])
}
document.getElementById("botton-note").addEventListener("click", updateNote)
