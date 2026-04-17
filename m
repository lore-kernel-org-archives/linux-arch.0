Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BC343D64;
	Fri, 17 Apr 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437851; cv=none; b=RCLtcD17g1q6IyvEZl4bxDxE8FYCGda3V1w96W4a+KR7Jud8fFY9Jjfi29RETgvw2ZSUCt7Z+gVv0E3jJlSCg6gzaGMGaMgetyAnYuTpnft+jsAafUiHpOjh7ArBE6cugaLbXtjWj75RXoYkeH3roENWci2nDAz5nvP9iqiVUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437851; c=relaxed/simple;
	bh=v87hpKQEGkW7KuK5FAr5Np6KBqMTib72w+/v4wnOaqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDStdBf98No8sX6df6mIgXGN78CIRB++2X81VaCh8xBwyVZEQZk6MfBURNPnaWbyuJ/NCmkC0N9T3MmaFADF7kzDWyzyt4y5ikm6c8n3Uf8OMSkmzf4miRRNMPGoA4N8QTGzkZUnQAXgcrpkcvPNdySglSdOukbJq4EjmonckEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BPyQ1CFr; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BPyQ1CFr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1NGdwlYbSqtyrzey1R4pNywcB64VCt682zZe8IioClA=; b=BPyQ1CFrIFaCQ6gx5O7A+2+t66
	kOWYt9BMVPD1JGB/owLsKm/+f1Snl/KNd2wcv/bLHt98rmUWK+6FTReZm1kNZE/ClrjLMVriQ/v9q
	6P98MS1F1FF6Mx1vdN+YM0C7SxB1gCFmvocsaO93qRbmGv0ys3RG4OOyNBp7QUMcajXY+p5jQnUiv
	QWF7lohayDR+7SvVCX3sXy28e0kWENOLCqx4t7IvYyTnLYARc/KapOmmS0GawqpLKpnhASIUepwoj
	udyRRejNOR7PQb/eMHneW38FX/yCZHx7KT5pmx1/sbmR1TjrHAsq7HLrXezGs3rpI0T/tcSY+oAv2
	YFwbS08w==;
Received: from [187.57.76.127] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wDkd4-00HVwL-1y; Fri, 17 Apr 2026 16:57:10 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 17 Apr 2026 11:56:11 -0300
Subject: [PATCH RFC 2/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260417-tonyk-robust_arm-v1-2-03aa64e2ff1a@igalia.com>
References: <20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com>
In-Reply-To: <20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com>
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
X-Mailer: b4 0.15.1

Based on the x86 implementation, implement the vDSO function for unlocking
a robust futex correctly.

Commit xxxxxxxxxxxx ("x86/vdso: Implement __vdso_futex_robust_try_unlock()") has
the full explanation about why this mechanism is needed.

The unlock assembly sequence for arm64 is:

	__futex_list64_try_unlock_cs_start:
		ldxr	x3, [x0] // Load the value at *futex
		cmp	x1, x3   // Compare with TID
		b.ne	__futex_list64_try_unlock_cs_end
		stlxr	w1, xzr, [x0] // Try to clear *futex
		cbnz	w1, __futex_list64_try_unlock_cs_start
	__futex_list64_try_unlock_cs_success:
		str	xzr, [x2] // After clearing *futex, clear *op_pending
	__futex_list64_try_unlock_cs_end:

The decision regarding if the pointer should be cleared or not lies on checking
the condition flag zero:

	return (regs->user_regs.pstate & PSR_Z_BIT) ?
		(void __user *) regs->user_regs.regs[2] : NULL;

If it's not zero, that means that the comparassion worked and the kernel should
clear op_pending (if userspace didn't managed to) stored at x2.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
RFC:
 - Should I duplicate the explanation found in the x86 commit or can I just
 point to it?
 - Only LL/SC for now but I can add LSE later if this looks good
 - It the objdump I see that op_pending is store at x2. But how stable is this,
 how can I write it in a way that's always x2?
---
 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/include/asm/futex_robust.h              | 35 +++++++++++++
 arch/arm64/kernel/vdso/Makefile                    |  9 +++-
 arch/arm64/kernel/vdso/vdso.lds.S                  |  4 ++
 .../kernel/vdso/vfutex_robust_list_try_unlock.c    | 59 ++++++++++++++++++++++
 5 files changed, 107 insertions(+), 1 deletion(-)

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
index 000000000000..f2b7a2b15cb5
--- /dev/null
+++ b/arch/arm64/include/asm/futex_robust.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_FUTEX_ROBUST_H
+#define _ASM_ARM64_FUTEX_ROBUST_H
+
+#include <asm/ptrace.h>
+
+static __always_inline void __user *arm64_futex_robust_unlock_get_pop(struct pt_regs *regs)
+{
+	/*
+	 * RFC: According to the objdump bellow, x2 is the address of
+	 * op_pending. How stable is this?
+
+	 <__futex_list64_try_unlock_cs_start>:
+		ldxr	x3, [x0]
+		cmp	x1, x3
+		b.ne	d7c <__futex_list64_try_unlock_cs_end>  // b.any
+		stlxr	w1, xzr, [x0]
+		cbnz	w1, d64 <__futex_list64_try_unlock_cs_start>
+
+	<__futex_list64_try_unlock_cs_success>:
+		str	xzr, [x2]
+
+	<__futex_list64_try_unlock_cs_end>:
+		mov	w0, w3
+		ret
+	*/
+
+	return (regs->user_regs.pstate & PSR_Z_BIT) ? NULL
+		: (void __user *) regs->user_regs.regs[2];
+}
+
+#define arch_futex_robust_unlock_get_pop(regs)	\
+	arm64_futex_robust_unlock_get_pop(regs)
+
+#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b7..a65893d8100e 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -9,7 +9,8 @@
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile.include
 
-obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
+obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o \
+	    vfutex_robust_list_try_unlock.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
@@ -45,9 +46,11 @@ CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
 CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
+CFLAGS_REMOVE_vfutex_robust_list_try_unlock.o = $(CC_FLAGS_REMOVE_VDSO)
 
 CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
 CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
+CFLAGS_vfutex_robust_list_try_unlock.o = $(CC_FLAGS_ADD_VDSO)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
@@ -57,6 +60,10 @@ ifneq ($(c-getrandom-y),)
   CFLAGS_vgetrandom.o += -include $(c-getrandom-y)
 endif
 
+ifneq ($(c-vfutex_robust_list_try_unlock-y),)
+  CFLAGS_vfutex_robust_list_try_unlock.o += -include $(c-vfutex_robust_list_try_unlock-y)
+endif
+
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 52314be29191..33ce58516580 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -104,6 +104,10 @@ VERSION
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
 		__kernel_getrandom;
+		__vdso_futex_robust_list64_try_unlock;
+#ifdef CONFIG_COMPAT
+		__vdso_futex_robust_list32_try_unlock;
+#endif
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
new file mode 100644
index 000000000000..a9089d3cacfc
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vfutex_robust_list_try_unlock.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <vdso/futex.h>
+#include <linux/stringify.h>
+
+#define LABEL(name, sz) __stringify(__futex_list##sz##_try_unlock_cs_##name)
+
+#define GLOBLS(sz) ".globl " LABEL(start, sz) ", " LABEL(success, sz) ", " LABEL(end, sz) "\n"
+
+__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
+{
+	__u32 val, result;
+
+	asm volatile (
+		GLOBLS(64)
+		"	prfm pstl1strm, %[lock]			\n"
+		LABEL(start, 64)":				\n"
+		"	ldxr %[val], %[lock]			\n"
+		"	cmp %[tid], %[val]			\n"
+		"	bne " LABEL(end, 64)"			\n"
+		"	stlxr %w[result], xzr, %[lock]		\n"
+		"	cbnz %w[result], " LABEL(start, 64)"	\n"
+		LABEL(success, 64)":				\n"
+		"	str xzr, %[pop]				\n"
+		LABEL(end, 64)":				\n"
+
+		: [val] "=&r" (val), [result] "=r" (result)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
+		: "memory"
+	);
+
+	return val;
+}
+
+#ifdef CONFIG_COMPAT
+__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
+{
+	__u32 val, result;
+
+	asm volatile (
+		GLOBLS(32)
+		"	prfm pstl1strm, %[lock]			\n"
+		LABEL(start, 32)":				\n"
+		"	ldxr %w[val], %[lock]			\n"
+		"	cmp %w[tid], %w[val]			\n"
+		"	bne " LABEL(end, 32)"			\n"
+		"	stlxr %w[result], wzr, %w[lock]		\n"
+		"	cbnz %w[result], " LABEL(start, 32)"	\n"
+		LABEL(success, 32)":				\n"
+		"	str wzr, %w[pop]			\n"
+		LABEL(end, 32)":				\n"
+
+		: [val] "=&r" (val), [result] "=r" (result)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop] "Q" (*pop)
+		: "memory"
+	);
+
+	return val;
+}
+#endif

-- 
2.53.0

