import QtQuick
import QtQuick.Controls as QQC
import Quickshell
import qs.Ui
import qs.Commons
import "cheatsheet.js" as Sheet

Panel {
  id: root
  moduleName: "local.obsidian-cheatsheet"
  ipcTarget: "local.obsidian-cheatsheet"
  manageIpc: false

  property string query: ""
  property string category: "All"
  property int selectedIndex: 0
  property bool cursorActive: false

  readonly property var rows: Sheet.filtered(query, category)

  onOpenedChanged: {
    if (opened) {
      query = ""
      searchInput.text = ""
      category = "All"
      selectedIndex = 0
      cursorActive = false
      searchInput.forceActiveFocus()
    }
  }

  function moveCursor(delta) {
    if (rows.length === 0) return
    selectedIndex = Math.max(0, Math.min(rows.length - 1, selectedIndex + delta))
    cursorActive = true
    Qt.callLater(ensureVisible)
  }

  function ensureVisible() {
    var row = repeater.itemAt(selectedIndex)
    if (!row) return
    var flick = scroll.contentItem
    if (!flick || listCol.height <= scroll.availableHeight) return
    var top = flick.contentY
    var bottom = top + flick.height
    var nt = top
    if (row.y < top) nt = row.y
    else if (row.y + row.height > bottom) nt = row.y + row.height - flick.height
    if (nt !== top) {
      var mx = Math.max(0, flick.contentHeight - flick.height)
      flick.contentY = Math.max(0, Math.min(mx, nt))
    }
  }

  function copyRow(item) {
    if (!item) return
    // Copy the shortcut/syntax token (left column) to clipboard.
    Quickshell.execDetached(["sh", "-c", "printf %s " + quoted(item.k) + " | wl-copy 2>/dev/null || printf %s " + quoted(item.k) + " | xclip -selection clipboard 2>/dev/null || true"])
  }

  function quoted(s) {
    return "'" + String(s).replace(/'/g, "'\\''") + "'"
  }

  implicitWidth: Style.bar.iconSlot
  implicitHeight: Style.bar.iconSlot

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "◈"
    tooltipText: "Obsidian cheatsheet (shortcuts + formatting)"
    onPressed: function(b) { root.toggle() }
  }

  KeyboardPanel {
    id: panel
    anchorItem: button
    owner: root
    bar: root.bar
    open: root.opened
    focusTarget: searchInput
    contentWidth: panel.fittedContentWidth(Style.space(430))
    contentHeight: panel.fittedContentHeight(col.implicitHeight)

    Column {
      id: col
      anchors.fill: parent
      spacing: Style.space(8)

      Text {
        width: parent.width
        leftPadding: Style.space(10)
        text: "OBSIDIAN  •  SHORTCUTS + FORMATTING"
        color: Qt.darker(root.bar.foreground, 1.4)
        font.family: root.bar.fontFamily
        font.pixelSize: Style.font.caption
        font.bold: true
        font.letterSpacing: 1.2
      }

      TextField {
        id: searchInput
        width: parent.width
        foreground: root.bar.foreground
        accent: Color.accent
        font.family: root.bar.fontFamily
        font.pixelSize: Style.font.body
        placeholderText: "Filter… (e.g. bold, table, graph)"
        focus: true
        activeFocusOnTab: true
        onTextChanged: {
          root.query = text
          root.selectedIndex = 0
          root.cursorActive = false
        }
        Keys.onPressed: function(event) {
          if (event.key === Qt.Key_Down) { root.moveCursor(1); event.accepted = true }
          else if (event.key === Qt.Key_Up) { root.moveCursor(-1); event.accepted = true }
          else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) { root.copyRow(root.rows[root.selectedIndex]); event.accepted = true }
          else if (event.key === Qt.Key_Escape) { root.close(); event.accepted = true }
        }
      }

      Row {
        width: parent.width
        spacing: Style.space(6)
        Repeater {
          model: Sheet.categories
          delegate: Rectangle {
            required property string modelData
            readonly property bool active: root.category === modelData
            height: catLabel.implicitHeight + Style.space(10)
            width: catLabel.implicitWidth + Style.space(20)
            radius: Style.cornerRadius
            color: active ? Color.accent : Qt.alpha(root.bar.foreground, 0.10)
            Text {
              id: catLabel
              anchors.centerIn: parent
              text: parent.modelData
              color: root.bar.foreground
              font.family: root.bar.fontFamily
              font.pixelSize: Style.font.bodySmall
              font.bold: parent.active
            }
            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: {
                root.category = parent.modelData
                root.selectedIndex = 0
                root.cursorActive = false
                searchInput.forceActiveFocus()
              }
            }
          }
        }
      }

      PanelSeparator { foreground: root.bar.foreground }

      QQC.ScrollView {
        id: scroll
        width: parent.width
        implicitHeight: Math.min(listCol.implicitHeight, Style.space(380))
        clip: true
        QQC.ScrollBar.horizontal.policy: QQC.ScrollBar.AlwaysOff

        Column {
          id: listCol
          width: scroll.availableWidth
          spacing: 2

          Repeater {
            id: repeater
            model: root.rows
            delegate: CursorSurface {
              required property var modelData
              required property int index
              width: listCol.width
              readonly property bool selected: root.cursorActive && root.selectedIndex === index
              implicitHeight: Math.max(keyText.implicitHeight, descText.implicitHeight) + Style.space(12)
              hasCursor: selected
              foreground: root.bar.foreground
              fill: Style.hoverFillFor(root.bar.foreground, Color.accent)
              currentFill: Style.selectedFillFor(root.bar.foreground, Color.accent)

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onContainsMouseChanged: if (containsMouse) { root.selectedIndex = parent.index; root.cursorActive = true }
                onClicked: root.copyRow(parent.modelData)
              }

              Row {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: Style.space(10)
                anchors.rightMargin: Style.space(10)
                spacing: Style.space(10)
                Text {
                  id: keyText
                  width: parent.width * 0.42
                  text: parent.parent.modelData.k
                  color: Color.accent
                  font.family: "monospace"
                  font.pixelSize: Style.font.bodySmall
                  font.bold: true
                  elide: Text.ElideRight
                  wrapMode: Text.Wrap
                }
                Text {
                  id: descText
                  width: parent.width * 0.58 - parent.spacing
                  text: parent.parent.modelData.d
                  color: root.bar.foreground
                  font.family: root.bar.fontFamily
                  font.pixelSize: Style.font.bodySmall
                  elide: Text.ElideRight
                  wrapMode: Text.Wrap
                }
              }
            }
          }

          Text {
            visible: root.rows.length === 0
            width: parent.width
            leftPadding: Style.space(10)
            text: "No matches."
            color: Qt.darker(root.bar.foreground, 1.4)
            font.family: root.bar.fontFamily
            font.pixelSize: Style.font.bodySmall
          }
        }
      }

      Text {
        width: parent.width
        leftPadding: Style.space(10)
        text: "Enter / click = copy key  •  ↑↓ navigate  •  Esc close"
        color: Qt.darker(root.bar.foreground, 1.6)
        font.family: root.bar.fontFamily
        font.pixelSize: Style.font.caption
      }
    }
  }
}
