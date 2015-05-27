From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
Date: Wed, 27 May 2015 15:36:48 +0100
Message-ID: <20150527143648.GA4232@arm.com>
References: <555CB3D5.7000307@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555CB3D5.7000307@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>
List-Id: linux-arch.vger.kernel.org

Hi Andr=E9,

On Wed, May 20, 2015 at 05:18:29PM +0100, Andr=E9 Hentschel wrote:
> From: Andr=E9 Hentschel <nerv@dawncrow.de>
>=20
> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writea=
ble TLS
> register on ARM is preserved per thread.
>=20
> This patch does it analogous to the ARM patch, but for compat mode on=
 ARM64.
>=20
> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
>=20
> ---
> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641e=
fa74a031)
>=20
> v2: Trying to address suggestions by Will Deacon
>=20
> @Will Deacon: 	The macro you suggested is not helpful it seems, inste=
ad i introduced
> 		static functions. They also could be macros i guess, but it seems
> 		much cleaner to me to use functions as it only affects one file.

I wanted to understand in more detail why the macro didn't work out for
you, so I trued hacking together my own version of the patch (see below=
).
It seems to hold up to light testing, so it would be good to know where
you ran into problems.

> Should the final version be send to rmk's patchtracker or will someon=
e
> else pick it up?

This is an arm64 patch, so either Catalin or me will pick it up directl=
y
when it's ready to be merged.

Will

--->8

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/as=
m/processor.h
index d2c37a1df0eb..e4c893e54f01 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -78,13 +78,30 @@ struct cpu_context {
=20
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
-	unsigned long		tp_value;
+	unsigned long		tp_value;	/* TLS register */
+#ifdef CONFIG_COMPAT
+	unsigned long		tp2_value;
+#endif
 	struct fpsimd_state	fpsimd_state;
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
 };
=20
+#ifdef CONFIG_COMPAT
+#define task_user_tls(t)						\
+({									\
+	unsigned long *__tls;						\
+	if (is_compat_thread(task_thread_info(t)))			\
+		__tls =3D &(t)->thread.tp2_value;				\
+	else								\
+		__tls =3D &(t)->thread.tp_value;				\
+	__tls;								\
+ })
+#else
+#define task_user_tls(t)	(&(t)->thread.tp_value)
+#endif
+
 #define INIT_THREAD  {	}
=20
 static inline void start_thread_common(struct pt_regs *regs, unsigned =
long pc)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b96f45..c96927e83446 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -254,35 +254,35 @@ int copy_thread(unsigned long clone_flags, unsign=
ed long stack_start,
 		unsigned long stk_sz, struct task_struct *p)
 {
 	struct pt_regs *childregs =3D task_pt_regs(p);
-	unsigned long tls =3D p->thread.tp_value;
=20
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
=20
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs =3D *current_pt_regs();
 		childregs->regs[0] =3D 0;
-		if (is_compat_thread(task_thread_info(p))) {
-			if (stack_start)
+
+		/*
+		 * Read the current TLS pointer from tpidr_el0 as it may be
+		 * out-of-sync with the saved value.
+		 */
+		asm("mrs %0, tpidr_el0" : "=3Dr" (*task_user_tls(p)));
+
+		if (stack_start) {
+			if (is_compat_thread(task_thread_info(p)))
 				childregs->compat_sp =3D stack_start;
-		} else {
-			/*
-			 * Read the current TLS pointer from tpidr_el0 as it may be
-			 * out-of-sync with the saved value.
-			 */
-			asm("mrs %0, tpidr_el0" : "=3Dr" (tls));
-			if (stack_start) {
-				/* 16-byte aligned stack mandatory on AArch64 */
-				if (stack_start & 15)
-					return -EINVAL;
+			/* 16-byte aligned stack mandatory on AArch64 */
+			else if (stack_start & 15)
+				return -EINVAL;
+			else
 				childregs->sp =3D stack_start;
-			}
 		}
+
 		/*
 		 * If a TLS pointer was passed to clone (4th argument), use it
 		 * for the new thread.
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			tls =3D childregs->regs[3];
+			p->thread.tp_value =3D childregs->regs[3];
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate =3D PSR_MODE_EL1h;
@@ -291,7 +291,6 @@ int copy_thread(unsigned long clone_flags, unsigned=
 long stack_start,
 	}
 	p->thread.cpu_context.pc =3D (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp =3D (unsigned long)childregs;
-	p->thread.tp_value =3D tls;
=20
 	ptrace_hw_copy_thread(p);
=20
@@ -302,18 +301,12 @@ static void tls_thread_switch(struct task_struct =
*next)
 {
 	unsigned long tpidr, tpidrro;
=20
-	if (!is_compat_task()) {
-		asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
-		current->thread.tp_value =3D tpidr;
-	}
+	asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
+	*task_user_tls(current) =3D tpidr;
=20
-	if (is_compat_thread(task_thread_info(next))) {
-		tpidr =3D 0;
-		tpidrro =3D next->thread.tp_value;
-	} else {
-		tpidr =3D next->thread.tp_value;
-		tpidrro =3D 0;
-	}
+	tpidr =3D *task_user_tls(next);
+	tpidrro =3D is_compat_thread(task_thread_info(next)) ?
+		  next->thread.tp_value : 0;
=20
 	asm(
 	"	msr	tpidr_el0, %0\n"
