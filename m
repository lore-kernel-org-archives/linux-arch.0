From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Change long to unsigned long in ptrace functions to
   fix sparse warnings
Date: Fri, 2 May 2008 09:10:27 +1000
Message-ID: <18458.19939.138289.173048@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:39242 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933777AbYEAXKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 May 2008 19:10:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Sparse warns every time we have an (unsigned long __user *) cast on a
long (not unsigned long) variable.  This happens frequently in the
ptrace code because the addr and data arguments to sys_ptrace,
ptrace_request, arch_ptrace et al. are long rather than unsigned long.

There doesn't seem to be any good reason not to have them be unsigned,
so this changes them from long to unsigned long.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 1e9ad52..65c95a1 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -260,7 +260,8 @@ void ptrace_disable(struct task_struct *child)
 	ptrace_cancel_bpt(child);
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	unsigned long tmp;
 	size_t copied;
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 4b05dc5..32c32ff 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -70,7 +70,7 @@ static inline long get_user_reg(struct task_struct *task, int offset)
  * data space.
  */
 static inline int
-put_user_reg(struct task_struct *task, int offset, long data)
+put_user_reg(struct task_struct *task, int offset, unsigned long data)
 {
 	struct pt_regs newregs, *regs = task_pt_regs(task);
 	int ret = -EINVAL;
@@ -655,7 +655,8 @@ static int ptrace_setcrunchregs(struct task_struct *tsk, void __user *ufp)
 }
 #endif
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/avr32/kernel/ptrace.c b/arch/avr32/kernel/ptrace.c
index 1fed38f..fb7cf91 100644
--- a/arch/avr32/kernel/ptrace.c
+++ b/arch/avr32/kernel/ptrace.c
@@ -141,7 +141,8 @@ static int ptrace_setregs(struct task_struct *tsk, const void __user *uregs)
 	return ret;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/blackfin/kernel/ptrace.c b/arch/blackfin/kernel/ptrace.c
index b4f062c..edab92b 100644
--- a/arch/blackfin/kernel/ptrace.c
+++ b/arch/blackfin/kernel/ptrace.c
@@ -189,7 +189,8 @@ void ptrace_disable(struct task_struct *child)
 	put_reg(child, PT_SR, tmp);
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 	int add = 0;
diff --git a/arch/cris/arch-v10/kernel/ptrace.c b/arch/cris/arch-v10/kernel/ptrace.c
index ee505b2..533d7d5 100644
--- a/arch/cris/arch-v10/kernel/ptrace.c
+++ b/arch/cris/arch-v10/kernel/ptrace.c
@@ -76,7 +76,8 @@ ptrace_disable(struct task_struct *child)
  * (in user space) where the result of the ptrace call is written (instead of
  * being returned).
  */
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
diff --git a/arch/cris/arch-v32/kernel/ptrace.c b/arch/cris/arch-v32/kernel/ptrace.c
index e27f467..4f12afd 100644
--- a/arch/cris/arch-v32/kernel/ptrace.c
+++ b/arch/cris/arch-v32/kernel/ptrace.c
@@ -98,7 +98,8 @@ ptrace_disable(struct task_struct *child)
 }
 
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
diff --git a/arch/frv/kernel/ptrace.c b/arch/frv/kernel/ptrace.c
index 709e9bd..6c148c3 100644
--- a/arch/frv/kernel/ptrace.c
+++ b/arch/frv/kernel/ptrace.c
@@ -104,7 +104,8 @@ void ptrace_enable(struct task_struct *child)
 	child->thread.frame0->__status |= REG__STATUS_STEP;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	unsigned long tmp;
 	int ret;
diff --git a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
index d32bbf0..8c82852 100644
--- a/arch/h8300/kernel/ptrace.c
+++ b/arch/h8300/kernel/ptrace.c
@@ -55,7 +55,8 @@ void ptrace_disable(struct task_struct *child)
 	h8300_disable_trace(child);
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 2a9943b..bddd878 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1179,7 +1179,8 @@ ptrace_disable (struct task_struct *child)
 }
 
 long
-arch_ptrace (struct task_struct *child, long request, long addr, long data)
+arch_ptrace (struct task_struct *child, long request,
+	     unsigned long addr, unsigned long data)
 {
 	switch (request) {
 	case PTRACE_PEEKTEXT:
diff --git a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
index 9aa615d..ec89a11 100644
--- a/arch/m32r/kernel/ptrace.c
+++ b/arch/m32r/kernel/ptrace.c
@@ -594,7 +594,8 @@ void ptrace_disable(struct task_struct *child)
 }
 
 long
-arch_ptrace(struct task_struct *child, long request, long addr, long data)
+arch_ptrace(struct task_struct *child, long request,
+	    unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index 2075543..51a68e5 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -118,7 +118,8 @@ void ptrace_disable(struct task_struct *child)
 	singlestep_disable(child);
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	unsigned long tmp;
 	int i, ret = 0;
diff --git a/arch/m68knommu/kernel/ptrace.c b/arch/m68knommu/kernel/ptrace.c
index ef70ca0..8cbfce5 100644
--- a/arch/m68knommu/kernel/ptrace.c
+++ b/arch/m68knommu/kernel/ptrace.c
@@ -99,7 +99,8 @@ void ptrace_disable(struct task_struct *child)
 	put_reg(child, PT_SR, tmp);
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 35234b9..bdfbf66 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -167,7 +167,8 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 	return 0;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/mn10300/kernel/ptrace.c b/arch/mn10300/kernel/ptrace.c
index d6d6cdc..e21f147 100644
--- a/arch/mn10300/kernel/ptrace.c
+++ b/arch/mn10300/kernel/ptrace.c
@@ -132,7 +132,8 @@ void ptrace_enable(struct task_struct *child)
 /*
  * handle the arch-specific side of process tracing
  */
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	struct fpu_state_struct fpu_state;
 	int i, ret;
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 49c6379..0124056 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -77,7 +77,8 @@ void ptrace_disable(struct task_struct *child)
 	pa_psw(child)->l = 0;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	long ret;
 #ifdef DEBUG_PTRACE
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2a9fe97..fa091f6 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -674,8 +674,8 @@ void ptrace_disable(struct task_struct *child)
  * Here are the old "legacy" powerpc specific getregs/setregs ptrace calls,
  * we mark them as obsolete now, they will be removed in a future version
  */
-static long arch_ptrace_old(struct task_struct *child, long request, long addr,
-			    long data)
+static long arch_ptrace_old(struct task_struct *child, long request,
+			    unsigned long addr, unsigned long data)
 {
 	switch (request) {
 	case PPC_PTRACE_GETREGS:	/* Get GPRs 0 - 31. */
@@ -702,7 +702,8 @@ static long arch_ptrace_old(struct task_struct *child, long request, long addr,
 	return -EPERM;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret = -EPERM;
 
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 7f42701..f173f25 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -607,7 +607,8 @@ do_ptrace_emu31(struct task_struct *child, long request, long addr, long data)
 }
 #endif
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	switch (request) {
 	case PTRACE_SYSCALL:
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index fddb547..ea3ee3a 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -84,7 +84,8 @@ void ptrace_disable(struct task_struct *child)
 	ptrace_disable_singlestep(child);
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	struct user * dummy = NULL;
 	int ret;
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index d453c47..0d0833a 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -121,7 +121,8 @@ put_fpu_long(struct task_struct *task, unsigned long addr, unsigned long data)
 }
 
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 
diff --git a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
index 7f44ae6..7b0c68e 100644
--- a/arch/sparc/kernel/ptrace.c
+++ b/arch/sparc/kernel/ptrace.c
@@ -319,7 +319,8 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &user_sparc32_view;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	unsigned long addr2 = current->thread.kregs->u_regs[UREG_I4];
 	const struct user_regset_view *view;
diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
index e9fc0aa..a0c87ba 100644
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -957,7 +957,8 @@ struct fps {
 	unsigned long fsr;
 };
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	const struct user_regset_view *view = task_user_regset_view(current);
 	unsigned long addr2 = task_pt_regs(current)->u_regs[UREG_I4];
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 47b57b4..b0a634e 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -36,7 +36,8 @@ void ptrace_disable(struct task_struct *child)
 extern int peek_user(struct task_struct * child, long addr, long data);
 extern int poke_user(struct task_struct * child, long addr, long data);
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int i, ret;
 	unsigned long __user *p = (void __user *)(unsigned long)data;
diff --git a/arch/um/sys-i386/ptrace.c b/arch/um/sys-i386/ptrace.c
index 6b44999..f7c4d23 100644
--- a/arch/um/sys-i386/ptrace.c
+++ b/arch/um/sys-i386/ptrace.c
@@ -205,8 +205,8 @@ int set_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
 	return restore_fpx_registers(userspace_pid[cpu], fpregs);
 }
 
-long subarch_ptrace(struct task_struct *child, long request, long addr,
-		    long data)
+long subarch_ptrace(struct task_struct *child, long request, unsigned long addr,
+		    unsigned long data)
 {
 	return -EIO;
 }
diff --git a/arch/um/sys-x86_64/ptrace.c b/arch/um/sys-x86_64/ptrace.c
index f3458d7..8284d6e 100644
--- a/arch/um/sys-x86_64/ptrace.c
+++ b/arch/um/sys-x86_64/ptrace.c
@@ -175,8 +175,8 @@ int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 	return restore_fp_registers(userspace_pid[cpu], fpregs);
 }
 
-long subarch_ptrace(struct task_struct *child, long request, long addr,
-		    long data)
+long subarch_ptrace(struct task_struct *child, long request, unsigned long addr,
+		    unsigned long data)
 {
 	int ret = -EIO;
 
diff --git a/arch/v850/kernel/ptrace.c b/arch/v850/kernel/ptrace.c
index a458ac9..f1c1305 100644
--- a/arch/v850/kernel/ptrace.c
+++ b/arch/v850/kernel/ptrace.c
@@ -112,7 +112,8 @@ static int set_single_step (struct task_struct *t, int val)
 	return 1;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int rval;
 
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index fb03ef3..e580933 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -867,7 +867,8 @@ void ptrace_disable(struct task_struct *child)
 static const struct user_regset_view user_x86_32_view; /* Initialized below. */
 #endif
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 9486882..679e43e 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -245,7 +245,8 @@ int ptrace_pokeusr(struct task_struct *child, long regno, long val)
 	return 0;
 }
 
-long arch_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
 {
 	int ret = -EPERM;
 
diff --git a/include/asm-um/ptrace-generic.h b/include/asm-um/ptrace-generic.h
index 6aefcd3..c3ac533 100644
--- a/include/asm-um/ptrace-generic.h
+++ b/include/asm-um/ptrace-generic.h
@@ -36,8 +36,8 @@ struct pt_regs {
 
 struct task_struct;
 
-extern long subarch_ptrace(struct task_struct *child, long request, long addr,
-			   long data);
+extern long subarch_ptrace(struct task_struct *child, long request,
+			   unsigned long addr, unsigned long data);
 extern unsigned long getreg(struct task_struct *child, int regno);
 extern int putreg(struct task_struct *child, int regno, unsigned long value);
 extern int get_fpregs(struct user_i387_struct __user *buf,
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index f98501b..e878737 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -80,7 +80,8 @@
 #include <linux/sched.h>		/* For struct task_struct.  */
 
 
-extern long arch_ptrace(struct task_struct *child, long request, long addr, long data);
+extern long arch_ptrace(struct task_struct *child, long request,
+			unsigned long addr, unsigned long data);
 extern struct task_struct *ptrace_get_task_struct(pid_t pid);
 extern int ptrace_traceme(void);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
@@ -89,7 +90,8 @@ extern int ptrace_attach(struct task_struct *tsk);
 extern int ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
-extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
+extern int ptrace_request(struct task_struct *child, long request,
+			unsigned long addr, unsigned long data);
 extern void ptrace_notify(int exit_code);
 extern void __ptrace_link(struct task_struct *child,
 			  struct task_struct *new_parent);
@@ -114,8 +116,10 @@ static inline void ptrace_unlink(struct task_struct *child)
 		__ptrace_unlink(child);
 }
 
-int generic_ptrace_peekdata(struct task_struct *tsk, long addr, long data);
-int generic_ptrace_pokedata(struct task_struct *tsk, long addr, long data);
+int generic_ptrace_peekdata(struct task_struct *tsk, unsigned long addr,
+			unsigned long data);
+int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
+			unsigned long data);
 
 #ifndef force_successful_syscall_return
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0522f36..44ed9bb 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -499,7 +499,8 @@ asmlinkage long sys_nfsservctl(int cmd,
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
 asmlinkage long sys_uselib(const char __user *library);
 asmlinkage long sys_ni_syscall(void);
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data);
+asmlinkage long sys_ptrace(long request, long pid, unsigned long addr,
+			   unsigned long data);
 
 asmlinkage long sys_add_key(const char __user *_type,
 			    const char __user *_description,
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index dcc199c..88149f2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -292,7 +292,7 @@ int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long ds
 	return copied;
 }
 
-static int ptrace_setoptions(struct task_struct *child, long data)
+static int ptrace_setoptions(struct task_struct *child, unsigned long data)
 {
 	child->ptrace &= ~PT_TRACE_MASK;
 
@@ -375,7 +375,8 @@ static int ptrace_setsiginfo(struct task_struct *child, const siginfo_t *info)
 #define is_sysemu_singlestep(request)	0
 #endif
 
-static int ptrace_resume(struct task_struct *child, long request, long data)
+static int ptrace_resume(struct task_struct *child, long request,
+			 unsigned long data)
 {
 	if (!valid_signal(data))
 		return -EIO;
@@ -411,7 +412,7 @@ static int ptrace_resume(struct task_struct *child, long request, long data)
 }
 
 int ptrace_request(struct task_struct *child, long request,
-		   long addr, long data)
+		   unsigned long addr, unsigned long data)
 {
 	int ret = -EIO;
 	siginfo_t siginfo;
@@ -535,7 +536,8 @@ struct task_struct *ptrace_get_task_struct(pid_t pid)
 #endif
 
 #ifndef __ARCH_SYS_PTRACE
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+asmlinkage long sys_ptrace(long request, long pid, unsigned long addr,
+			   unsigned long data)
 {
 	struct task_struct *child;
 	long ret;
@@ -584,7 +586,8 @@ asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 }
 #endif /* __ARCH_SYS_PTRACE */
 
-int generic_ptrace_peekdata(struct task_struct *tsk, long addr, long data)
+int generic_ptrace_peekdata(struct task_struct *tsk, unsigned long addr,
+			    unsigned long data)
 {
 	unsigned long tmp;
 	int copied;
@@ -595,7 +598,8 @@ int generic_ptrace_peekdata(struct task_struct *tsk, long addr, long data)
 	return put_user(tmp, (unsigned long __user *)data);
 }
 
-int generic_ptrace_pokedata(struct task_struct *tsk, long addr, long data)
+int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
+			    unsigned long data)
 {
 	int copied;
 
