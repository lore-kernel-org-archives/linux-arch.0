Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B053002DD;
	Sun,  5 Jul 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783274280; cv=none; b=hT4JHYmSeqXXOnFFC15Sq3J2IUcWqy29iIPtl+w7QAjElxKRvKmca3SPJ0ni1reovdds3yrHH4ljWo3SrmVuAF2VZ+Z7pC8SK0HuxBHZzt7kJr3+PYB+67hIBUaVO38lecnsk0U6zzIl1tHoCtw1b18xZbu7vG6r2U3IvPKgW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783274280; c=relaxed/simple;
	bh=fUQgY2eAV0HWvynC0zVL7MXi/ZMt6s7lUXdcT04753Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZHmpIuM217xHEdbpt+W7p2aAnUNKnq25Zqi4bJppzvEAlbl/BMCyaT2EyvSNsfPZiu+35FYW7PvF6a8gdihY0yKAQkCWB6V3cBvFYj0YMJKTn5pIX1dP+k9KstNYCZXculljK09TdTLu2tI4geQxEWE3loQqbWAyvMQRVUJ5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RS124gIS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RS124gIS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T+8wRAcb2eccitxW8rAQEkvMWfsSNItqwrLGuKFXS/I=; b=RS124gISO+uxmfr8Gww+vhBdJ9
	RtSET59E45upcZwkum8v6qhgmhcySB0wPvPCkpC/DYx7aZx/pc54azDK2JEWK7Hymh6M/YskQURm+
	m6jJWlCIVdo3NeY6+Zig/TzyqoXsYKk8xjoBHJ/hXGb4hFKgtOKZTnhDmlznF5urDeSR5n/x/4gfx
	SOvK61Sp4xfeUnrlf9GS9q6cvQ5U400PFCMBMXHZQEcyjZfUZ0g/pYFccQ55B+g/mk/HflYjjoT+r
	jOXP88jPfngRi2+2asVeDPeIEt/y/Qtb1vCDccuvxwW1hTkgXFfNtoOk6jZYIjZ9rNbhIIQgmOWFE
	Fvg6Zs8A==;
Received: from 201-69-111-23.dial-up.telesp.net.br ([201.69.111.23] helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wgR5s-009PnY-MM; Sun, 05 Jul 2026 19:57:28 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 05 Jul 2026 14:56:53 -0300
Subject: [PATCH v4 3/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260705-tonyk-robust_arm-v4-3-e0fd0fa259d3@igalia.com>
References: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
In-Reply-To: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Based on the x86 implementation, implement the vDSO function for unlocking
a robust futex correctly.

Commit a2274cc0091e ("x86/vdso: Implement __vdso_futex_robust_try_unlock()")
has the full explanation about why this mechanism is needed.

The unlock assembly sequence for arm64 is:

	__vdso_futex_robust_list64_try_unlock:
	retry:
		ldxr	w8, [x0] // Load the value from *futex
		cmp	w1, w8   // Compare with TID
		b.ne	__vdso_futex_list64_try_unlock_cs_end
		stlxr	w3, wzr, [x0] // Try to zero *futex
	__vdso_futex_list64_try_unlock_cs_start:
		cbnz	w3, retry
		str	xzr, [x2] // After zeroing *futex, zero *op_pending
	__vdso_futex_list64_try_unlock_cs_end>:

The decision regarding if the pointer should be cleared or not lies on
checking the w3 register:

	return (regs->user_regs[3]) ? NULL : (void __user *)
		regs->user_regs.regs[2];

If it's zero, that means that the exclusive store worked and the kernel
should clear op_pending (if userspace didn't managed to) stored at x2.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Notes:
 - Only LL/SC for now but I can add LSE later if this looks good

v4:
 - Guard makefile for vfutex.o with ifdef
 - Moved _start label one instruction above
 - Use results register (w3) to check for store success instead of using zero
   flag

v3:
 - Managed to get pop to always be stored at x2
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/futex_robust.h | 19 +++++++++++++++++++
 arch/arm64/kernel/vdso/Makefile       | 10 ++++++++++
 arch/arm64/kernel/vdso/vfutex.c       | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..0582172811d9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -221,6 +221,7 @@ config ARM64
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_FUTEX_ROBUST_UNLOCK
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
diff --git a/arch/arm64/include/asm/futex_robust.h b/arch/arm64/include/asm/futex_robust.h
new file mode 100644
index 000000000000..64f22166756a
--- /dev/null
+++ b/arch/arm64/include/asm/futex_robust.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_FUTEX_ROBUST_H
+#define _ASM_ARM64_FUTEX_ROBUST_H
+
+#include <asm/ptrace.h>
+
+static __always_inline void __user *arm64_futex_robust_unlock_get_pop(struct pt_regs *regs)
+{
+	/*
+	 * w3 is stores the result of the stlxr instruction. If it's zero, the then
+	 * the ll/sc cmpxchg succeeded and the pending op pointer needs to be cleared.
+	 */
+	return (regs->user_regs.regs[3]) ? NULL : (void __user *) regs->user_regs.regs[2];
+}
+
+#define arch_futex_robust_unlock_get_pop(regs)	\
+	arm64_futex_robust_unlock_get_pop(regs)
+
+#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b7..985346c7a0bb 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -11,6 +11,10 @@ include $(srctree)/lib/vdso/Makefile.include
 
 obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
 
+ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+  obj-vdso += vfutex.o
+endif
+
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
@@ -45,9 +49,11 @@ CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
 CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
+CFLAGS_REMOVE_vfutex.o = $(CC_FLAGS_REMOVE_VDSO)
 
 CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
 CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
+CFLAGS_vfutex.o = $(CC_FLAGS_ADD_VDSO)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
@@ -57,6 +63,10 @@ ifneq ($(c-getrandom-y),)
   CFLAGS_vgetrandom.o += -include $(c-getrandom-y)
 endif
 
+ifneq ($(c-futex-y),)
+  CFLAGS_vfutex.o += -include $(c-futex-y)
+endif
+
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
diff --git a/arch/arm64/kernel/vdso/vfutex.c b/arch/arm64/kernel/vdso/vfutex.c
new file mode 100644
index 000000000000..cce5ca8ce609
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vfutex.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/stringify.h>
+#include <vdso/futex.h>
+
+#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)
+
+#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
+
+__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
+{
+	register __u64 *pop_reg asm("x2") = pop;
+	register __u32 result_reg asm("w3") = 0;
+	__u32 val;
+
+	asm volatile (
+		GLOBLS(64)
+		"	prfm pstl1strm, %[lock]			\n"
+		"retry:						\n"
+		"	ldxr %w[val], %[lock]			\n"
+		"	cmp %w[tid], %w[val]			\n"
+		"	bne " LABEL(end, 64)"			\n"
+		"	stlxr %w[result], wzr, %[lock]		\n"
+		LABEL(start, 64)":				\n"
+		"	cbnz %w[result], retry			\n"
+		LABEL(success, 64)":				\n"
+		"	str xzr, %[pop_reg]			\n"
+		LABEL(end, 64)":				\n"
+
+		: [val] "=&r" (val), [result] "=&r" (result_reg)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg)
+		: "memory"
+	);
+
+	return val;
+}

-- 
2.54.0

