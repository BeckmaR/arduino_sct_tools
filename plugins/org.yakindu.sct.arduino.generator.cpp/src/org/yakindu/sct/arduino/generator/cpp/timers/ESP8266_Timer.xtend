package org.yakindu.sct.arduino.generator.cpp.timers

import org.yakindu.sct.arduino.generator.cpp.timers.AbstractTimer
import org.yakindu.sct.model.sgen.GeneratorEntry
import org.yakindu.sct.model.sexec.ExecutionFlow
import com.google.inject.Inject
import org.yakindu.sct.arduino.generator.cpp.Naming

class ESP8266_Timer extends AbstractTimer {

	@Inject extension Naming

	override timerName() {
		"ESP8266_Timer"
	}

	override generateTimer(GeneratorEntry it, ExecutionFlow flow) '''
		«header»
		
		#include "«timerName.h»"
		
		«variableDeclarations»
		
		«timerCallback»
		
		«constructor»
		
		«start»
		
		«init»
		
		«setTimer»
		
		«unsetTimer»
		
		«runCycle»
		
		«raiseTimeEvents»
		
		«cancel»
	'''

	override protected headerIncludes(GeneratorEntry it, ExecutionFlow flow) '''
		«super.headerIncludes(it, flow)»
		#include "user_interface.h"
	'''

	protected def CharSequence variableDeclarations(GeneratorEntry it) '''
		bool runCycleFlag = false;
		
		os_timer_t osTimer;
	'''

	protected def CharSequence timerCallback(GeneratorEntry it) '''
		void timerCallback(void *pArg) {
			runCycleFlag = true;
		}
	'''

	override protected initBody(GeneratorEntry it) '''
		os_timer_setfn(&osTimer, timerCallback, NULL);
		os_timer_arm(&osTimer, this->period, true);
	'''

	override protected runCycleBody(GeneratorEntry it) '''
		if (runCycleFlag) {
			«super.runCycleBody(it)»
			runCycleFlag = false;
		}
		yield();
	'''

}
