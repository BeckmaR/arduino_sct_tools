# Arduino SCT Project Setup

To start programming your Arduino, you need to create a project. After closing the Welcome page open the context menu of the Project Explorer view in the upper left corner of the Eclipse Window and select "New">"Project...".

![New Project](screenshots/NewProjectContextMenu.png)

Select "Arduino Project with YAKINDU Statechart" from the list on the first page of the New Project wizard and click "Next>".

![New Project Wizard](screenshots/NewProjectWizard.png)

On the next page, choose a project name and click "Next>".

![New Arduino SCT Project - Project Name](screenshots/NewArduinoProjectWizardPage.png)

On the last page you can choose values for a set of properties of the Arduino SCT project. These are

* a name for the statechart. The default is the project name. You can choose any valid C++ identifier, since it will be used as a class name.
* a source code folder - it will contain the source code that will be edited by you. Initially, two files will be generated and put into this folder, &lt;StatechartName&gt;Connector.h and &lt;StatechartName&gt;Connector.cpp. After the first code generation these files will be kept untouched by the code generation.
* a generated source code folder - it will contain all the rest of the source code generated by the tool that is necessary to run your statechart on the Arduino. The source code in this folder should not be changed by the user and will be overwritten by the code generator.
* the timer implementation - there are several timer implementations to run the cycles of the statechart. You can choose between a generic software based timer that is compatible to most microcontrollers and hardware based timers for various microcontrollers.

After setting the properties, click "Finish".

![New Arduino SCT Project - Project Properties](screenshots/ProjectPropertiesWizardPage.png)

You might be asked whether the Xtext nature should be added to the project. Please confirm this question.

Your Eclipse should look like this:

![New Arduino SCT Project - Project Properties](screenshots/NewArduinoSCTProject.png)
