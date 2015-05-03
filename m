From: =?windows-1252?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on context
 switch and fork in compat mode
Date: Sun, 03 May 2015 18:24:18 +0200
Message-ID: <55464BB2.7030401@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:13712 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbbECQY5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 May 2015 12:24:57 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Jonathan Austin <jonathan.austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>

=46rom: Andr=E9 Hentschel <nerv@dawncrow.de>

Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeabl=
e TLS
register on ARM is preserved per thread.

This patch does it analogous to the ARM patch, but for compat mode on A=
RM64.

Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>=20

---
This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa=
74a031)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/as=
m/processor.h
index 20e9591..cd7b8c9 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -78,7 +78,7 @@ struct cpu_context {
=20
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
-	unsigned long		tp_value;
+	unsigned long		tp_value[2];	/* TLS registers */
 	struct fpsimd_state	fpsimd_state;
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b..fc7cc6bc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -218,7 +218,8 @@ static void tls_thread_flush(void)
 	asm ("msr tpidr_el0, xzr");
=20
 	if (is_compat_task()) {
-		current->thread.tp_value =3D 0;
+		current->thread.tp_value[0] =3D 0;
+		current->thread.tp_value[1] =3D 0;
=20
 		/*
 		 * We need to ensure ordering between the shadow state and the
@@ -254,7 +255,7 @@ int copy_thread(unsigned long clone_flags, unsigned=
 long stack_start,
 		unsigned long stk_sz, struct task_struct *p)
 {
 	struct pt_regs *childregs =3D task_pt_regs(p);
-	unsigned long tls =3D p->thread.tp_value;
+	unsigned long tls =3D p->thread.tp_value[0];
=20
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
=20
@@ -283,6 +284,11 @@ int copy_thread(unsigned long clone_flags, unsigne=
d long stack_start,
 		 */
 		if (clone_flags & CLONE_SETTLS)
 			tls =3D childregs->regs[3];
+		if (is_compat_thread(task_thread_info(p))) {
+			unsigned long tpuser;
+			asm("mrs %0, tpidr_el0" : "=3Dr" (tpuser));
+			p->thread.tp_value[1] =3D tpuser;
+		}
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate =3D PSR_MODE_EL1h;
@@ -291,7 +297,7 @@ int copy_thread(unsigned long clone_flags, unsigned=
 long stack_start,
 	}
 	p->thread.cpu_context.pc =3D (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp =3D (unsigned long)childregs;
-	p->thread.tp_value =3D tls;
+	p->thread.tp_value[0] =3D tls;
=20
 	ptrace_hw_copy_thread(p);
=20
@@ -302,16 +308,17 @@ static void tls_thread_switch(struct task_struct =
*next)
 {
 	unsigned long tpidr, tpidrro;
=20
-	if (!is_compat_task()) {
-		asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
-		current->thread.tp_value =3D tpidr;
-	}
+	asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
+	if (is_compat_task())
+		current->thread.tp_value[1] =3D tpidr;
+	else
+		current->thread.tp_value[0] =3D tpidr;
=20
 	if (is_compat_thread(task_thread_info(next))) {
-		tpidr =3D 0;
-		tpidrro =3D next->thread.tp_value;
+		tpidr =3D next->thread.tp_value[1];
+		tpidrro =3D next->thread.tp_value[0];
 	} else {
-		tpidr =3D next->thread.tp_value;
+		tpidr =3D next->thread.tp_value[0];
 		tpidrro =3D 0;
 	}
=20
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d882b83..1eec962 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -533,7 +533,7 @@ static int tls_get(struct task_struct *target, cons=
t struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
-	unsigned long *tls =3D &target->thread.tp_value;
+	unsigned long *tls =3D &target->thread.tp_value[0];
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, tls, 0, -1);
 }
=20
@@ -548,7 +548,7 @@ static int tls_set(struct task_struct *target, cons=
t struct user_regset *regset,
 	if (ret)
 		return ret;
=20
-	target->thread.tp_value =3D tls;
+	target->thread.tp_value[0] =3D tls;
 	return ret;
 }
=20
@@ -1061,7 +1061,7 @@ long compat_arch_ptrace(struct task_struct *child=
, compat_long_t request,
 			break;
=20
 		case COMPAT_PTRACE_GET_THREAD_AREA:
-			ret =3D put_user((compat_ulong_t)child->thread.tp_value,
+			ret =3D put_user((compat_ulong_t)child->thread.tp_value[0],
 				       (compat_ulong_t __user *)datap);
 			break;
=20
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_com=
pat.c
index 28c511b..fd4330c 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -87,7 +87,7 @@ long compat_arm_syscall(struct pt_regs *regs)
 		return do_compat_cache_op(regs->regs[0], regs->regs[1], regs->regs[2=
]);
=20
 	case __ARM_NR_compat_set_tls:
-		current->thread.tp_value =3D regs->regs[0];
+		current->thread.tp_value[0] =3D regs->regs[0];
=20
 		/*
 		 * Protect against register corruption from context switch.
