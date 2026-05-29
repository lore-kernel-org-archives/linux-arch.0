Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B693EAC75;
	Fri, 29 May 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072475; cv=none; b=m0x+DABRRXoqne3+UwtSFAJZ/Qn8+Ej92BfbePQfUUEt5AEbrsWYqaE1G8GOToZ1z5dvsAYMEl+CTFpwHB/UpJsEi1Rv66AxbO7ufPObF6WvgQy45BprWWvLmdz+zAl5nyDN7Xt/++l8aNycVlZ/EZtpcyM36xWAsVJH1p9u7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072475; c=relaxed/simple;
	bh=ad/lOM9pNK+ZEm0pyc2GakKY2Qtcn3HXvPITXZYHmPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lh1x4u4wNN2mRTTHG640rZEqQSGh1683RdNX4BPcbxazMKPvBvSlLvyrAaF1EixFSJ6pLGlTWG8631ijfD1VKWNjNGmmaHYA6rgU/StX5WqCBmrn3RDofVKaKAsEvnBatB+x+bVQDNUtRrz0DzQesbOi8HaiAEqnqjrV1uChx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S+8GbiJs; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S+8GbiJs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6WcRY4Z+p3MulPsyGPTPfwV8fk5LXzYsNAzXDfEH3i0=; b=S+8GbiJsoZEoxg22jyDYFKHWmg
	YsZkJ2Q0EJ/pgtlkaCfKEMK/NqGU9RanADVlz3J/JpHEx3mXxREdSq3jZ8TfpJcDJJIA6ECQdc0CU
	RNamPwkFIP63aqr26BEmdGZh22pVYFL3l32yJ/G0UKg0zzeKzuruWL4kCtBvSMnyB20eHz9JtvtOz
	X0LYVNUW47Gdc0EYLtyz/2TVmBEt0mzE6JCSq82g4rKCpG9SQpeWcfTHMtmNgcz4N7WiuZwBpZY3P
	+GURuprrPZCYRym98ft1ps/jGzvyL8SZ2E+cUcwPwI1HrHiLXQI+Byjrv8EZpug8XxMYe11dw6yw9
	TzolmJKA==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wT0AG-009wov-D4; Fri, 29 May 2026 18:34:28 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 29 May 2026 13:33:54 -0300
Subject: [PATCH v3 2/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-tonyk-robust_arm-v3-2-a6f02684d4fe@igalia.com>
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
In-Reply-To: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Based on the x86 implementation, implement the vDSO function for unlocking
a robust futex correctly.

Commit xxxxxxxxxxxx ("x86/vdso: Implement __vdso_futex_robust_try_unlock()") has
the full explanation about why this mechanism is needed.

The unlock assembly sequence for arm64 is:

	__vdso_futex_robust_list64_try_unlock:
	retry:
		ldxr	w8, [x0] // Load the value from *futex
		cmp	w1, w8   // Compare with TID
		b.ne	__vdso_futex_list64_try_unlock_cs_end
		stlxr	w9, wzr, [x0] // Try to zero *futex
		cbnz	w9, retry
	__vdso_futex_list64_try_unlock_cs_start:
		str	xzr, [x2] // After zeroing *futex, zero *op_pending
	__vdso_futex_list64_try_unlock_cs_end>:

The decision regarding if the pointer should be cleared or not lies on checking
the condition flag zero:

	return (regs->user_regs.pstate & PSR_Z_BIT) ?
		(void __user *) regs->user_regs.regs[2] : NULL;

If it's not zero, that means that the comparassion worked and the kernel should
clear op_pending (if userspace didn't managed to) stored at x2.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Notes:
 - Only LL/SC for now but I can add LSE later if this looks good

v3:
 - Managed to get pop to always be stored at x2
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/futex_robust.h | 20 ++++++++++++++++++++
 arch/arm64/kernel/vdso/Makefile       |  9 ++++++++-
 arch/arm64/kernel/vdso/vfutex.c       | 34 ++++++++++++++++++++++++++++++++++
 include/vdso/futex.h                  |  1 +
 5 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 427151a9db7f..e10cb97a51c7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -249,6 +249,7 @@ config ARM64
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_FUTEX_ROBUST_UNLOCK
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
diff --git a/arch/arm64/include/asm/futex_robust.h b/arch/arm64/include/asm/futex_robust.h
new file mode 100644
index 000000000000..26b4006c4aeb
--- /dev/null
+++ b/arch/arm64/include/asm/futex_robust.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_FUTEX_ROBUST_H
+#define _ASM_ARM64_FUTEX_ROBUST_H
+
+#include <asm/ptrace.h>
+
+static __always_inline void __user *arm64_futex_robust_unlock_get_pop(struct pt_regs *regs)
+{
+	/*
+	 * If Z bit is set then the ll/sc cmpxchg succeeded and the pending op
+	 * pointer needs to be cleared.
+	 */
+	return (regs->user_regs.pstate & PSR_Z_BIT) ?
+		(void __user *) regs->user_regs.regs[2] : NULL;
+}
+
+#define arch_futex_robust_unlock_get_pop(regs)	\
+	arm64_futex_robust_unlock_get_pop(regs)
+
+#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b7..3c7f220fe783 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -9,7 +9,8 @@
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile.include
 
-obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
+obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o \
+	    vfutex.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
@@ -45,9 +46,11 @@ CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
 CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
+CFLAGS_REMOVE_vfutex.o = $(CC_FLAGS_REMOVE_VDSO)
 
 CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
 CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
+CFLAGS_vfutex.o = $(CC_FLAGS_ADD_VDSO)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
@@ -57,6 +60,10 @@ ifneq ($(c-getrandom-y),)
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
index 000000000000..3561b869d8bb
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vfutex.c
@@ -0,0 +1,34 @@
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
+	__u32 val, result;
+
+	asm volatile (
+		GLOBLS(64)
+		"	prfm pstl1strm, %[lock]			\n"
+		"retry:						\n"
+		"	ldxr %w[val], %[lock]			\n"
+		"	cmp %w[tid], %w[val]			\n"
+		"	bne " LABEL(end, 64)"			\n"
+		"	stlxr %w[result], wzr, %[lock]		\n"
+		"	cbnz %w[result], retry			\n"
+		LABEL(start, 64)":				\n"
+		LABEL(success, 64)":				\n"
+		"	str xzr, %[pop_reg]			\n"
+		LABEL(end, 64)":				\n"
+
+		: [val] "=&r" (val), [result] "=&r" (result)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg)
+		: "memory"
+	);
+
+	return val;
+}
diff --git a/include/vdso/futex.h b/include/vdso/futex.h
index 3cd175eefe64..80934561a10d 100644
--- a/include/vdso/futex.h
+++ b/include/vdso/futex.h
@@ -4,6 +4,7 @@
 
 #include <uapi/linux/types.h>
 
+
 /**
  * __vdso_futex_robust_list64_try_unlock - Try to unlock an uncontended robust futex
  *					   with a 64-bit pending op pointer

-- 
2.54.0

