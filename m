Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0E34D4E9;
	Fri, 21 Aug 2026 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349092; cv=none; b=j70k58r78z86+9fHryCiuhpbyMXUZ210CvhD0tK9V/7+9IWuSfvleOA8PiDCkDhyGctJWfNU1s8b/pYoTMENSyxPPCy0WWSkUmFhr5YZgHHvE/8JhKhFT8vSKabHMlvoVX+zQnSCpieFqg8nKgsuVkmhJ8d4HvlhwuSbqXd1f+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349092; c=relaxed/simple;
	bh=+T7csHINHcHFGCq5A5xDC1oiI6yT4G1aDR9CDDjMxwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9hPhNtTlLp8t8MDWJHwVRKzdpaN9lQKSFofe6E8GkNF+zeOrh7IDXkUU1XfbLEMjVVpRn1JbesxlfBLmmhYBnq7YMvH+k9kUAplzYVkH2V8hYJ6xYuSHXJA8CWRjJSFsURs89NR5CieWgr6tEq7IfKzPp75KIhM8no4GANkxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SyNyY6Tr; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SyNyY6Tr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=ptmo/42mb6OleOo3WAUeI3RlL5iqmYR87B2SI/srVQA=; b=SyNyY6TrNbjpqoBnarW2weQip9
	9pScg9uIs9k8PbRUuNemliDYClkPqev7BEMciKBdyB9FC6T+YS6hBJFYy7b/9yocyAx/aiNqbZNjz
	tCfaOr/P6UbhY/j43Eg6tr+ccLuJDQhMKYiWchBeceAbMH85fDdDLLerhltFGYsQzSFyD4bX9JgWb
	Yau0WySzYJD6xrcw3yb80R6CBT7+GvQJ8V9LOC+pAAtY38uLlfEsbLwxKdhAivGhRV91kjh4k1Ke1
	bVkFv6Y31NzwfBxQspZAomsMMJpbAB13rvY3l5lI06JdLH19Navt5lMerNo9ExbU4+JlAPMO9W+EW
	UZm5o6yA==;
Received: from [177.139.22.20] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wxX8Z-007ErF-Na; Fri, 21 Aug 2026 23:50:55 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 21 Aug 2026 18:50:42 -0300
Subject: [PATCH v8 1/4] arm64: vdso: Prepare for robust futex unlock
 support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-tonyk-robust_arm-v8-1-077707b6f1c7@igalia.com>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
In-Reply-To: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
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
 arch/arm64/include/asm/futex_robust.h | 19 +++++++++++++++++++
 arch/arm64/kernel/vdso.c              | 27 ++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/futex_robust.h b/arch/arm64/include/asm/futex_robust.h
new file mode 100644
index 000000000000..4ff783bb2dc3
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
+	 * w3 stores the result of the stlxr instruction. If it's zero, the then
+	 * the ll/sc cmpxchg succeeded and the pending op pointer needs to be cleared.
+	 */
+	return (regs->user_regs.regs[3]) ? NULL : (void __user *) regs->user_regs.regs[2];
+}
+
+#define arch_futex_robust_unlock_get_pop(regs) \
+	arm64_futex_robust_unlock_get_pop(regs)
+
+#endif /* _ASM_ARM64_FUTEX_ROBUST_H */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 592dd8668de4..3ef331b5b240 100644
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
+	unsigned long start = (unsigned long) startp;
+	unsigned long end = (unsigned long) endp;
+	struct futex_mm_data *fd = &mm->futex;
+
+	futex_set_vdso_cs_range(fd, is_32bit ? 1 : 0, start, end, is_32bit);
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
@@ -162,6 +179,14 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int aarch32_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
 static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VECTORS] = {
 		.name	= "[vectors]", /* ABI */
@@ -174,7 +199,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
+		.mremap = aarch32_mremap,
 	},
 };
 

-- 
2.55.0

