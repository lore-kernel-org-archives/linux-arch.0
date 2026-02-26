Received: from lf-1-130.ptr.blmpb.com (lf-1-130.ptr.blmpb.com [103.149.242.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C4393DED
	for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094535; cv=none; b=jvk7QeQ8bNaBXawVx4IWE5M87unuM/2LWb/K0HRkkadOulEBgTADy1JOM5T7Ik2imrKZQxQnYIQsiJEgwy+eyFNk6flmMlG1xoaxRKbhaCn3Te5U34DpAxSh4Yc4J4kBbHyjLSWcC5pWSURyGCXZszMhjIE7o3nSmYj7TAF90/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094535; c=relaxed/simple;
	bh=ulQthRyIAK9yeGna1ksb119LKas/18cDexk9WzdBREc=;
	h=Subject:Content-Type:To:Cc:From:Date:Message-Id:Mime-Version; b=u9kBR3nXMp7075c5d+wtzHvMk69zPDnTT2Ve/HiASyvpoxkvkr3Rc01elYIfngbV+DXp0AX8ZQjdM46GlF+oV1lwEzYY75Jh1j+NfpjDybI4oqE4Yr7xWstsBD3ZvEPtH3sP3vfuChMXukOwdR5pInLYmraexs3GtoPJs1l5JYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ViJjUsg4; arc=none smtp.client-ip=103.149.242.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ViJjUsg4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772094479; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YX4HotLpgLzmICZWnqayQwB2/3zVuyZwxBVhPxFXqpw=;
 b=ViJjUsg4BhMT0Sr2PEFFO6UNXOb9xTcEIxNWC6g72/x/krHvoK9rdAmvCmLBp63EIz/6DR
 RC5Wbd5qGLM8C12F7ll4tQpH3a7ZrF4C7UJPxL2oJyxkgWYobn7mlzrAUvZ5OeaW89+04D
 IKYoOBF/b6C+Xms6VYy8DylMmDYzITpwIdt02ZhYiFcnxAme6WqBa0FLJG4bYTDJ9S7400
 LioXDr3kiQjy6/KxmP2mop0aVXpl7CFYD7EC/lc2I/kTaraxhb0v7k9KQJ6B57FO5/p+it
 oZfPtO7HOuU9XNHFeyEpdlgTZDHeofK8lKVGQDOzJiDuwd2W4mRz0hJepzT2GA==
Subject: [PATCH] riscv: add system error interrupt handler support
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+269a0040d+904615+vger.kernel.org+qirui.001@bytedance.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <cyrilbur@tenstorrent.com>, 
	<tglx@kernel.org>, <peterz@infradead.org>, <debug@rivosinc.com>, 
	<andybnac@gmail.com>, <charlie@rivosinc.com>, <geomatsi@gmail.com>, 
	<thuth@redhat.com>, <bjorn@rivosinc.com>, <songshuaishuai@tinylab.org>, 
	<martin@kaiser.cx>, <masahiroy@kernel.org>, <kees@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Thu, 26 Feb 2026 16:27:35 +0800
Message-Id: <20260226082735.56108-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Add a system error interrupt handler for RISC-V that panics
the system when hardware errors are detected. The implementation includes:

- Add IRQ_SYS_ERROR (23) interrupt definition to CSR header
- Implement sys_error.c module with panic handler
- Register per-CPU interrupt handler for system error interrupts
- Add module to kernel build system

When a system error interrupt occurs, the handler immediately panics
the system with a descriptive message to ensure the error is properly
captured and the system is halted safely.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/include/asm/csr.h  |  4 +-
 arch/riscv/kernel/Makefile    |  1 +
 arch/riscv/kernel/sys_error.c | 80 +++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h    |  1 +
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/sys_error.c

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 31b8988f4488..1f43c25b07ed 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -99,7 +99,8 @@
 #define IRQ_M_EXT		11
 #define IRQ_S_GEXT		12
 #define IRQ_PMU_OVF		13
-#define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
+#define IRQ_SYS_ERROR		23
+#define IRQ_LOCAL_MAX		(IRQ_SYS_ERROR + 1)
 #define IRQ_LOCAL_MASK		GENMASK((IRQ_LOCAL_MAX - 1), 0)
 
 /* Exception causes */
@@ -535,6 +536,7 @@
 # define RV_IRQ_TIMER	IRQ_S_TIMER
 # define RV_IRQ_EXT		IRQ_S_EXT
 # define RV_IRQ_PMU	IRQ_PMU_OVF
+# define RV_IRQ_SYS_ERROR	IRQ_SYS_ERROR
 # define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
 
 #endif /* !CONFIG_RISCV_M_MODE */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index cabb99cadfb6..3aaf16c75d6e 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -72,6 +72,7 @@ obj-y	+= vendor_extensions.o
 obj-y	+= vendor_extensions/
 obj-y	+= probes/
 obj-y	+= tests/
+obj-y	+= sys_error.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 obj-$(CONFIG_RISCV_USER_CFI) += vdso_cfi/
 
diff --git a/arch/riscv/kernel/sys_error.c b/arch/riscv/kernel/sys_error.c
new file mode 100644
index 000000000000..5b88ff4a0e84
--- /dev/null
+++ b/arch/riscv/kernel/sys_error.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Bytedance, Inc.
+ */
+#define pr_fmt(fmt) "riscv-sys-error: " fmt
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/module.h>
+#include <asm/irq.h>
+#include <linux/cpuhotplug.h>
+#include <asm/csr.h>
+
+static unsigned int riscv_sys_error_irq;
+static DEFINE_PER_CPU_READ_MOSTLY(int, sys_error_dummy_dev);
+
+static irqreturn_t sys_error_irq_handler(int irq, void *dev)
+{
+	panic("RISC-V System Error Interrupt - System Error Detected");
+	return IRQ_HANDLED;
+}
+
+static int riscv_serror_starting_cpu(unsigned int cpu)
+{
+	csr_set(CSR_IE, BIT(RV_IRQ_SYS_ERROR));
+	enable_percpu_irq(riscv_sys_error_irq, irq_get_trigger_type(riscv_sys_error_irq));
+	return 0;
+}
+
+static int riscv_serror_dying_cpu(unsigned int cpu)
+{
+	csr_clear(CSR_IE, BIT(RV_IRQ_SYS_ERROR));
+	disable_percpu_irq(riscv_sys_error_irq);
+	return 0;
+}
+
+static int __init sys_error_init(void)
+{
+	int ret;
+	struct irq_domain *domain = NULL;
+
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("Failed to find INTC IRQ root domain\n");
+		return -ENODEV;
+	}
+
+	riscv_sys_error_irq = irq_create_mapping(domain, RV_IRQ_SYS_ERROR);
+	if (!riscv_sys_error_irq) {
+		pr_err("Failed to map PMU interrupt for node\n");
+		return -ENODEV;
+	}
+
+	ret = request_percpu_irq(riscv_sys_error_irq, sys_error_irq_handler,
+				 "riscv-syserror", &sys_error_dummy_dev);
+	if (ret) {
+		pr_err("registering percpu irq failed [%d]\n", ret);
+		return ret;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_RISCV_SERROR_STARTING,
+			 "riscv/sys_error:starting",
+			 riscv_serror_starting_cpu, riscv_serror_dying_cpu);
+	if (ret) {
+		pr_err("cpuhp setup state failed [%d]\n", ret);
+		goto fail_free_irq;
+	}
+
+	return 0;
+
+fail_free_irq:
+	free_percpu_irq(riscv_sys_error_irq, &sys_error_dummy_dev);
+	return ret;
+}
+
+arch_initcall(sys_error_init)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 62cd7b35a29c..f6d0c05f72df 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -174,6 +174,7 @@ enum cpuhp_state {
 	CPUHP_AP_REALTEK_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CLINT_TIMER_STARTING,
+	CPUHP_AP_RISCV_SERROR_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
-- 
2.20.1
