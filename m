From: Nick Hu <nickhu@andestech.com>
Subject: [PATCH v2 0/1] nds32: Power management
Date: Wed, 24 Oct 2018 18:14:31 +0800
Message-ID: <cover.1540375392.git.nickhu@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, zong@andestech.com, linux-pm@vger.kernel.org, alankao@andestech.com
Cc: Nick Hu <nickhu@andestech.com>, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

This commit is power management porting for nds32.

Changes in V2:
	1. Fix the my complete name "Nickhu" to "Nick Hu".

	2. Fix missing space in 'arch/nds32/kernel/sleep.S'.

	3. Use normal bit operations to replace the array
'is_bit_1' in 'drivers/irqchip/irq-ativic32.c'.

Nick Hu (1):
  nds32: Power management for nds32

 arch/nds32/Kconfig               |  10 +++
 arch/nds32/include/asm/suspend.h |  11 +++
 arch/nds32/kernel/Makefile       |   2 +-
 arch/nds32/kernel/pm.c           |  79 +++++++++++++++++++
 arch/nds32/kernel/sleep.S        | 129 +++++++++++++++++++++++++++++++
 drivers/irqchip/irq-ativic32.c   |  31 ++++++++
 6 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 arch/nds32/include/asm/suspend.h
 create mode 100644 arch/nds32/kernel/pm.c
 create mode 100644 arch/nds32/kernel/sleep.S

-- 
2.17.0
