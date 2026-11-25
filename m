Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587392;
	b=oe1+Qk6MGdwFTx5TD93o8ZKEHfPWTqA2MVsETWKTgK/j8a3ggZv/59hPU8zDf220gNPT
	 KL67yXKYXBQCBvBixrNVoQ0WNEFkTuUFFdS+OaxGj5UdvGnTOomCBcqcwHXV1W2eLZKXG
	 2ZaJU+YGrOI3Ycnby2dJBxcTItLc9Esge8giLwIMomRtD4hcvNosR0nS2s6FVnboqytxi
	 KL34D6SxEp0UJM1WvVvdycT1lsUQQ5PDCwlR5JFVNcEaqJjEDJJkqIV6t1vpskTXQUzTw
	 v8nbkdb5VFZq5O58t/2+kg7fCVtLUnZJ3cWz1zrSpoyfXKZWSJuXloCWQHWorX5zMFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ziD/5SVNpVvJrFTksFhEkRTwEv+vEsuDld5BMClPtX4=;
	b=KVDc+Fp2eZVok9v0BIabvpGkSRSQfojiNlq8khxdGxMTZ6R6of2BoLmcyExyr6h0HFAS
	 USaCZCkcbKXT3f+grwvGqxmOtIwi+6lgTO4ht0sIz7VkDpodsqJOPWkuSNhfnNx6tKNU7
	 uiMI6EIWdXKpcoHACx8dzsJB0WRQYVWEQjg9efEUXEpozajuZ5LLrW6h/ofYJmaShIaMv
	 E34ItcddLt+QjrGub4/d8xu97hGdpyXBhL9Eqj5cNP+vaW4rG2qrvdXnEtRUcm2OzNcoC
	 F3Mh/d5EszdHa3A349d11wpozUDTLAtpfNVdfRhIPuPSrdAiYfzGnOt1K4rEZWzGFIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bPzgH20l;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C52606A990
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C52606A990
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bPzgH20l
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3846d5f54c1so6513704eec.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587391; x=1796192191; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziD/5SVNpVvJrFTksFhEkRTwEv+vEsuDld5BMClPtX4=;
        b=bPzgH20lIs6i7BC22QHQ+O9Q0bT31Xauu6UrJ+nt6GCs9AVKCvLs0lWWLr3NubX3Au
         QDqWzDD1zwEtb4/EnteDezQrSaJhpEp2XMjmSb7BS5uHwD14Al7zfYmi1JwDJ7Y++8bj
         GAzrzGLCccvT1bbZrqeRj5ubwYeHDLGt3nG9+Di07/QdpEN8WpXC3X8mhHocns5AVw0S
         GewcktUHgPxcqJmZmD8rNxqn9jsXdklqXIVEr1JIQdPzOet1CtkHWoCO/ASDNmACJAoh
         aT3mLPeZb/wB12C+i6qWfsoPe+cGxYamoZ6u8hQRGs0X7/cxPyOnK65GvGPMrVcGe/67
         PWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587391; x=1796192191;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziD/5SVNpVvJrFTksFhEkRTwEv+vEsuDld5BMClPtX4=;
        b=Ejhn5ygvl7VYxOQOeBCbs6JpWc53Dz7/rcHng7UmWPXGFzIIioQu5qKbcq7vgiwQLM
         OJOvc5jJrHyAVUsMWGagd2/HuD14lQEAmFcsJuG0kPZuZSbjjRc6faUtiq+afHN1xx5H
         sfHYNlEX7lLCFmqUZZESFXJCC3oA9GB850QyjkzFDRqzURYFjG160QBH7R5BBx0cCCit
         m7vDeBM6ePIl/vc4sBbAjb0lNQ/72InGP9ol40Ol5XEuFAvPKdozoJB7sl4esIYeHzvs
         I/k4cKVu1KNPUITxag5/rL7c3/+qZEaB5i5lD7bQxD97CctjR0ucHKfS3/LPRDWuncBt
         RylA==
X-Forwarded-Encrypted: i=1; AL+hErHmy5BBG41urn9jOcHV8xS5LFehWbHns8GN2TpR0sbVvb+KV5t1DcSsxdrwTcGql4yYYMwV0tyzlnCB@vger.kernel.org
X-Gm-Message-State: APuU4Z9xgqVq2wZtpiQ28E2kBgtADVjLj9PxyHZpnKFEO85c/7gkMlxh
	BfcuG5o9kUtX7v9ZQ8PlzD4TYxZtWZCC4HDOncwbJtE+hN9jVR3VB7pPqIH2Z2KOuar2MrHYguI
	51NDNJ5R/tA==
X-Received: from dyba2.prod.google.com ([2002:a05:693c:63c2:b0:386:9a0b:1f64])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:60d7:b0:386:a01f:a31e
 with SMTP id 5a478bee46e88-386a01fa8a5mr13485947eec.29.1795587391007; Tue, 24
 Nov 2026 22:16:31 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:10 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-18-irogers@google.com>
Subject: [RFC PATCH v2 17/30] riscv: unwind_user: Support Minimal DWARF CFI
 and FP user unwinding
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Wire up CONFIG_HAVE_UNWIND_USER_CFI and CONFIG_HAVE_UNWIND_USER_FP on
MMU-enabled RISC-V kernels by adding arch/riscv/include/asm/unwind_user.h
and unwind_user_sigreturn():

 - Define DWARF CFI register mappings for RV64 and RV32/compat user
   tasks (sp=2, fp/s0=8, ra=1).
 - Provide unwind_user_link_register() reading regs->ra for leaf-frame
   unwinding and ARCH_INIT_USER_FP_FRAME matching the RISC-V psABI
   frame layout (CFA = s0, RA at s0 - ws, saved s0 at s0 - 2*ws).
 - Implement unwind_user_sigreturn() (and compat_unwind_user_sigreturn())
   to recover pc, ra, sp, and s0 from rt_sigframe.uc.uc_mcontext.sc_regs
   across __vdso_rt_sigreturn (whose vDSO FDE omits register rules so
   libgcc takes its instruction-matching sigcontext fallback), supporting
   interrupted leaf functions, -fomit-frame-pointer frames, and
   SA_ONSTACK alternate signal stacks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/riscv/Kconfig                   |  2 +
 arch/riscv/include/asm/signal32.h    |  9 +++
 arch/riscv/include/asm/unwind_user.h | 82 ++++++++++++++++++++++++++++
 arch/riscv/kernel/compat_signal.c    | 45 +++++++++++++++
 arch/riscv/kernel/signal.c           | 57 +++++++++++++++++++
 5 files changed, 195 insertions(+)
 create mode 100644 arch/riscv/include/asm/unwind_user.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e7891a2a89da..84b61c755db3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -202,6 +202,8 @@ config RISCV
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_CFI if MMU
+	select HAVE_UNWIND_USER_FP if MMU
 	select HOTPLUG_PARALLEL if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/riscv/include/asm/signal32.h b/arch/riscv/include/asm/signal32.h
index 96dc56932e76..c1cbcb681aa7 100644
--- a/arch/riscv/include/asm/signal32.h
+++ b/arch/riscv/include/asm/signal32.h
@@ -3,9 +3,12 @@
 #ifndef __ASM_SIGNAL32_H
 #define __ASM_SIGNAL32_H
 
+struct unwind_user_state;
+
 #if IS_ENABLED(CONFIG_COMPAT)
 int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs);
+bool compat_unwind_user_sigreturn(struct unwind_user_state *state);
 #else
 static inline
 int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
@@ -13,6 +16,12 @@ int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 {
 	return -1;
 }
+
+static inline
+bool compat_unwind_user_sigreturn(struct unwind_user_state *state)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/arch/riscv/include/asm/unwind_user.h b/arch/riscv/include/asm/unwind_user.h
new file mode 100644
index 000000000000..d3c12a183ac9
--- /dev/null
+++ b/arch/riscv/include/asm/unwind_user.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_UNWIND_USER_H
+#define _ASM_RISCV_UNWIND_USER_H
+
+#ifdef CONFIG_UNWIND_USER
+
+#include <linux/compat.h>
+#include <linux/unwind_dwarf_cfi.h>
+#include <linux/unwind_user_types.h>
+#include <asm/ptrace.h>
+
+/**
+ * unwind_user_word_size() - Return the user-space word size in bytes on RISC-V
+ * @regs: User-mode register state.
+ *
+ * Return: 4 for RV32 compat user tasks, or sizeof(unsigned long) otherwise.
+ */
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())
+		return 4;
+	return sizeof(unsigned long);
+}
+
+/**
+ * unwind_user_link_register() - Fetch the user link register (ra/x1) from @regs
+ * @regs: User-mode register state.
+ * @ra: Output link register value.
+ *
+ * Return: Always true on RISC-V.
+ */
+static inline bool unwind_user_link_register(struct pt_regs *regs,
+					     unsigned long *ra)
+{
+	*ra = regs->ra;
+	return true;
+}
+
+#define unwind_user_link_register unwind_user_link_register
+
+/**
+ * unwind_user_cfi_arch() - Populate RISC-V DWARF register numbers
+ * @ws: User word size in bytes (4 for RV32, 8 for RV64).
+ * @arch: Output DWARF CFI architecture descriptor.
+ *
+ * Return: true if @ws is 4 or 8, false otherwise.
+ */
+static inline bool unwind_user_cfi_arch(unsigned int ws,
+					struct dwarf_cfi_arch *arch)
+{
+	if (ws == 8 || ws == 4) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= (u8)ws,
+			.sp_reg	= 2,	/* sp (x2) */
+			.fp_reg	= 8,	/* s0/fp (x8) */
+			.ra_reg	= 1,	/* ra (x1) */
+		};
+		return true;
+	}
+	return false;
+}
+
+bool unwind_user_sigreturn(struct unwind_user_state *state);
+#define unwind_user_sigreturn unwind_user_sigreturn
+
+#endif /* CONFIG_UNWIND_USER */
+
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
+/*
+ * Standard RISC-V psABI frame record stores {saved_s0, saved_ra} at
+ * [s0 - 2 * ws, s0), with s0 pointing to the caller's stack pointer (CFA).
+ */
+#define ARCH_INIT_USER_FP_FRAME(ws)			\
+	.cfa_off	=  0,				\
+	.ra_off		= -1 * (ws),			\
+	.fp_off		= -2 * (ws),			\
+	.use_fp		= true,
+
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
+
+#endif /* _ASM_RISCV_UNWIND_USER_H */
diff --git a/arch/riscv/kernel/compat_signal.c b/arch/riscv/kernel/compat_signal.c
index cf3eb33a11e4..53b5be62e393 100644
--- a/arch/riscv/kernel/compat_signal.c
+++ b/arch/riscv/kernel/compat_signal.c
@@ -5,6 +5,7 @@
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
 #include <linux/linkage.h>
+#include <linux/unwind_user.h>
 
 #include <asm/csr.h>
 #include <asm/signal32.h>
@@ -243,3 +244,47 @@ int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 
 	return 0;
 }
+
+#ifdef CONFIG_UNWIND_USER
+/**
+ * compat_unwind_user_sigreturn() - Unwind an RV32 compat vDSO rt_sigreturn frame
+ * @state: Current user unwind state.
+ *
+ * Return: true if @state was at the compat vDSO __vdso_rt_sigreturn trampoline
+ * and advanced to the interrupted 32-bit user context, false otherwise.
+ */
+bool compat_unwind_user_sigreturn(struct unwind_user_state *state)
+{
+	struct mm_struct *mm = current->mm;
+	struct compat_rt_sigframe __user *frame;
+	struct compat_user_regs_struct cregs;
+	unsigned long sigret;
+
+	if (!mm || !mm->context.vdso || (state->sp & 3UL))
+		return false;
+
+	sigret = (unsigned long)COMPAT_VDSO_SYMBOL(mm->context.vdso,
+						   rt_sigreturn);
+	if (state->ip != sigret &&
+	    !(state->topmost && state->ip == sigret + 4))
+		return false;
+
+	frame = (struct compat_rt_sigframe __user *)state->sp;
+	if (copy_from_user(&cregs, &frame->uc.uc_mcontext.sc_regs,
+			   offsetofend(struct compat_user_regs_struct, s0)))
+		return false;
+
+	if ((cregs.sp & 3U) || !cregs.pc)
+		return false;
+
+	state->ip = cregs.pc;
+	state->ra = cregs.ra;
+	state->sp = cregs.sp;
+	state->fp = cregs.s0;
+	state->ra_valid = true;
+	state->sp_valid = true;
+	state->signal = true;
+	state->topmost = false;
+	return true;
+}
+#endif
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 59784dc117e4..c0d70220e4a4 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -13,6 +13,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/linkage.h>
 #include <linux/entry-common.h>
+#include <linux/unwind_user.h>
 
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
@@ -587,3 +588,59 @@ bool sigaltstack_size_valid(size_t ss_size)
 	return ss_size > get_rt_frame_size(false);
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
+
+#ifdef CONFIG_UNWIND_USER
+/**
+ * unwind_user_sigreturn() - Unwind a RISC-V rt_sigreturn user signal frame
+ * @state: Current user unwind state.
+ *
+ * __vdso_rt_sigreturn carries an empty .cfi_signal_frame FDE without register
+ * rules so user-space unwinders such as libgcc take their instruction-matching
+ * sigcontext fallback. Recover pc, ra, sp, and s0 directly from
+ * &rt_sigframe.uc.uc_mcontext.sc_regs so interrupted leaf functions,
+ * -fomit-frame-pointer code, and alternate signal stacks unwind cleanly.
+ *
+ * Return: true if @state was at the rt_sigreturn trampoline and advanced to
+ * the interrupted user context, false otherwise.
+ */
+bool unwind_user_sigreturn(struct unwind_user_state *state)
+{
+	struct mm_struct *mm = current->mm;
+	struct rt_sigframe __user *frame;
+	struct user_regs_struct sc_regs;
+	unsigned long sigret;
+
+	if (!mm)
+		return false;
+
+	if (IS_ENABLED(CONFIG_COMPAT) && state->ws == 4)
+		return compat_unwind_user_sigreturn(state);
+
+	if (state->ws != sizeof(unsigned long) || !mm->context.vdso ||
+	    (state->sp & (sizeof(unsigned long) - 1)))
+		return false;
+
+	frame = (struct rt_sigframe __user *)state->sp;
+	sigret = (unsigned long)VDSO_SYMBOL(mm->context.vdso, rt_sigreturn);
+	if (state->ip != sigret &&
+	    !(state->topmost && state->ip == sigret + 4))
+		return false;
+
+	if (copy_from_user(&sc_regs, &frame->uc.uc_mcontext.sc_regs,
+			   offsetofend(struct user_regs_struct, s0)))
+		return false;
+
+	if ((sc_regs.sp & (sizeof(unsigned long) - 1)) || !sc_regs.pc)
+		return false;
+
+	state->ip = sc_regs.pc;
+	state->ra = sc_regs.ra;
+	state->sp = sc_regs.sp;
+	state->fp = sc_regs.s0;
+	state->ra_valid = true;
+	state->sp_valid = true;
+	state->signal = true;
+	state->topmost = false;
+	return true;
+}
+#endif
-- 
2.56.1.831.g720f3f5937-goog

