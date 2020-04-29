Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 04/26] x86/cet: Add control-protection fault handler
Date: Wed, 29 Apr 2020 15:07:10 -0700
Message-ID: <20200429220732.31602-5-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220710.zRL59njZUK2wDBy8TvNiQILnUD_RjOEztAYQD5HKC3o@z>

A control-protection fault is triggered when a control-flow transfer
attempt violates Shadow Stack or Indirect Branch Tracking constraints.
For example, the return address for a RET instruction differs from the co=
py
on the Shadow Stack; or an indirect JMP instruction, without the NOTRACK
prefix, arrives at a non-ENDBR opcode.

The control-protection fault handler works in a similar way as the genera=
l
protection fault handler.  It provides the si_code SEGV_CPERR to the sign=
al
handler.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v10:
- Change CONFIG_X86_64 to CONFIG_X86_INTEL_CET.

v9:
- Add Shadow Stack pointer to the fault printout.

 arch/x86/entry/entry_64.S          |  2 +-
 arch/x86/include/asm/traps.h       |  5 +++
 arch/x86/kernel/idt.c              |  4 ++
 arch/x86/kernel/signal_compat.c    |  2 +-
 arch/x86/kernel/traps.c            | 59 ++++++++++++++++++++++++++++++
 include/uapi/asm-generic/siginfo.h |  3 +-
 6 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0e9504fabe52..f42780922387 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1034,7 +1034,7 @@ idtentry spurious_interrupt_bug		do_spurious_interr=
upt_bug	has_error_code=3D0
 idtentry coprocessor_error		do_coprocessor_error		has_error_code=3D0
 idtentry alignment_check		do_alignment_check		has_error_code=3D1
 idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_cod=
e=3D0
-
+idtentry control_protection		do_control_protection		has_error_code=3D1
=20
 	/*
 	 * Reload gs selector with exception handling
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index c26a7e1d8a2c..9bf804709ee6 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,6 +35,9 @@ asmlinkage void alignment_check(void);
 asmlinkage void machine_check(void);
 #endif /* CONFIG_X86_MCE */
 asmlinkage void simd_coprocessor_error(void);
+#ifdef CONFIG_X86_INTEL_CET
+asmlinkage void control_protection(void);
+#endif
=20
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
 asmlinkage void xen_divide_error(void);
@@ -86,6 +89,7 @@ dotraplinkage void do_simd_coprocessor_error(struct pt_=
regs *regs, long error_co
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
 dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
+dotraplinkage void do_control_protection(struct pt_regs *regs, long erro=
r_code);
=20
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *e=
regs);
@@ -151,6 +155,7 @@ enum {
 	X86_TRAP_AC,		/* 17, Alignment Check */
 	X86_TRAP_MC,		/* 18, Machine Check */
 	X86_TRAP_XF,		/* 19, SIMD Floating-Point Exception */
+	X86_TRAP_CP =3D 21,	/* 21 Control Protection Fault */
 	X86_TRAP_IRET =3D 32,	/* 32, IRET Exception */
 };
=20
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 87ef69a72c52..19160c8d734f 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -102,6 +102,10 @@ static const __initconst struct idt_data def_idts[] =
=3D {
 #elif defined(CONFIG_X86_32)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
 #endif
+
+#ifdef CONFIG_X86_INTEL_CET
+	INTG(X86_TRAP_CP,		control_protection),
+#endif
 };
=20
 /*
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_com=
pat.c
index 9ccbf0576cd0..c572a3de1037 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  !=3D 11);
 	BUILD_BUG_ON(NSIGFPE  !=3D 15);
-	BUILD_BUG_ON(NSIGSEGV !=3D 7);
+	BUILD_BUG_ON(NSIGSEGV !=3D 8);
 	BUILD_BUG_ON(NSIGBUS  !=3D 5);
 	BUILD_BUG_ON(NSIGTRAP !=3D 5);
 	BUILD_BUG_ON(NSIGCHLD !=3D 6);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d54cffdc7cac..d2515dfbc178 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -586,6 +586,65 @@ dotraplinkage void do_general_protection(struct pt_r=
egs *regs, long error_code)
 }
 NOKPROBE_SYMBOL(do_general_protection);
=20
+static const char * const control_protection_err[] =3D {
+	"unknown",
+	"near-ret",
+	"far-ret/iret",
+	"endbranch",
+	"rstorssp",
+	"setssbsy",
+};
+
+/*
+ * When a control protection exception occurs, send a signal
+ * to the responsible application.  Currently, control
+ * protection is only enabled for the user mode.  This
+ * exception should not come from the kernel mode.
+ */
+dotraplinkage void
+do_control_protection(struct pt_regs *regs, long error_code)
+{
+	struct task_struct *tsk;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	if (notify_die(DIE_TRAP, "control protection fault", regs,
+		       error_code, X86_TRAP_CP, SIGSEGV) =3D=3D NOTIFY_STOP)
+		return;
+	cond_local_irq_enable(regs);
+
+	if (!user_mode(regs))
+		die("kernel control protection fault", regs, error_code);
+
+	if (!static_cpu_has(X86_FEATURE_SHSTK) &&
+	    !static_cpu_has(X86_FEATURE_IBT))
+		WARN_ONCE(1, "CET is disabled but got control protection fault\n");
+
+	tsk =3D current;
+	tsk->thread.error_code =3D error_code;
+	tsk->thread.trap_nr =3D X86_TRAP_CP;
+
+	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
+	    printk_ratelimit()) {
+		unsigned int max_err;
+		unsigned long ssp;
+
+		max_err =3D ARRAY_SIZE(control_protection_err) - 1;
+		if ((error_code < 0) || (error_code > max_err))
+			error_code =3D 0;
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+		pr_info("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)=
",
+			tsk->comm, task_pid_nr(tsk),
+			regs->ip, regs->sp, ssp, error_code,
+			control_protection_err[error_code]);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+
+	force_sig_fault(SIGSEGV, SEGV_CPERR,
+			(void __user *)uprobe_get_trap_addr(regs));
+}
+NOKPROBE_SYMBOL(do_control_protection);
+
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code=
)
 {
 	if (poke_int3_handler(regs))
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generi=
c/siginfo.h
index cb3d6c267181..693071dbe641 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -229,7 +229,8 @@ typedef struct siginfo {
 #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
 #define SEGV_ADIDERR	6	/* Disrupting MCD error */
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
-#define NSIGSEGV	7
+#define SEGV_CPERR	8
+#define NSIGSEGV	8
=20
 /*
  * SIGBUS si_codes
--=20
2.21.0
