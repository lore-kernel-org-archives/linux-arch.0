Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9781D5AD4;
	Fri, 18 Sep 2026 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691258; cv=none; b=kHlurRl9hmlv6/TixIqUZ6SLcVY5Fiw1kZ1QjaWPPHMY3k/97OUNnjqvAEs99TMghM4HBE+md/d1Wm7OrtBl+4h+s9x7ElcT49MGmi91WNlxGU7Rjcc1B2N/jwVGkKYg5H9IHhQOxDBdsZnMx/hvDNrutZZWsXZM3oReQqEe1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691258; c=relaxed/simple;
	bh=R3gZqfgcCnb3nnmEfbBX3M/oTrdXI8HFAZlXc6hU8C8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyjM7rXbI+0cVk4o617SHtaFJvOqiNhMTWhhvbCC1wqGEmmpJtdw1JOYMsWgJEnlz1rkGiGMeoPsAt53Jbq/ZKM/lO5ijdEpPNZbpphr+iEQm76d0+nC+bPIAVln4khchrX2DdjXxDmSwh3RJvYcFgKGTa9rijzlr9EUEx7ffHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dX+xbrzH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dX+xbrzH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=L0EVnDrLrlZsk6u+X20+pzKDeqqgQ00+8S0/mdXWL1c=; b=dX+xbrzHq4IOyXYKAgVtgh4Vef
	yD9lpi9TGtBhOP3mYXSJBL+W6zq8YFvkxfwCuJOT2dy5mYY2MffvF42LVamvquCobXvTxWgqiiYfG
	BjsjGam9lZFysp/blaw8BKB9Afy9ngQ9Tot/h5nqUfBQrs7sT4Bg4ltKaXg8ttXXvNUGERa8WiOVP
	wr/JwT6l5DL6hEtKJ8sfyFDN16dD8FNpoTI0CE8rxPMKgFtQGWjAFi9dtgGuMI9q9VK6WaFZYYNNv
	wlTxCESxHmu1FeqrC3kTXZBOx5g0lz84FuGar5iO9XiMlboegl/VXCDMIVsvEN8/iOQPO8z1etFOb
	c4QlA9XQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7MRp-003iDv-EY; Fri, 18 Sep 2026 02:27:25 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Sep 2026 21:27:00 -0300
Subject: [PATCH v9 2/3] arm64: vdso: Prepare for robust futex unlock
 support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-tonyk-robust_arm-v9-2-ab082b1b4c4b@igalia.com>
References: <20260917-tonyk-robust_arm-v9-0-ab082b1b4c4b@igalia.com>
In-Reply-To: <20260917-tonyk-robust_arm-v9-0-ab082b1b4c4b@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

To solve the robust futex's list_pending_op clearing race condition,
prepare for implement __vdso_futex_robust_try_unlock() for arm64 with the
following steps:

- Create a helper function that sets the struct futex_mm_data with the
VDSO's labels addresses. The robust futex fixup mechanism needs to
compare the current instruction pointer to the VDSO instructions range.

- Split vdso_mremap() in vdso_mremap() and aarch32_mremap(), this allows
the VDSO to be setup correctly regarding the instructions addresses for
both ABIs when a mremap happens.

- Implement arch_futex_robust_unlock_get_pop() for arm64, checking for r2
and r3 registers values for the fixup function. The role of this registers
is explained in the commit that implement the assembly portion of the VDSO.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v9:
 - Simplify arm64_futex_robust_unlock_get_pop by using regs->regs[] and if
 instead of ternary operation
 - Split mremap changes into other patch

v6:
 - Restructured this commit. Move the arch bits away, kept just the
 generic/helper functions.

v4:
- Guard symbols from vdso.lds.S with ifdef
- drop update_ips() from sigpage remap function

v3:
 - Fix adding vdso base addr twice
 - Call vdso_futex_robust_unlock_update_ips() on remap as well
v2:
 - Fixed linker not finding VDSO symbols
---
---
 arch/arm64/include/asm/futex_robust.h | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/vdso.c              | 17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/include/asm/futex_robust.h b/arch/arm64/include/asm/futex_robust.h
new file mode 100644
index 000000000000..389ce2a9484d
--- /dev/null
+++ b/arch/arm64/include/asm/futex_robust.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_FUTEX_ROBUST_H
+#define _ASM_ARM64_FUTEX_ROBUST_H
+
+#include <asm/ptrace.h>
+
+static __always_inline void __user *arm64_futex_robust_unlock_get_pop(struct pt_regs *regs)
+{
+	/*
+	 * In the asm for __vdso_futex_robust_list{64,32}_try_unlock(), w3
+	 * stores the result of the stlxr instruction. If it's zero, the then
+	 * the ll/sc cmpxchg succeeded and the pending op pointer needs to be
+	 * cleared.
+	 */
+	if (regs->regs[3])
+		return NULL;
+
+	return (void __user *)regs->regs[2];
+}
+
+#define arch_futex_robust_unlock_get_pop(regs) \
+	arm64_futex_robust_unlock_get_pop(regs)
+
+#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 089a70d96220..95162061cd82 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -11,6 +11,7 @@
 #include <linux/clocksource.h>
 #include <linux/elf.h>
 #include <linux/err.h>
+#include <linux/futex.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
@@ -57,6 +58,22 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 #endif /* CONFIG_COMPAT_VDSO */
 };
 
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit, void *startp,
+					   void *endp)
+{
+	unsigned long start = (unsigned long)startp;
+	unsigned long end = (unsigned long)endp;
+	struct futex_mm_data *fd = &mm->futex;
+
+	futex_set_vdso_cs_range(fd, 0, start, end, is_32bit);
+}
+
+#else
+static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit, void *startp,
+					   void *endp)
+#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
+
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *new_vma)
 {

-- 
2.55.0

