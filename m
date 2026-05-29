Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A63C1F51;
	Fri, 29 May 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072471; cv=none; b=QWby/XSwHHKNemLQ20Xnri1lGRh01pzsObEamRuDjxf7bOpwdyBL9Bz1Fv8rSk827ucil4osSHcRBjX6NfNwrJu5MUBo5AkoFewdLT8/8KIQoEyMCAJM4N7mcX6qItCMPIQh5ZX6l4pkK0upwi9OYdBg34M71yPKy060e9sJE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072471; c=relaxed/simple;
	bh=vt6PYzZrS6xNvfuqRGNOeWxBY6igBNfRwzbaTmk73Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/Y1V/9B3WAPf8MjIv5qGqxg+asxotk3DQeHvZYDd6kARjfPV/z9wlPIzwq7SV4JJ40BLzgYWz9pkK+6/X9gZGbEdSvXv2IUuTr9GbIBS9ZGDSf6S5cdRcut5Zm80q+skdbTq/6nsJ6UEUlfkgDRjbPUkOjj6z4RSMGHhr61+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e7KKtsEm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e7KKtsEm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8mr+2IKRPq6GxrBU0bB4d+jYOkLg4Nyvmg+o4j1Gky0=; b=e7KKtsEmK5GEgkevjN1/FWqXce
	yGj4xbuBWq9+dqI1XIuKLDgeZiF1i2vmSoLhaf/YU+NmCaN2XDd4lG4zRFnCD7DlSVFi+ynq5T864
	XIU2L088v4xTgHMNiTLMY0gDVIrpHBc3Oog+6pj5GstHSrf+gLmFhUQ7lS3DihtPPqMbGC0jhP2so
	MTYSFntXkTb5VoymwK+bSyCgD8BH34Z0TMPpvj9c++FO4gvjJS5ET3HJ8LRKOGRErpv9cLs2CKMX5
	olZx424AZsob9pw4LPi9/TdL4iZTvqhNsED7mecU/LcA/WvBGwNVMrZDzU/1QqKQTYm0aMzpTH3Ly
	TL2ld/6g==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wT0AB-009wov-4i; Fri, 29 May 2026 18:34:23 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 29 May 2026 13:33:53 -0300
Subject: [PATCH v3 1/5] arm64: vdso: Prepare for robust futex unlock
 support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-tonyk-robust_arm-v3-1-a6f02684d4fe@igalia.com>
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

There will be a VDSO function to unlock non-contended robust futexes in
user space. The unlock sequence is racy vs. clearing the list_pending_op
pointer in the task's robust list head. To plug this race the kernel needs
to know the critical section window so it can clear the pointer when the
task is interrupted within that race window. The window is determined by
labels in the inline assembly.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Notes:
 - The diff futex_set_vdso_cs_range() should happen in the commit that
 introduced it, and rebase will clear it from here
 - So far I couldn't figure out why current->rseq.event.user_irq is never set in
 aarch64

v3:
 - Fix adding vdso base addr twice
 - Call vdso_futex_robust_unlock_update_ips() on remap as well
v2:
 - Fixed linker not finding VDSO symbols
---
 arch/arm64/kernel/vdso.c          | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/vdso/vdso.lds.S |  5 +++++
 arch/x86/entry/vdso/vma.c         |  4 ++--
 include/linux/futex.h             | 13 ++-----------
 4 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 592dd8668de4..76f22ea8e181 100644
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
@@ -57,11 +58,31 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 #endif /* CONFIG_COMPAT_VDSO */
 };
 
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+static void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm)
+{
+	unsigned long vdso = (unsigned long) mm->context.vdso;
+	struct futex_mm_data *fd = &mm->futex;
+	uintptr_t success, end;
+
+	if (abi == VDSO_ABI_AA64) {
+		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_success);
+		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end);
+
+		futex_set_vdso_cs_range(fd, 0, success, end, false);
+	}
+}
+#else
+static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
+#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
+
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
+	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA64, current->mm);
+
 	return 0;
 }
 
@@ -134,6 +155,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	if (IS_ERR(ret))
 		goto up_fail;
 
+	vdso_futex_robust_unlock_update_ips(abi, mm);
+
 	return 0;
 
 up_fail:
@@ -159,6 +182,8 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
 {
 	current->mm->context.sigpage = (void *)new_vma->vm_start;
 
+	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA32, current->mm);
+
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 52314be29191..8633aafe6b81 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -104,6 +104,7 @@ VERSION
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
 		__kernel_getrandom;
+		__vdso_futex_robust_list64_try_unlock;
 	local: *;
 	};
 }
@@ -112,3 +113,7 @@ VERSION
  * Make the sigreturn code visible to the kernel.
  */
 VDSO_sigtramp		= __kernel_rt_sigreturn;
+
+VDSO_futex_list64_try_unlock_cs_start = __futex_list64_try_unlock_cs_start;
+VDSO_futex_list64_try_unlock_cs_success = __futex_list64_try_unlock_cs_success;
+VDSO_futex_list64_try_unlock_cs_end = __futex_list64_try_unlock_cs_end;
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 357e18db0c7a..988568a62a8b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -85,13 +85,13 @@ static void vdso_futex_robust_unlock_update_ips(void)
 	futex_reset_cs_ranges(fd);
 
 #ifdef CONFIG_X86_64
-	futex_set_vdso_cs_range(fd, idx, vdso, image->sym___futex_list64_try_unlock_cs_start,
+	futex_set_vdso_cs_range(fd, idx, image->sym___futex_list64_try_unlock_cs_start + vdso,
 				image->sym___futex_list64_try_unlock_cs_end, false);
 	idx++;
 #endif /* CONFIG_X86_64 */
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_COMPAT)
-	futex_set_vdso_cs_range(fd, idx, vdso, image->sym___futex_list32_try_unlock_cs_start,
+	futex_set_vdso_cs_range(fd, idx, image->sym___futex_list32_try_unlock_cs_start + vdso,
 				image->sym___futex_list32_try_unlock_cs_end, true);
 #endif /* CONFIG_X86_32 || CONFIG_COMPAT */
 }
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 33524dfb3fe4..cb378872e4e7 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -122,14 +122,6 @@ static inline void futex_fixup_robust_unlock(struct pt_regs *regs)
 {
 	struct futex_unlock_cs_range *csr;
 
-	/*
-	 * Avoid dereferencing current->mm if not returning from interrupt.
-	 * current->rseq.event is going to be used subsequently, so bringing the
-	 * cache line in is not a big deal.
-	 */
-	if (!current->rseq.event.user_irq)
-		return;
-
 	csr = current->mm->futex.unlock.cs_ranges;
 
 	/* The loop is optimized out for !COMPAT */
@@ -142,10 +134,9 @@ static inline void futex_fixup_robust_unlock(struct pt_regs *regs)
 }
 
 static inline void futex_set_vdso_cs_range(struct futex_mm_data *fd, unsigned int idx,
-					   unsigned long vdso, unsigned long start,
-					   unsigned long end, bool sz32)
+					   unsigned long start, unsigned long end, bool sz32)
 {
-	fd->unlock.cs_ranges[idx].start_ip = vdso + start;
+	fd->unlock.cs_ranges[idx].start_ip = start;
 	fd->unlock.cs_ranges[idx].len = end - start;
 	fd->unlock.cs_ranges[idx].pop_size32 = sz32;
 }

-- 
2.54.0

