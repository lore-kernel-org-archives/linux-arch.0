From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 09/35] nds32: IRQ handling
Date: Mon, 27 Nov 2017 20:27:56 +0800
Message-ID: <0e52bbdb4843d023b161f414aa206370d9f7771a.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch includes irq related functions and irqchip_init().

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/irqflags.h |   49 +++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/irq.c           |   22 +++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/nds32/include/asm/irqflags.h
 create mode 100644 arch/nds32/kernel/irq.c

diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
new file mode 100644
index 0000000..7c1940f
--- /dev/null
+++ b/arch/nds32/include/asm/irqflags.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
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
index 0000000..119dc9f
--- /dev/null
+++ b/arch/nds32/kernel/irq.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/irqchip.h>
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
-- 
1.7.9.5
