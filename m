From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 14/37] nds32: IRQ handling
Date: Tue, 13 Feb 2018 17:09:18 +0800
Message-ID: <ffdd80d006a15f572efdad859f332241b5ce2f73.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch includes irq related functions and irqchip_init().

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/irqflags.h | 36 ++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/irq.c           |  9 +++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/nds32/include/asm/irqflags.h
 create mode 100644 arch/nds32/kernel/irq.c

diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
new file mode 100644
index 000000000000..2bfd00f8bc48
--- /dev/null
+++ b/arch/nds32/include/asm/irqflags.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <asm/nds32.h>
+#include <nds32_intrinsic.h>
+
+#define arch_local_irq_disable()	\
+	GIE_DISABLE();
+
+#define arch_local_irq_enable()	\
+	GIE_ENABLE();
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	flags = __nds32__mfsr(NDS32_SR_PSW) & PSW_mskGIE;
+	GIE_DISABLE();
+	return flags;
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	flags = __nds32__mfsr(NDS32_SR_PSW) & PSW_mskGIE;
+	return flags;
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	if(flags)
+		GIE_ENABLE();
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !flags;
+}
diff --git a/arch/nds32/kernel/irq.c b/arch/nds32/kernel/irq.c
new file mode 100644
index 000000000000..6ff5a672be27
--- /dev/null
+++ b/arch/nds32/kernel/irq.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/irqchip.h>
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
-- 
2.16.1
