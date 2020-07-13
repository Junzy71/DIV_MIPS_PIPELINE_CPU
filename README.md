# DIY MIPS-PIPLINE CPU
北京航空航天大学 2018年秋季学期 《计算机组成原理课程设计》：5周期流水线MIPS CPU<br>
Project of 'Design of computer organization '  Course of SCSE BUAA in 2018 fall.
## Overview
本仓库包含有北京航空航天大学 2018年秋季学期 《计算机组成原理课程设计》的P3 P4 P5 P6考核的代码。这四次任务实现的内容分别如下。<br>
This repository contains code for project 3 4 5 6 of period exam of 'Design of computer organization '  Course of SCSE BUAA in 2018 fall. The detailed content we implement in these projects are shown below.<br>

- P3:单周期CPU，在LOGISIM中实现并仿真<br
  Project3: Monocycle CPU implemented and simulated by Logisim.
- P4:单周期CPU，在XINLIX ISE中使用verilog HDL语言实现并仿真
  Project4: Monocycle CPU implemented and simulated by Verilog (Xinlix ISE and ISIM).
- P5:5周期流水线CPU，在XINLIX ISE中使用verilog HDL语言实现并仿真。
  Project5: 5-stage Pipeline CPU implemented and simulated by Verilog (Xinlix ISE and ISIM).
  - 采用五级流水线提高效率 Implemented 5-stage pipeline to improve the efficiency.
  - 通过以最优方式解决冲突（通过全速转发必要的阻塞）提高效率. Implement the optimal hazard control (by implementing full-speed forward & inevitable stall ) to improve the  efficiency.
  - 实现延迟槽 Impelmented the delay-slot.
- P6 支持中断与异常的5周期流水线CPU，在XINLIX ISE中使用verilog HDL语言实现并仿真。
  Project6 : 5-stage Pipeline CPU (supporting Interrupt Request and Exception ) implemented and simulated by Verilog (Xinlix ISE and ISIM)
  - 实现异常和中断发生时进入内核态执行处理程序的功能。 Implement the function of jump into kernel mode when exception and interrupt request occurs.

