From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 00/29] init_task: Use a generic init_task variant
Date: Mon, 30 Apr 2012 20:15:50 -0000
Message-ID: <20120430194725.763322463@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35699 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2D3UPw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 16:15:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org

All architectures do roughly the same to initialize init_task. The
only architecture which deviates is ia64, but I could not figure out
why it couldn't use the same setup as all other architectures.

The following series converts all archs to a generic version.

Thanks,

	tglx
---
 arch/alpha/kernel/init_task.c       |   17 --------
 arch/arm/kernel/init_task.c         |   37 -------------------
 arch/avr32/kernel/init_task.c       |   31 ---------------
 arch/blackfin/kernel/init_task.c    |   32 ----------------
 arch/frv/kernel/init_task.c         |   32 ----------------
 arch/h8300/kernel/init_task.c       |   36 ------------------
 arch/hexagon/kernel/init_task.c     |   54 ---------------------------
 arch/ia64/kernel/init_task.c        |   42 ---------------------
 arch/m32r/kernel/init_task.c        |   34 -----------------
 arch/m68k/kernel/init_task.c        |   35 ------------------
 arch/microblaze/kernel/init_task.c  |   26 -------------
 arch/mips/kernel/init_task.c        |   35 ------------------
 arch/mn10300/kernel/init_task.c     |   39 --------------------
 arch/openrisc/kernel/init_task.c    |   42 ---------------------
 arch/parisc/kernel/init_task.c      |   70 ------------------------------------
 arch/powerpc/kernel/init_task.c     |   29 --------------
 arch/s390/kernel/init_task.c        |   38 -------------------
 arch/sh/kernel/init_task.c          |   30 ---------------
 arch/sparc/kernel/init_task.c       |   22 -----------
 arch/tile/kernel/init_task.c        |   59 ------------------------------
 arch/um/kernel/init_task.c          |   38 -------------------
 arch/unicore32/kernel/init_task.c   |   44 ----------------------
 arch/x86/kernel/init_task.c         |   42 ---------------------
 arch/xtensa/kernel/init_task.c      |   31 ---------------
 tip/arch/alpha/kernel/Makefile      |    2 -
 tip/arch/arm/Makefile               |    2 -
 tip/arch/arm/kernel/Makefile        |    2 -
 tip/arch/avr32/kernel/Makefile      |    2 -
 tip/arch/blackfin/Makefile          |    2 -
 tip/arch/blackfin/kernel/Makefile   |    2 -
 tip/arch/c6x/kernel/process.c       |   16 --------
 tip/arch/cris/kernel/process.c      |   28 --------------
 tip/arch/frv/Makefile               |    2 -
 tip/arch/frv/kernel/Makefile        |    2 -
 tip/arch/h8300/kernel/Makefile      |    2 -
 tip/arch/hexagon/Makefile           |    3 -
 tip/arch/hexagon/kernel/Makefile    |    2 -
 tip/arch/ia64/Makefile              |    2 -
 tip/arch/ia64/kernel/Makefile       |    2 -
 tip/arch/m32r/Makefile              |    2 -
 tip/arch/m32r/kernel/Makefile       |    2 -
 tip/arch/m68k/kernel/Makefile       |    2 -
 tip/arch/microblaze/kernel/Makefile |    2 -
 tip/arch/mips/Makefile              |    2 -
 tip/arch/mips/kernel/Makefile       |    2 -
 tip/arch/mips/kernel/vmlinux.lds.S  |    2 -
 tip/arch/mn10300/Makefile           |    2 -
 tip/arch/mn10300/kernel/Makefile    |    2 -
 tip/arch/openrisc/Makefile          |    2 -
 tip/arch/openrisc/kernel/Makefile   |    2 -
 tip/arch/parisc/mm/init.c           |   12 ++++++
 tip/arch/powerpc/kernel/Makefile    |    2 -
 tip/arch/s390/Makefile              |    1 
 tip/arch/s390/kernel/Makefile       |    2 -
 tip/arch/score/kernel/Makefile      |    2 -
 tip/arch/sh/Makefile                |    2 -
 tip/arch/sh/kernel/Makefile         |    2 -
 tip/arch/tile/kernel/Makefile       |    2 -
 tip/arch/tile/kernel/setup.c        |   16 ++++++++
 tip/arch/um/kernel/Makefile         |    2 -
 tip/arch/um/kernel/um_arch.c        |    5 ++
 tip/arch/unicore32/Makefile         |    1 
 tip/arch/unicore32/kernel/Makefile  |    2 -
 tip/arch/x86/Makefile               |    1 
 tip/arch/x86/kernel/Makefile        |    2 -
 tip/arch/x86/kernel/process.c       |    9 ++++
 tip/arch/xtensa/kernel/Makefile     |    2 -
 tip/kernel/sched/Makefile           |    4 --
 tip/kernel/sched/init_task.c        |   24 ++++++++++++
 69 files changed, 100 insertions(+), 981 deletions(-)
