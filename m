Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931838;
	b=FAXCc1WUfqYrQHj7I9Vf9pdVsHMlHASL4rC6WHh7TKsfORpNtvDCe2O7SlVY9BTaueRt
	 2qTLoUlFkZZ2Ueb366HQ7enenAVUybnBMcz6s7iWCQl7RCcKOK7Mk11CL8FDlOEEtIWS5
	 tl/FIv62Coi6oCTRJSPRvEjh+8x3Wz9m+2aujD/kkZHf/IEgetYtO/KQZqkB96gImUCWQ
	 UobtnEUO6Mtyw9XsL51S1/lpofGMp/oBio2gC1jgz8sThbVaa30+rY+JW4SbFtOUrB/3L
	 jN3Z2eWJ8AmHf9G85OMKpzPKuLU2Bqn0cQKQSB5KY+VzOZbGns+a13bwdjis5eXNCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931838;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=NyTFiFpsDwOKjO2VPbpWmP0Im41/URytW32rn7Mp+g0=;
	b=Auqc3P4xQS4Q6ujwOH22fPHeH5s6AJR+L3gf7F77+T01ObcvqaTDWiId1VeJ+ZWfeKzl
	 c6ydJBnFOpKjbjfmiY3vRj+cZ66cObtTUKZYs9317UFxI4W/K6bQ9OEA8FUzfIaP6rYPD
	 4LSyQgp/xOZVQoKTqsLe/n0RnofLv7ilQYDQempclnlyRic15tVQ+zQQoiktxXZ9AgLll
	 AiQhgVWN52BUi9KLJ2kk/PEGbc59zL0lIVgNwHnZSo+m5eASR3EgZx5SkEq13g6w9B84u
	 ofCDe/l9SbGLliaz1/vas1RoMEABi863i7peR4Tv0pKMIR7k45Tz9CLe0EKUIcVSnZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=P8RKc9IT;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C87606A32E;
	Fri,  6 Nov 2026 02:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C87606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=P8RKc9IT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=NyTFiFpsDwOKjO2VPbpWmP0Im41/URytW32rn7Mp+g0=; t=1793931837; x=2109291837; 
	b=P8RKc9ITGSuWjKlP2nMkKLXMx5guzUnYbwkWSNbJHPH18K8oXSX30pVGY7iDxjJmzDfU5cmlloi
	v9lSPJZK8ZnpHQm1qD+9R1Um+hFYQBXghF5HTh14mvPk3TV+qjEFiJykkV3ghFSTpH7srV6ghA1z5
	mF1/jwMp8EtOWJewanh7P/9tEA6HmLUSo50CB4QCaNXvTt5oTPyD5+YrteAQXSct81w0EbOC1BHCl
	UHR2d8O7KyJnsg8yE1q8EpHRTkDFRYnz6WjgZgswqr8TcNtVCy0+xCO0ZuW/+9Y6QIz38l+jxUleO
	w6g2+KES7D6KARU3s+adjMOHwaP2JDLKDMaw==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP9cJ-003xm9-SX; Fri, 06 Nov 2026 03:23:48 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 23:23:43 -0300
Subject: [PATCH v10 2/3] arm64: vdso: Prepare for robust futex unlock
 support
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-tonyk-robust_arm-v10-2-366ed4a3435b@igalia.com>
References: <20261105-tonyk-robust_arm-v10-0-366ed4a3435b@igalia.com>
In-Reply-To: <20261105-tonyk-robust_arm-v10-0-366ed4a3435b@igalia.com>
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
index 7cafa8208ef1..644def28f280 100644
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
@@ -56,6 +57,22 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
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
2.56.0

