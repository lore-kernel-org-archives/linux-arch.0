Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DF400992;
	Mon, 20 Jul 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563427; cv=none; b=F8O6t/XjydfoWben9ZJCa7HH0SYq1mPupENff1e+56mcaYAWecXhc/lHSl2PUqliZN9wmRTv9Z+n3n1f9jP7o37XQLzzo/w9RAC1oLeTw5JiYZaGudo5uWiDVHP8EvMXqKI41GP8GRs7LhlCw8Hogu6hM9yvZsnYvRkMzMqgg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563427; c=relaxed/simple;
	bh=YXc+BuTOCUgn/WPNd79SJHD19hxxTPzv7l666tz8ggI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptvXzCSuwx7L0jrPIPFLeZrgxWN8Nokz8OIQM702BsZBqdsOmfnGq07CBVjXjTjZ3D3RNSNgR3wBdRwCmOgbxq+CBHYHAKw8c4ZdoQvovUfhQeov4Q9jN0yS4XxpMSTRRYc7ozA/KUAlvUcc0t3oE1ih9CQTskfQYWzWhLyLAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OArncno8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OArncno8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=8d5Xgeqbr1f1MGwFnkVvgzEnRmvJhiFMLb+8BeBD8T0=; b=OArncno8gpWNXxFCZJIOV+Nfrj
	Wy++aR53dVPM8bQWA+/LnEVVkqHvrRAiSyC060f2QlWQG3nPR/avLpWjBy5BdV4rLOCf/q2YD3NYU
	vFAMXlQBNBOnbqkPURLUF4bQS4v/2DgiKqSxxHsPqPhLrfjYAD5nLG7yEyMVvbhFEYiTDiZZeT8/p
	h1JnaIG6DStHi2RfA8pGLcY1v652++Dg1ZeoQ7SVD8M0gDyjbWkb1/39WTR1NmaisITMedqu1ePFo
	VRxwTf4L+oaf3c4xGbRrQqRbrqJrZxI5RosfGn7ZVDBIvYyC4/ijAKTl6CkE+Tg33R4ChhfVDPPWC
	o6FABIfQ==;
Received: from [179.118.191.219] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wlqSw-001CZ2-DN; Mon, 20 Jul 2026 18:03:38 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 20 Jul 2026 13:03:04 -0300
Subject: [PATCH v6 4/4] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-tonyk-robust_arm-v6-4-7e68c122047e@igalia.com>
References: <20260720-tonyk-robust_arm-v6-0-7e68c122047e@igalia.com>
In-Reply-To: <20260720-tonyk-robust_arm-v6-0-7e68c122047e@igalia.com>
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

Based on aarch64 implementation, provide a 32 bit entry point for
this vDSO.

In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
make sure to store the pop address at r2 and the compare result value
at r3.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/kernel/vdso.c            | 14 ++++++++++++++
 arch/arm64/kernel/vdso32/Makefile   |  4 ++++
 arch/arm64/kernel/vdso32/vdso.lds.S |  9 +++++++++
 arch/arm64/kernel/vdso32/vfutex.c   | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 1d1633e8339b..d9b86f9a0db6 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -182,6 +182,15 @@ enum aarch32_map {
 static struct page *aarch32_vectors_page __ro_after_init;
 static struct page *aarch32_sig_page __ro_after_init;
 
+static inline void aarch32_vdso_futex_update_ips(struct mm_struct *mm)
+{
+	unsigned long vdso = (unsigned long) mm->context.vdso;
+
+	__vdso_futex_update_ips(mm, true,
+				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_start),
+				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end));
+}
+
 static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
 				  struct vm_area_struct *new_vma)
 {
@@ -195,6 +204,8 @@ static int aarch32_mremap(const struct vm_special_mapping *sm,
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
+	aarch32_vdso_futex_update_ips(current->mm);
+
 	return 0;
 }
 
@@ -327,6 +338,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
@@ -347,6 +359,8 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	ret = aarch32_sigreturn_setup(mm);
+
+	aarch32_vdso_futex_update_ips(mm);
 out:
 	mmap_write_unlock(mm);
 	return ret;
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 4bd60f059f4a..f3190125c68b 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -97,6 +97,10 @@ munge := ../../../arm/vdso/vdsomunge
 hostprogs := $(munge)
 
 c-obj-vdso := note.o
+ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+  c-obj-vdso += vfutex.o
+endif
+
 c-obj-vdso-gettimeofday := vgettimeofday.o
 
 ifneq ($(c-gettimeofday-y),)
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index c374fb0146f3..46c0123b2684 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -87,6 +87,15 @@ VERSION
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
 		__vdso_clock_getres_time64;
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+		__vdso_futex_robust_list32_try_unlock;
+#endif
 	local: *;
 	};
 }
+
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+VDSO_futex_list32_try_unlock_cs_success = __futex_list32_try_unlock_cs_success;
+VDSO_futex_list32_try_unlock_cs_start = __futex_list32_try_unlock_cs_start;
+VDSO_futex_list32_try_unlock_cs_end = __futex_list32_try_unlock_cs_end;
+#endif
diff --git a/arch/arm64/kernel/vdso32/vfutex.c b/arch/arm64/kernel/vdso32/vfutex.c
new file mode 100644
index 000000000000..030eb767b8d6
--- /dev/null
+++ b/arch/arm64/kernel/vdso32/vfutex.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/stringify.h>
+#include <vdso/futex.h>
+
+__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
+{
+	register __u32 *pop_reg asm("r2") = pop, result_reg asm("r3") = 0;
+	__u32 val, zero = 0;
+
+	asm volatile (
+		".globl						  "
+		"__futex_list32_try_unlock_cs_start,		  "
+		"__futex_list32_try_unlock_cs_success,		  "
+		"__futex_list32_try_unlock_cs_end		\n"
+
+		"retry:						\n"
+		"	ldrex %[val], %[lock]			\n"
+		"	cmp %[tid], %[val]			\n"
+		"	bne __futex_list32_try_unlock_cs_end	\n"
+		"	strex %[result], %[zero], %[lock]	\n"
+		"__futex_list32_try_unlock_cs_start:		\n"
+		"	cmp %[result], #0			\n"
+		"	bne retry				\n"
+		"__futex_list32_try_unlock_cs_success:		\n"
+		"	str %[zero], %[pop_reg]			\n"
+		"__futex_list32_try_unlock_cs_end:		\n"
+
+		: [val] "=&r" (val), [result] "=r" (result_reg)
+		: [tid] "r" (tid), [lock] "Q" (*lock), [pop_reg] "Q" (*pop_reg), [zero] "r" (zero)
+		: "cc", "memory"
+	);
+
+	return val;
+}

-- 
2.55.0

