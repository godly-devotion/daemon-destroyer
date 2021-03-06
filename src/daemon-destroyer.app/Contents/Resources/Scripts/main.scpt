JsOsaDAS1.001.00bplist00�Vscript_rvar app = Application.currentApplication()
app.includeStandardAdditions = true

var daemons = app.doShellScript(`ls /Library/LaunchDaemons`).split(/[\r\n]+/)

var response = app.chooseFromList(daemons, {
	withTitle: 'daemon-destroyer v0.9',
    withPrompt: `This utility allows you to manually remove launch daemons.\n\nSelect one or more daemon to remove:`,
	okButtonName: 'Remove',
	multipleSelectionsAllowed: true
})

if (!response) {
	app.displayDialog('Nothing selected!', { buttons: ['Cancel'] })
}

try {
	response.forEach(helper => {
		var helperWithoutExt = helper.replace(/\.[^/.]+$/, '')
		app.doShellScript(`sudo launchctl remove /Library/LaunchDaemons/${helper}`, { administratorPrivileges: true })
		app.doShellScript(`sudo rm /Library/LaunchDaemons/${helper}`, { administratorPrivileges: true })
		app.doShellScript(`sudo rm /Library/PrivilegedHelperTools/${helperWithoutExt}`, { administratorPrivileges: true })
	})
	app.displayDialog(`Success!`, { buttons: ['OK'] })
}
catch (e) {
	app.displayDialog(`There was a problem removing the daemon(s). Please make sure you have administrator privileges.`, { buttons: ['OK'] })
}                              �jscr  ��ޭ