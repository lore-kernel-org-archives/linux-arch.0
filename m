From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 11/36] nds32: IRQ handling
Date: Mon, 18 Dec 2017 14:46:23 +0800
Message-ID: <2ea5c34810b7c1690c4a7003ec83bc8493fb50d3.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch includes irq related functions and irqchip_init().

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/irqflags.h |   36 ++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/irq.c           |    9 +++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/nds32/include/asm/irqflags.h
 create mode 100644 arch/nds32/kernel/irq.c

diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
new file mode 100644
index 0000000..2bfd00f
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
index 0000000..6ff5a67
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
1.7.9.5
