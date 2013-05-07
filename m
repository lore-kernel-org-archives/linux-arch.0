From: =?ISO-8859-15?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: [PATCHv3] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
Date: Tue, 07 May 2013 22:51:00 +0200
Message-ID: <51896934.5080803@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56270 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab3EGUvI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 May 2013 16:51:08 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Jonathan Austin <jonathan.austin@arm.com>

=46rom: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>

Since commit 6a1c53124aa1 the user writeable TLS register was zeroed to
prevent it from being used as a covert channel between two tasks.

There are more and more applications coming to WinRT, Wine could suppor=
t them,
but mostly they expect to have the thread environment block (TEB) in TP=
IDRURW.

This patch preserves that register per thread instead of clearing it.
Unlike the TPIDRURO, which is already switched, the TPIDRURW
can be updated from userspace so needs careful treatment in the case th=
at we
modify TPIDRURW and call fork(). To avoid this we must always read
TPIDRURW in copy_thread.

Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>=20

---
This patch is against a86d52667d8eda5de39393ce737794403bdce1eb

I could only test it with kernel 3.4.6, beside using Wine for testing i=
 also
used https://github.com/AndreRH/tpidrurw-test

Why so much Signed-off-bys? Some History:
The first patch had performance issues pointed out by Russel King,
so Will Deacon jumped in to help me with that. The second one again
had performance issues and the missing copy_thread part was uncovered.
After some iterations by me, Jonathan Austin proposed a patch and
Russel King sent his idea of the assembler part. All this was finally
merged and refined into this patch.
Thanks to everyone!

 arch/arm/include/asm/thread_info.h |    2 +-
 arch/arm/include/asm/tls.h         |   41 ++++++++++++++++++++++++++++=
-------------
 arch/arm/kernel/entry-armv.S       |    4 ++--
 arch/arm/kernel/process.c          |    4 +++-
 arch/arm/kernel/ptrace.c           |    2 +-
 arch/arm/kernel/traps.c            |    4 ++--
 6 files changed, 37 insertions(+), 20 deletions(-)



diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/=
thread_info.h
index cddda1f..d90be6d 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -58,7 +58,7 @@ struct thread_info {
 	struct cpu_context_save	cpu_context;	/* cpu context */
 	__u32			syscall;	/* syscall number */
 	__u8			used_cp[16];	/* thread used copro */
-	unsigned long		tp_value;
+	unsigned long		tp_value[2];	/* TLS registers */
 #ifdef CONFIG_CRUNCH
 	struct crunch_state	crunchstate;
 #endif
diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 73409e6..22756ab 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -2,27 +2,30 @@
 #define __ASMARM_TLS_H
=20
 #ifdef __ASSEMBLY__
-	.macro set_tls_none, tp, tmp1, tmp2
+#include <asm/asm-offsets.h>
+	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
 	.endm
=20
-	.macro set_tls_v6k, tp, tmp1, tmp2
+	.macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
+	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
 	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
-	mov	\tmp1, #0
-	mcr	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
+	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
+	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
 	.endm
=20
-	.macro set_tls_v6, tp, tmp1, tmp2
+	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
 	ldr	\tmp1, =3Delf_hwcap
 	ldr	\tmp1, [\tmp1, #0]
 	mov	\tmp2, #0xffff0fff
 	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
-	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
-	movne	\tmp1, #0
-	mcrne	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
 	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
+	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
+	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
+	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
+	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
 	.endm
=20
-	.macro set_tls_software, tp, tmp1, tmp2
+	.macro switch_tls_software, base, tp, tpuser, tmp1, tmp2
 	mov	\tmp1, #0xffff0fff
 	str	\tp, [\tmp1, #-15]		@ set TLS value at 0xffff0ff0
 	.endm
@@ -31,19 +34,31 @@
 #ifdef CONFIG_TLS_REG_EMUL
 #define tls_emu		1
 #define has_tls_reg		1
-#define set_tls		set_tls_none
+#define switch_tls	switch_tls_none
 #elif defined(CONFIG_CPU_V6)
 #define tls_emu		0
 #define has_tls_reg		(elf_hwcap & HWCAP_TLS)
-#define set_tls		set_tls_v6
+#define switch_tls	switch_tls_v6
 #elif defined(CONFIG_CPU_32v6K)
 #define tls_emu		0
 #define has_tls_reg		1
-#define set_tls		set_tls_v6k
+#define switch_tls	switch_tls_v6k
 #else
 #define tls_emu		0
 #define has_tls_reg		0
-#define set_tls		set_tls_software
+#define switch_tls	switch_tls_software
 #endif
=20
+#ifndef __ASSEMBLY__
+static inline unsigned long get_tlsuser(void)
+{
+	if (has_tls_reg && !tls_emu)
+	{
+		unsigned long t;
+		__asm__("mrc p15, 0, %0, c13, c0, 2" : "=3Dr" (t));
+		return t;
+	}
+	return 0;
+}
+#endif
 #endif	/* __ASMARM_TLS_H */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.=
S
index 0f82098..80f09fe 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -728,15 +728,15 @@ ENTRY(__switch_to)
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	add	ip, r1, #TI_CPU_SAVE
-	ldr	r3, [r2, #TI_TP_VALUE]
  ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
  THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
  THUMB(	str	sp, [ip], #4		   )
  THUMB(	str	lr, [ip], #4		   )
+	ldrd	r4, r5, [r2, #TI_TP_VALUE]
 #ifdef CONFIG_CPU_USE_DOMAINS
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
-	set_tls	r3, r4, r5
+	switch_tls r1, r4, r5, r3, r7
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	ldr	r7, [r2, #TI_TASK]
 	ldr	r8, =3D__stack_chk_guard
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 047d3e4..24dbc72 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
 #include <asm/mach/time.h>
+#include <asm/tls.h>
=20
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -395,7 +396,8 @@ copy_thread(unsigned long clone_flags, unsigned lon=
g stack_start,
 	clear_ptrace_hw_breakpoint(p);
=20
 	if (clone_flags & CLONE_SETTLS)
-		thread->tp_value =3D childregs->ARM_r3;
+		thread->tp_value[0] =3D childregs->ARM_r3;
+	thread->tp_value[1] =3D get_tlsuser();
=20
 	thread_notify(THREAD_NOTIFY_COPY, thread);
=20
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 03deeff..2bc1514 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -849,7 +849,7 @@ long arch_ptrace(struct task_struct *child, long re=
quest,
 #endif
=20
 		case PTRACE_GET_THREAD_AREA:
-			ret =3D put_user(task_thread_info(child)->tp_value,
+			ret =3D put_user(task_thread_info(child)->tp_value[0],
 				       datap);
 			break;
=20
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1c08911..f9d6259 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -588,7 +588,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *=
regs)
 		return regs->ARM_r0;
=20
 	case NR(set_tls):
-		thread->tp_value =3D regs->ARM_r0;
+		thread->tp_value[0] =3D regs->ARM_r0;
 		if (tls_emu)
 			return 0;
 		if (has_tls_reg) {
@@ -706,7 +706,7 @@ static int get_tp_trap(struct pt_regs *regs, unsign=
ed int instr)
 	int reg =3D (instr >> 12) & 15;
 	if (reg =3D=3D 15)
 		return 1;
-	regs->uregs[reg] =3D current_thread_info()->tp_value;
+	regs->uregs[reg] =3D current_thread_info()->tp_value[0];
 	regs->ARM_pc +=3D 4;
 	return 0;
 }
