/**
 * Copyright (c) 2016 by Lothar Wendehals.
 * 
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.yakindu.sct.arduino.generator.cpp

import com.google.inject.Inject
import org.yakindu.sct.arduino.generator.cpp.extensions.ArchitecturesExtension
import org.yakindu.sct.arduino.generator.cpp.extensions.TimerElement
import org.yakindu.sct.arduino.generator.cpp.features.IArduinoFeatureConstants
import org.yakindu.sct.model.sgen.GeneratorEntry
import org.yakindu.sct.generator.core.library.ICoreLibraryHelper

class ArduinoGenmodelEntries extends org.yakindu.sct.generator.c.extensions.GenmodelEntries {

	@Inject extension ICoreLibraryHelper coreLibraryHelper

	def private getGeneratorOptionsFeature(GeneratorEntry it) {
		getFeatureConfiguration(IArduinoFeatureConstants::FEATURE_NAME)
	}

	def String getUserSrcFolder(GeneratorEntry it) {
		generatorOptionsFeature?.getParameterValue(IArduinoFeatureConstants::PARAM_USER_SRC_FOLDER).stringValue
	}

	def String getSrcGenFolder(GeneratorEntry it) {
		coreLibraryHelper.getTargetFolderValue(it).stringValue
	}

	def TimerElement getTimer(GeneratorEntry it) {
		val timerId = generatorOptionsFeature?.getParameterValue(IArduinoFeatureConstants::PARAM_TIMER).stringValue
		ArchitecturesExtension.getTimer(timerId)
	}

	def int cyclePeriod(GeneratorEntry it) {
		val paramValue = generatorOptionsFeature?.getParameterValue(IArduinoFeatureConstants::PARAM_CYCLE_PERIOD)
		if (paramValue !== null) {
			try {
				return Integer.parseInt(paramValue.stringValue);
			} catch (NumberFormatException exception) {
			}
		}

		return IArduinoFeatureConstants::CYCLE_PERIOD_DEFAULT
	}

	def String srcGenFolderRelativeToUserSrc(GeneratorEntry it) {
		folderRelativeToOther(srcGenFolder, userSrcFolder)
	}

	def String userSrcFolderRelativeToSrcGen(GeneratorEntry it) {
		folderRelativeToOther(userSrcFolder, srcGenFolder)
	}

	def String folderRelativeToOther(String folder, String otherFolder) {
		if (otherFolder.equals(folder)) {
			""
		} else if (otherFolder.empty) {
			folder + "/"
		} else if (folder.empty) {
			"../"
		} else {
			"../" + folder + "/"
		}
	}

}
