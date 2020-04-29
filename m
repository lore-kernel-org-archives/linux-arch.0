Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 20/26] x86/cet/shstk: Handle signals for shadow stack
Date: Wed, 29 Apr 2020 15:07:26 -0700
Message-ID: <20200429220732.31602-21-yu-cheng.yu@intel.com>
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429220726.bSEAUcRkGrh9NkG794p46uPrRdV-y5OvDbc0lLnarjs@z>

To deliver a signal, create a shadow stack restore token and put a restor=
e
token and the signal restorer address on the shadow stack.  For sigreturn=
,
verify the token and restore the shadow stack pointer.

Introduce WRUSS, which is a kernel-mode instruction but writes directly t=
o
user shadow stack.  It is used to construct the user signal stack as
described above.

Introduce a signal context extension struct 'sc_ext', which is used to sa=
ve
shadow stack restore token address and WAIT_ENDBR status.  WAIT_ENDBR wil=
l
be introduced later in the Indirect Branch Tracking (IBT) series, but add
that into sc_ext now to keep the struct stable in case the IBT series is
applied later.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v10:
- Combine with WRUSS instruction patch, since it is used only here.
- Revise signal restore code to the latest supervisor states handling.
  Move shadow stack restore token checking out of the fast path.

v9:
- Update CET MSR access according to XSAVES supervisor state changes.
- Add 'wait_endbr' to struct 'sc_ext'.
- Update and simplify signal frame allocation, setup, and restoration.
- Update commit log text.

v2:
- Move CET status from sigcontext to a separate struct sc_ext, which is
  located above the fpstate on the signal frame.
- Add a restore token for sigreturn address.

 arch/x86/ia32/ia32_signal.c            |  17 +++
 arch/x86/include/asm/cet.h             |   8 ++
 arch/x86/include/asm/fpu/internal.h    |  10 ++
 arch/x86/include/asm/special_insns.h   |  32 ++++++
 arch/x86/include/uapi/asm/sigcontext.h |   9 ++
 arch/x86/kernel/cet.c                  | 151 +++++++++++++++++++++++++
 arch/x86/kernel/fpu/signal.c           | 101 +++++++++++++++++
 arch/x86/kernel/signal.c               |  10 ++
 8 files changed, 338 insertions(+)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index f9d8804144d0..cb19159817cb 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -35,6 +35,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/cet.h>
=20
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
@@ -205,6 +206,7 @@ static void __user *get_sigframe(struct ksignal *ksig=
, struct pt_regs *regs,
 				 void __user **fpstate)
 {
 	unsigned long sp, fx_aligned, math_size;
+	void __user *restorer =3D NULL;
=20
 	/* Default to using normal stack */
 	sp =3D regs->sp;
@@ -218,8 +220,23 @@ static void __user *get_sigframe(struct ksignal *ksi=
g, struct pt_regs *regs,
 		 ksig->ka.sa.sa_restorer)
 		sp =3D (unsigned long) ksig->ka.sa.sa_restorer;
=20
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		restorer =3D ksig->ka.sa.sa_restorer;
+	} else if (current->mm->context.vdso) {
+		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
+			restorer =3D current->mm->context.vdso +
+				vdso_image_32.sym___kernel_rt_sigreturn;
+		else
+			restorer =3D current->mm->context.vdso +
+				vdso_image_32.sym___kernel_sigreturn;
+	}
+
 	sp =3D fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate =3D (struct _fpstate_32 __user *) sp;
+
+	if (save_cet_to_sigframe(1, *fpstate, (unsigned long)restorer))
+		return (void __user *) -1L;
+
 	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
 				     math_size) < 0)
 		return (void __user *) -1L;
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index caac0687c8e4..56fe08eebae6 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
=20
 struct task_struct;
+struct sc_ext;
+
 /*
  * Per-thread CET status
  */
@@ -17,8 +19,14 @@ struct cet_status {
 #ifdef CONFIG_X86_INTEL_CET
 int cet_setup_shstk(void);
 void cet_disable_free_shstk(struct task_struct *p);
+int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *=
new_ssp);
+void cet_restore_signal(struct sc_ext *sc);
+int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
+static inline void cet_restore_signal(struct sc_ext *sc) { return; }
+static inline int cet_setup_signal(bool ia32, unsigned long rstor,
+				   struct sc_ext *sc) { return -EINVAL; }
 #endif
=20
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/f=
pu/internal.h
index 42159f45bf9c..b569ac929ccc 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -476,6 +476,16 @@ static inline void copy_kernel_to_fpregs(union fpreg=
s_state *fpstate)
 	__copy_kernel_to_fpregs(fpstate, -1);
 }
=20
+#ifdef CONFIG_X86_INTEL_CET
+extern int save_cet_to_sigframe(int ia32, void __user *fp,
+				unsigned long restorer);
+#else
+static inline int save_cet_to_sigframe(int ia32, void __user *fp,
+				unsigned long restorer)
+{
+	return 0;
+}
+#endif
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, i=
nt size);
=20
 /*
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/=
special_insns.h
index 6d37b8fcfc77..1b9b2e79c353 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -222,6 +222,38 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
=20
+#ifdef CONFIG_X86_INTEL_CET
+#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
+static inline int write_user_shstk_32(unsigned long addr, unsigned int v=
al)
+{
+	asm_volatile_goto("1: wrussd %1, (%0)\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: "r" (addr), "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EPERM;
+}
+#else
+static inline int write_user_shstk_32(unsigned long addr, unsigned int v=
al)
+{
+	WARN_ONCE(1, "%s used but not supported.\n", __func__);
+	return -EFAULT;
+}
+#endif
+
+static inline int write_user_shstk_64(unsigned long addr, unsigned long =
val)
+{
+	asm_volatile_goto("1: wrussq %1, (%0)\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: "r" (addr), "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EPERM;
+}
+#endif /* CONFIG_X86_INTEL_CET */
+
 #define nop() asm volatile ("nop")
=20
=20
diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/ua=
pi/asm/sigcontext.h
index 844d60eb1882..cf2d55db3be4 100644
--- a/arch/x86/include/uapi/asm/sigcontext.h
+++ b/arch/x86/include/uapi/asm/sigcontext.h
@@ -196,6 +196,15 @@ struct _xstate {
 	/* New processor state extensions go here: */
 };
=20
+/*
+ * Located at the end of sigcontext->fpstate, aligned to 8.
+ */
+struct sc_ext {
+	unsigned long total_size;
+	unsigned long ssp;
+	unsigned long wait_endbr;
+};
+
 /*
  * The 32-bit signal frame:
  */
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d8196c8e792a..274fecdd9669 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -19,6 +19,8 @@
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
 #include <asm/cet.h>
+#include <asm/special_insns.h>
+#include <uapi/asm/sigcontext.h>
=20
 static void start_update_msrs(void)
 {
@@ -69,6 +71,80 @@ static unsigned long alloc_shstk(unsigned long size)
 	return addr;
 }
=20
+#define TOKEN_MODE_MASK	3UL
+#define TOKEN_MODE_64	1UL
+#define IS_TOKEN_64(token) ((token & TOKEN_MODE_MASK) =3D=3D TOKEN_MODE_=
64)
+#define IS_TOKEN_32(token) ((token & TOKEN_MODE_MASK) =3D=3D 0)
+
+/*
+ * Verify the restore token at the address of 'ssp' is
+ * valid and then set shadow stack pointer according to the
+ * token.
+ */
+int cet_verify_rstor_token(bool ia32, unsigned long ssp,
+			   unsigned long *new_ssp)
+{
+	unsigned long token;
+
+	*new_ssp =3D 0;
+
+	if (!IS_ALIGNED(ssp, 8))
+		return -EINVAL;
+
+	if (get_user(token, (unsigned long __user *)ssp))
+		return -EFAULT;
+
+	/* Is 64-bit mode flag correct? */
+	if (!ia32 && !IS_TOKEN_64(token))
+		return -EINVAL;
+	else if (ia32 && !IS_TOKEN_32(token))
+		return -EINVAL;
+
+	token &=3D ~TOKEN_MODE_MASK;
+
+	/*
+	 * Restore address properly aligned?
+	 */
+	if ((!ia32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
+		return -EINVAL;
+
+	/*
+	 * Token was placed properly?
+	 */
+	if ((ALIGN_DOWN(token, 8) - 8) !=3D ssp)
+		return -EINVAL;
+
+	*new_ssp =3D token;
+	return 0;
+}
+
+/*
+ * Create a restore token on the shadow stack.
+ * A token is always 8-byte and aligned to 8.
+ */
+static int create_rstor_token(bool ia32, unsigned long ssp,
+			      unsigned long *new_ssp)
+{
+	unsigned long addr;
+
+	*new_ssp =3D 0;
+
+	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
+		return -EINVAL;
+
+	addr =3D ALIGN_DOWN(ssp, 8) - 8;
+
+	/* Is the token for 64-bit? */
+	if (!ia32)
+		ssp |=3D TOKEN_MODE_64;
+
+	if (write_user_shstk_64(addr, ssp))
+		return -EFAULT;
+
+	*new_ssp =3D addr;
+	return 0;
+}
+
 int cet_setup_shstk(void)
 {
 	unsigned long addr, size;
@@ -133,3 +209,78 @@ void cet_disable_free_shstk(struct task_struct *tsk)
 	cet->shstk_base =3D 0;
 	cet->shstk_size =3D 0;
 }
+
+/*
+ * Called from __fpu__restore_sig() and XSAVES buffer is protected by
+ * set_thread_flag(TIF_NEED_FPU_LOAD) in the slow path.
+ */
+void cet_restore_signal(struct sc_ext *sc_ext)
+{
+	struct cet_user_state *cet_user_state;
+	struct cet_status *cet =3D &current->thread.cet;
+	u64 msr_val =3D 0;
+
+	cet_user_state =3D get_xsave_addr(&current->thread.fpu.state.xsave,
+					XFEATURE_CET_USER);
+	if (!cet_user_state)
+		return;
+
+	if (cet->shstk_size) {
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			cet_user_state->user_ssp =3D sc_ext->ssp;
+		else
+			wrmsrl(MSR_IA32_PL3_SSP, sc_ext->ssp);
+
+		msr_val |=3D MSR_IA32_CET_SHSTK_EN;
+	}
+
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		cet_user_state->user_cet =3D msr_val;
+	else
+		wrmsrl(MSR_IA32_U_CET, msr_val);
+
+	return;
+}
+
+/*
+ * Setup the shadow stack for the signal handler: first,
+ * create a restore token to keep track of the current ssp,
+ * and then the return address of the signal handler.
+ */
+int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext =
*sc_ext)
+{
+	struct cet_status *cet =3D &current->thread.cet;
+	unsigned long ssp =3D 0, new_ssp =3D 0;
+	int err;
+
+	if (cet->shstk_size) {
+		if (!rstor_addr)
+			return -EINVAL;
+
+		ssp =3D cet_get_shstk_addr();
+		err =3D create_rstor_token(ia32, ssp, &new_ssp);
+		if (err)
+			return err;
+
+		if (ia32) {
+			ssp =3D new_ssp - sizeof(u32);
+			err =3D write_user_shstk_32(ssp, (unsigned int)rstor_addr);
+		} else {
+			ssp =3D new_ssp - sizeof(u64);
+			err =3D write_user_shstk_64(ssp, rstor_addr);
+		}
+
+		if (err)
+			return err;
+
+		sc_ext->ssp =3D new_ssp;
+	}
+
+	if (ssp) {
+		start_update_msrs();
+		wrmsrl(MSR_IA32_PL3_SSP, ssp);
+		end_update_msrs();
+	}
+
+	return 0;
+}
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 4dad5afc938d..95ee76d08971 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -52,6 +52,73 @@ static inline int check_for_xstate(struct fxregs_state=
 __user *buf,
 	return 0;
 }
=20
+#ifdef CONFIG_X86_INTEL_CET
+int save_cet_to_sigframe(int ia32, void __user *fp, unsigned long restor=
er)
+{
+	int err =3D 0;
+
+	if (!current->thread.cet.shstk_size)
+		return 0;
+
+	if (fp) {
+		struct sc_ext ext =3D {0, 0, 0};
+
+		err =3D cet_setup_signal(ia32, restorer, &ext);
+		if (!err) {
+			void __user *p =3D fp;
+
+			ext.total_size =3D sizeof(ext);
+
+			if (ia32)
+				p +=3D sizeof(struct fregs_state);
+
+			p +=3D fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+			p =3D (void __user *)ALIGN((unsigned long)p, 8);
+
+			if (copy_to_user(p, &ext, sizeof(ext)))
+				return -EFAULT;
+		}
+	}
+
+	return err;
+}
+
+static int get_cet_from_sigframe(int ia32, void __user *fp, struct sc_ex=
t *ext)
+{
+	int err =3D 0;
+
+	memset(ext, 0, sizeof(*ext));
+
+	if (!current->thread.cet.shstk_size)
+		return 0;
+
+	if (fp) {
+		void __user *p =3D fp;
+
+		if (ia32)
+			p +=3D sizeof(struct fregs_state);
+
+		p +=3D fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+		p =3D (void __user *)ALIGN((unsigned long)p, 8);
+
+		if (copy_from_user(ext, p, sizeof(*ext)))
+			return -EFAULT;
+
+		if (ext->total_size !=3D sizeof(*ext))
+			return -EFAULT;
+
+		err =3D cet_verify_rstor_token(ia32, ext->ssp, &ext->ssp);
+	}
+
+	return err;
+}
+#else
+static int get_cet_from_sigframe(int ia32, void __user *fp, struct sc_ex=
t *ext)
+{
+	return 0;
+}
+#endif
+
 /*
  * Signal frame handlers.
  */
@@ -294,6 +361,7 @@ static int __fpu__restore_sig(void __user *buf, void =
__user *buf_fx, int size)
 	struct task_struct *tsk =3D current;
 	struct fpu *fpu =3D &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
+	struct sc_ext sc_ext;
 	u64 user_xfeatures =3D 0;
 	int fx_only =3D 0;
 	int ret =3D 0;
@@ -334,6 +402,10 @@ static int __fpu__restore_sig(void __user *buf, void=
 __user *buf_fx, int size)
 	if ((unsigned long)buf_fx % 64)
 		fx_only =3D 1;
=20
+	ret =3D get_cet_from_sigframe(ia32_fxstate, buf, &sc_ext);
+	if (ret)
+		return ret;
+
 	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
@@ -346,7 +418,10 @@ static int __fpu__restore_sig(void __user *buf, void=
 __user *buf_fx, int size)
 		pagefault_disable();
 		ret =3D copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
+
 		if (!ret) {
+			cet_restore_signal(&sc_ext);
+
 			/* Restore supervisor states */
 			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
 			    xfeatures_mask_supervisor())
@@ -405,6 +480,9 @@ static int __fpu__restore_sig(void __user *buf, void =
__user *buf_fx, int size)
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+
+		cet_restore_signal(&sc_ext);
+
 		/*
 		 * Restore previously saved supervisor xstates along with
 		 * copied-in user xstates.
@@ -473,12 +551,35 @@ int fpu__restore_sig(void __user *buf, int ia32_fra=
me)
 	return __fpu__restore_sig(buf, buf_fx, size);
 }
=20
+#ifdef CONFIG_X86_INTEL_CET
+static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
+{
+	struct cet_status *cet =3D &current->thread.cet;
+
+	/*
+	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
+	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
+	 */
+	if (cet->shstk_size)
+		sp -=3D (sizeof(struct sc_ext) + 8);
+
+	return sp;
+}
+#else
+static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
+{
+	return sp;
+}
+#endif
+
 unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
 	unsigned long frame_size =3D xstate_sigframe_size();
=20
+	sp =3D fpu__alloc_sigcontext_ext(sp);
+
 	*buf_fx =3D sp =3D round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
 		frame_size +=3D sizeof(struct fregs_state);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 0052bbe5dfd4..5ee1b2e51de3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -44,6 +44,7 @@
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/cet.h>
=20
 #ifdef CONFIG_X86_64
 /*
@@ -237,6 +238,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *=
regs, size_t frame_size,
 	unsigned long buf_fx =3D 0;
 	int onsigstack =3D on_sig_stack(sp);
 	int ret;
+#ifdef CONFIG_X86_64
+	void __user *restorer =3D NULL;
+#endif
=20
 	/* redzone */
 	if (IS_ENABLED(CONFIG_X86_64))
@@ -268,6 +272,12 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs =
*regs, size_t frame_size,
 	if (onsigstack && !likely(on_sig_stack(sp)))
 		return (void __user *)-1L;
=20
+#ifdef CONFIG_X86_64
+	if (ka->sa.sa_flags & SA_RESTORER)
+		restorer =3D ka->sa.sa_restorer;
+	ret =3D save_cet_to_sigframe(0, *fpstate, (unsigned long)restorer);
+#endif
+
 	/* save i387 and extended state */
 	ret =3D copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_=
size);
 	if (ret < 0)
--=20
2.21.0
