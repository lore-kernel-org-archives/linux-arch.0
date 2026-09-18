Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6F349CD1;
	Fri, 18 Sep 2026 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691262; cv=none; b=NgvxaE5d6N2e48sx7EfeWNHV8KjkPldSxtjjAFY/McIjLSQ2+A+OuxJu1cf427v50wb9r5VxApY8bVDNl52/s3ThJ49/T1jZEi/8fY8w/VmUTfUhKdcxC5pehkbd9SAQsr+HLLzCSxoCVhcfG9GFZXnilSDG+aJwtCW0W2oSc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691262; c=relaxed/simple;
	bh=ZGSipOxDaEzZPZIFkQqfILvqlIIOm+3j79tLnKuFVf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfJz549brT/XvvwfIIABD9+LsVPLn0nOhvx6Pot5vgLOJJHcEsH4rtePwWIDXnqyjZlv/WoB/6sjl5wxrOjnui9xZfdghlK64/VN4Uuai7kIYjA+kfjCU6yx3Oz6wha79MO5DEqrjKf0IRxignDlioByqKY3FWDDAsSm5UGY6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XodOcefM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XodOcefM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=naEoqeYe8X/Jw2DES4clEmxwgKBwecpzN9gXVazxB2c=; b=XodOcefMOcWjo30lLhyeafEgnY
	lkG5gqfSOJfXXJ5QQtAqadwAFQEt7Eo31AzUj3UDkGIT1CglyBfycgr/i9RqiVlfvJmBCgTjbIYLj
	teh6yAEbomupgAWSWsvtY/ZnfmG1cVhwI3H3T9t5JcznyqaEk4KbYzEdr09JF1xAp6jqDF4ynp6OC
	oe1+mArvhPj07ZyE66ZtRi+7Y1x5ZWTJAvqOM3Ps0idvsTU0TMHRhcvR0d1AP4bJiUrN9F5MoSYXJ
	HBeVkKWa6gaeZSxXhv8zaOZum5EUMHqbMmdpUersL4o7ICCCe8nYSmVFTVepaMLLam8Ov25R+H8Z3
	kiLeyigA==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7MRt-003iDv-JQ; Fri, 18 Sep 2026 02:27:29 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Sep 2026 21:27:01 -0300
Subject: [PATCH v9 3/3] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-tonyk-robust_arm-v9-3-ab082b1b4c4b@igalia.com>
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

The futex's robust list uAPI has a struct robust_list_head::list_op_pending
pointer used by userspace as a temporary variable while the mutex unlock is
happening. User sets it to the futex address that's about to be released
and removed from the robust list, and list_op_pending is cleared after.
After a thread dies, the kernel checks it's list_op_pending and wakes the
mutex in that address, to prevent starvation, and flip a bit in the mutex
word (FUTEX_OWNER_DIED).

However, there's a critical section where the user thread dies after the
mutex is released but before list_op_pending is cleared. If that happens,
another thread can wake up, use the lock, release it, and free its
memory. Now, if the robust list cleanup happens after this, the
killed thread's list_op_pending becomes a dandling pointer. The
kernel wrongly treats this address as a mutex, calls a futex_wake()
on it and flips a bit, causing a memory corruption.

To avoid using the dangling pointer, implement
__vdso_futex_robust_try_unlock() for arm64. Make the VDSO release the mutex
and clear the list_op_pending fields, just as is done in userspace right
now. But having it in a VDSO means that, in the case of a killed user
thread, the kernel can know exactly in which part of the release process
the thread was interrupt, check the registers for the operation success and
clears the list_op_pending on behalf of the user thread to prevent the
use-after-free bug.

The need for checking the instructions addresses and the register makes
this mechanism arch-dependent. Implement it using LL/SC semantics. If the
user instruction pointer is between the labels
__futex_list64_try_unlock_cs_start and __futex_list64_try_unlock_cs_end,
the critical section was interrupted. The kernel checks for the result
register (always w3) of the stlxr instruction used for atomically releasing
the mutex. If it's 0, the release happened and the kernel should clear the
list_op_pending field (always stored at x2).

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v9:
 - Refactor assembly code style
 - Make sure [pop_reg] is allocated to a register, defining it as a "r"
 input
 - Make [lock] a read-write param using +Q

v7:
 - Typo in message: success result for stlex is 0, not 1
 - pop_reg is read afterwards so define it as an output parameter "+Q"

v6:
 - Complete reword of commit message to make it clear
 - Better commit split, only the specific aarch64 things here
 - Use explicity labels instead of macros

v4:
 - Guard makefile for vfutex.o with ifdef
 - Moved _start label one instruction above
 - Use results register (w3) to check for store success instead of using zero
   flag

v3:
 - Managed to get pop to always be stored at x2
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/kernel/vdso.c          | 17 ++++++++++++++--
 arch/arm64/kernel/vdso/Makefile   | 10 ++++++++++
 arch/arm64/kernel/vdso/vdso.lds.S |  9 +++++++++
 arch/arm64/kernel/vdso/vfutex.c   | 41 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..5a3705b9d2e1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -222,6 +222,7 @@ config ARM64
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_FUTEX_ROBUST_UNLOCK
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_ARM64
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 95162061cd82..052667ba6cde 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -69,16 +69,27 @@ static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit,
 	futex_set_vdso_cs_range(fd, 0, start, end, is_32bit);
 }
 
+static inline void vdso_futex_update_ips(struct mm_struct *mm)
+{
+	unsigned long vdso = (unsigned long)mm->context.vdso;
+
+	__vdso_futex_update_ips(mm, false,
+				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_start),
+				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end));
+}
+
 #else
-static inline void __vdso_futex_update_ips(struct mm_struct *mm, bool is_32bit, void *startp,
-					   void *endp)
+static inline void vdso_futex_update_ips(struct mm_struct *mm) {}
 #endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
 
+
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
+	vdso_futex_update_ips(current->mm);
+
 	return 0;
 }
 
@@ -366,5 +377,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
 	mmap_write_unlock(mm);
 
+	vdso_futex_update_ips(mm);
+
 	return ret;
 }
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
 
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 52314be29191..225f59bb81d1 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -104,6 +104,9 @@ VERSION
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
 		__kernel_getrandom;
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+		__vdso_futex_robust_list64_try_unlock;
+#endif
 	local: *;
 	};
 }
@@ -112,3 +115,9 @@ VERSION
  * Make the sigreturn code visible to the kernel.
  */
 VDSO_sigtramp		= __kernel_rt_sigreturn;
+
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+VDSO_futex_list64_try_unlock_cs_start = __futex_list64_try_unlock_cs_start;
+VDSO_futex_list64_try_unlock_cs_success = __futex_list64_try_unlock_cs_success;
+VDSO_futex_list64_try_unlock_cs_end = __futex_list64_try_unlock_cs_end;
+#endif
diff --git a/arch/arm64/kernel/vdso/vfutex.c b/arch/arm64/kernel/vdso/vfutex.c
new file mode 100644
index 000000000000..7622aa34bfdb
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vfutex.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/stringify.h>
+#include <vdso/futex.h>
+
+#define LABEL(l)						\
+	"	.globl " #l "\n"				\
+	#l ":\n"
+
+__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
+{
+	/*
+	 * arm64_futex_robust_unlock_get_pop() depends on this exact register
+	 * allocation to work correctly.
+	 */
+	register __u64 pop_reg asm("x2") = (__u64) pop;
+	register __u32 result_reg asm("w3") = 0;
+	__u32 val;
+
+	asm volatile (
+		"	prfm	pstl1strm, %[lock]		\n"
+		"retry:						\n"
+		"	ldxr	%w[val], %[lock]		\n"
+		"	cmp	%w[tid], %w[val]		\n"
+		"	b.ne	__futex_list64_try_unlock_cs_end\n"
+		"	stlxr	%w[result], wzr, %[lock]	\n"
+		LABEL(__futex_list64_try_unlock_cs_start)
+		"	cbnz	%w[result], retry		\n"
+		LABEL(__futex_list64_try_unlock_cs_success)
+		"	str	xzr, [%x[pop_reg]]		\n"
+		LABEL(__futex_list64_try_unlock_cs_end)
+
+		: [val] "=&r" (val),
+		  [result] "=&r" (result_reg),
+		  [lock] "+Q" (*lock)
+		: [tid] "r" (tid),
+		  [pop_reg] "r" (pop_reg)
+		: "cc", "memory"
+	);
+
+	return val;
+}

-- 
2.55.0

