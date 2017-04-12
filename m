From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2 6/6] arm64: signal: Report signal frame size to userspace via auxv
Date: Wed, 12 Apr 2017 18:01:15 +0100
Message-ID: <1492016495-19689-6-git-send-email-Dave.Martin@arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdDLRD3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Apr 2017 13:03:29 -0400
In-Reply-To: <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Stateful CPU architecture extensions may require the signal frame
to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
However, changing this #define is an ABI break.

To allow userspace the option of determining the signal frame size
in a more forwards-compatible way, this patch adds a new auxv entry
tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
size that the process can observe during its lifetime.

If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
assume that the MINSIGSTKSZ #define is sufficient.  This allows for
a consistent interface with older kernels that do not provide
AT_MINSIGSTKSZ.

The idea is that libc could expose this via sysconf() or some
similar mechanism.

There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
about userspace's own stack overheads and should not pretend to
know.

For arm64:

The primary motivation for this interface is the Scalable Vector
Extension, which can require at least 4KB or so of extra space
in the signal frame for the largest hardware implementations.

To determine the correct value, a "Christmas tree" mode (via the
add_all argument) is added to setup_sigframe_layout(), to simulate
addition of all possible records to the signal frame at maximum
possible size.

If this procedure goes wrong somehow, resulting in a stupidly large
frame layout and hence failure of sigframe_alloc() to allocate a
record to the frame, then this is indicative of a kernel bug: the
kernel's internal SIGFRAME_MAXSZ is supposed to sanity-check
against generting frames that we consider _impossibly_ large.  In
this case, SIGSTKSZ is returned as a "reasonable guess that is at
least bigger than MINSIGSTKSZ" and we WARN().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

Notes:

1)

Should AT_MINSIGSTKSZ be defined globally?

If there's a likelihood that one or more other arches may make use
of this mechanism, then the define could be moved to
linux/include/uapi/linux/auxvec.h.

Either way, userspace code can do #ifdef AT_MINSIGSTKSZ, so the
define can be left arch-specific without serious source
incompatibility for userspace.  The chosen number is ABI though:
currently it's in the arch-specific space (>= 32).

2)

The kernel has an ABI commitment not to generate larger signal
frames than userspace expects, so another mechanism would be needed
to "turn on" the generation of larger frames.

For now I don't anticipate a global mechanism for this.  For SVE,
I currently have a mechanism to limit the vector length given to
new processes by default, thus avoiding signal frames larger than
MINSIGSTKSZ being seen unless the program explicitly asks for
longer vectors.

3)

This patch feels like an abuse of ARCH_DLINFO, but I didn't
feel it was worth hacking the core code just for this...

If anyone objects, I'm happy to propose a new macro (or a new name
for the existing macro).

4)

For arm64, when the signal frame has not been enlarged, the true
size is returned, which is slightly smaller than MINSIGSTKSZ.

Since callers must know their own stack overheads in order to make
use of the result, and since we have no way to know those, this
probably doesn't matter.

There could be an argument for returning MINSIGSTKSZ though, in
case there is software that assumes for other reasons that stacks
are at least MINSIGSTKSZ in size.  By definition this interface
can't expect to ensure 100% compatibility, so it's not clear
whether this matters.  Userspace that cares could equally implement
this clamping itself.

---
 arch/arm64/include/asm/elf.h         |  5 +++++
 arch/arm64/include/asm/processor.h   |  3 +++
 arch/arm64/include/uapi/asm/auxvec.h |  3 ++-
 arch/arm64/kernel/signal.c           | 36 +++++++++++++++++++++++++++++++-----
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 5d17004..5958487 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -24,6 +24,10 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 
+#ifndef __ASSEMBLY__
+#include <asm/processor.h> /* for get_minsigstksz(), used by ARCH_DLINFO */
+#endif
+
 /*
  * AArch64 static relocation types.
  */
@@ -149,6 +153,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
 		    (elf_addr_t)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_minsigstksz());			\
 } while (0)
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 0502007..9bf5804 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -194,4 +194,7 @@ static inline void spin_lock_prefetch(const void *ptr)
 int cpu_enable_pan(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
+/* User signal frame size discovery: */
+int get_minsigstksz(void);
+
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 4cf0c17..1d45b28 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -18,7 +18,8 @@
 
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
+#define AT_MINSIGSTKSZ	34	/* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
 
 #endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 983cddf..c4ac046 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -407,8 +407,15 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return 0;
 }
 
-/* Determine the layout of optional records in the signal frame */
-static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
+/*
+ * Determine the layout of optional records in the signal frame
+ *
+ * add_all: if true, lays out the biggest possible signal frame for
+ *	this task; otherwise, generates a layout for the current state
+ *	of the task.
+ */
+static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
+				 bool add_all)
 {
 	int err;
 
@@ -418,7 +425,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 		return err;
 
 	/* fault information, if valid */
-	if (current->thread.fault_code) {
+	if (add_all || current->thread.fault_code) {
 		err = sigframe_alloc(user, &user->esr_offset,
 				     sizeof(struct esr_context));
 		if (err)
@@ -428,7 +435,6 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 	return sigframe_alloc_end(user);
 }
 
-
 static int setup_sigframe(struct rt_sigframe_user_layout *user,
 			  struct pt_regs *regs, sigset_t *set)
 {
@@ -505,7 +511,7 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 	int err;
 
 	init_user_layout(user);
-	err = setup_sigframe_layout(user);
+	err = setup_sigframe_layout(user, false);
 	if (err)
 		return err;
 
@@ -728,3 +734,23 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		thread_flags = READ_ONCE(current_thread_info()->flags);
 	} while (thread_flags & _TIF_WORK_MASK);
 }
+
+/*
+ * Determine the stack space required for guaranteed signal devliery.
+ * This function is used to populate AT_MINSIGSTKSZ at process startup.
+ */
+int get_minsigstksz(void)
+{
+	struct rt_sigframe_user_layout user;
+	int err;
+
+	init_user_layout(&user);
+	err = setup_sigframe_layout(&user, true);
+
+	if (err) {
+		WARN_ON(1);
+
+		return SIGSTKSZ;
+	} else
+		return sigframe_size(&user) + 16; /* max alignment padding */
+}
-- 
2.1.4
