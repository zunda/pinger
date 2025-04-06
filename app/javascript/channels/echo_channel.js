import consumer from "channels/consumer"

const table = document.getElementById("ping-stats")
let count = 0;
let countNode = undefined;
let untilCell = undefined;

consumer.subscriptions.create("EchoChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    addStatsRow()
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    const ts = new Date()
    untilCell.replaceChild(
     document.createTextNode(ts.toLocaleTimeString()),
     untilCell.childNodes[0]
    )
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    this.perform('pong', { message: data })
    count++
    countNode.nodeValue = count.toString()
  }
});

function addHeader() {
  const header = ["Since", "Until", "Pings"]
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

  count = 0
  const countCell = row.insertCell(-1)
  countCell.style.textAlign = "right"
  countNode = document.createTextNode(count.toString())
  countCell.appendChild(countNode)
};
