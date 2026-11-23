<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="CombatLogToggle" version="1.4.0" date="2026-11-22">
		<Author name="Trevor" email="" />
		<Description text="A movable Combat log toggle with right-click options for opacity and position lock." />
		<VersionSettings gameVersion="1.4.8" windowsVersion="1.4" savedVariablesVersion="1.0" />
		<Dependencies>
			<Dependency name="EATemplate_DefaultWindowSkin" />
			<Dependency name="EA_ChatWindow" />
			<Dependency name="DisableCombatLog" optional="true" forceEnable="false" />
		</Dependencies>
		<Files>
			<File name="CombatLogToggle.lua" />
			<File name="CombatLogToggle.xml" />
		</Files>
		<OnInitialize>
			<CallFunction name="CombatLogToggle.Initialize" />
		</OnInitialize>
		<SavedVariables>
			<SavedVariable name="CombatLogToggle.Settings" />
		</SavedVariables>
		<WARInfo>
			<Categories>
				<Category name="SYSTEM" />
				<Category name="OTHER" />
			</Categories>
		</WARInfo>
	</UiMod>
</ModuleFile>









