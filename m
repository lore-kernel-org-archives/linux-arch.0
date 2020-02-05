Return-Path: <owner-linux-mm@kvack.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 19/27] x86/cet/shstk: Handle signals for Shadow Stack
Date: Wed,  5 Feb 2020 10:19:27 -0800
Message-ID: <20200205181935.3712-20-yu-cheng.yu@intel.com>
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205181927.c3LE27TsCeUbgIRMC1N9EcQClq-yW_Y2v6XmJ-BbKz0@z>

To deliver a signal, create a Shadow Stack (SHSTK) restore token and put
the token and the signal restorer address on the SHSTK.  For sigreturn,
verify the token and restore the SHSTK pointer.

Introduce a signal context extension struct 'sc_ext', which is used to sa=
ve
SHSTK restore token address and WAIT_ENDBR status.  WAIT_ENDBR will be
introduced later in the Indirect Branch Tracking (IBT) series, but add th=
at
into sc_ext now to keep the struct stable in case the IBT series is appli=
ed
later.

v9:
- Update CET MSR access according to XSAVES supervisor state changes.
- Add 'wait_endbr' to struct 'sc_ext'.
- Update and simplify signal frame allocation, setup, and restoration.
- Update commit log text.

v2:
- Move CET status from sigcontext to a separate struct sc_ext, which is
  located above the fpstate on the signal frame.
- Add a restore token for sigreturn address.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/ia32/ia32_signal.c            |  17 +++
 arch/x86/include/asm/cet.h             |   7 ++
 arch/x86/include/asm/fpu/internal.h    |   2 +
 arch/x86/include/uapi/asm/sigcontext.h |   9 ++
 arch/x86/kernel/cet.c                  | 153 +++++++++++++++++++++++++
 arch/x86/kernel/fpu/signal.c           |  89 ++++++++++++++
 arch/x86/kernel/signal.c               |  10 ++
 7 files changed, 287 insertions(+)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 30416d7f19d4..c0bb350a3d2d 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -35,6 +35,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/cet.h>
=20
 /*
  * Do a signal return; undo the signal stack.
@@ -223,6 +224,7 @@ static void __user *get_sigframe(struct ksignal *ksig=
, struct pt_regs *regs,
 				 void __user **fpstate)
 {
 	unsigned long sp, fx_aligned, math_size;
+	void __user *restorer =3D NULL;
=20
 	/* Default to using normal stack */
 	sp =3D regs->sp;
@@ -236,8 +238,23 @@ static void __user *get_sigframe(struct ksignal *ksi=
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
+	if (save_cet_to_sigframe(*fpstate, (unsigned long)restorer, 1))
+		return (void __user *) -1L;
+
 	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
 				     math_size) < 0)
 		return (void __user *) -1L;
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index c44c991ca91f..409d4f91a0dc 100644
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
@@ -18,8 +20,13 @@ struct cet_status {
 #ifdef CONFIG_X86_INTEL_CET
 int cet_setup_shstk(void);
 void cet_disable_free_shstk(struct task_struct *p);
+int cet_restore_signal(bool ia32, struct sc_ext *sc);
+int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
+static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { ret=
urn -EINVAL; }
+static inline int cet_setup_signal(bool ia32, unsigned long rstor,
+				   struct sc_ext *sc) { return -EINVAL; }
 #endif
=20
 #define cpu_x86_cet_enabled() \
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/f=
pu/internal.h
index 42159f45bf9c..241521c0ed02 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -476,6 +476,8 @@ static inline void copy_kernel_to_fpregs(union fpregs=
_state *fpstate)
 	__copy_kernel_to_fpregs(fpstate, -1);
 }
=20
+extern int save_cet_to_sigframe(void __user *fp, unsigned long restorer,
+				int is_ia32);
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, i=
nt size);
=20
 /*
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
index b4c7d88e9a8f..cba5c7656aab 100644
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
+static int verify_rstor_token(bool ia32, unsigned long ssp,
+			      unsigned long *new_ssp)
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
@@ -119,3 +195,80 @@ void cet_disable_free_shstk(struct task_struct *tsk)
 	cet->shstk_size =3D 0;
 	cet->shstk_enabled =3D 0;
 }
+
+/*
+ * Called from __fpu__restore_sig() and XSAVES buffer is protected by
+ * set_thread_flag(TIF_NEED_FPU_LOAD).
+ */
+int cet_restore_signal(bool ia32, struct sc_ext *sc_ext)
+{
+	struct cet_user_state *cet_user_state;
+	struct cet_status *cet =3D &current->thread.cet;
+	unsigned long new_ssp =3D 0;
+	u64 msr_val =3D 0;
+	int err;
+
+	if (!cet->shstk_enabled)
+		return 0;
+
+	cet_user_state =3D get_xsave_addr(&current->thread.fpu.state.xsave,
+					XFEATURE_CET_USER);
+	if (!cet_user_state)
+		return -1;
+
+	if (cet->shstk_enabled) {
+		err =3D verify_rstor_token(ia32, sc_ext->ssp, &new_ssp);
+		if (err)
+			return err;
+
+		cet_user_state->user_ssp =3D new_ssp;
+		msr_val |=3D MSR_IA32_CET_SHSTK_EN;
+	}
+
+	cet_user_state->user_cet =3D msr_val;
+	return 0;
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
+	if (!cet->shstk_enabled)
+		return 0;
+
+	if (cet->shstk_enabled) {
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
+	start_update_msrs();
+	if (cet->shstk_enabled)
+		wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	end_update_msrs();
+
+	return 0;
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0d3e06a772b0..875cc0fadce3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -52,6 +52,69 @@ static inline int check_for_xstate(struct fxregs_state=
 __user *buf,
 	return 0;
 }
=20
+int save_cet_to_sigframe(void __user *fp, unsigned long restorer, int is=
_ia32)
+{
+	int err =3D 0;
+
+#ifdef CONFIG_X86_INTEL_CET
+	if (!current->thread.cet.shstk_enabled)
+		return 0;
+
+	if (fp) {
+		struct sc_ext ext =3D {0, 0, 0};
+
+		err =3D cet_setup_signal(is_ia32, restorer, &ext);
+		if (!err) {
+			void __user *p =3D fp;
+
+			ext.total_size =3D sizeof(ext);
+
+			if (is_ia32)
+				p +=3D sizeof(struct fregs_state);
+
+			p +=3D fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+			p =3D (void __user *)ALIGN((unsigned long)p, 8);
+
+			if (copy_to_user(p, &ext, sizeof(ext)))
+				return -EFAULT;
+		}
+	}
+#endif
+
+	return err;
+}
+
+static int restore_cet_from_sigframe(int is_ia32, void __user *fp)
+{
+	int err =3D 0;
+
+#ifdef CONFIG_X86_INTEL_CET
+	if (!current->thread.cet.shstk_enabled)
+		return 0;
+
+	if (fp) {
+		struct sc_ext ext =3D {0, 0, 0};
+		void __user *p =3D fp;
+
+		if (is_ia32)
+			p +=3D sizeof(struct fregs_state);
+
+		p +=3D fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+		p =3D (void __user *)ALIGN((unsigned long)p, 8);
+
+		if (copy_from_user(&ext, p, sizeof(ext)))
+			return -EFAULT;
+
+		if (ext.total_size !=3D sizeof(ext))
+			return -EFAULT;
+
+		err =3D cet_restore_signal(is_ia32, &ext);
+	}
+#endif
+
+	return err;
+}
+
 /*
  * Signal frame handlers.
  */
@@ -367,6 +430,10 @@ static int __fpu__restore_sig(void __user *buf, void=
 __user *buf_fx, int size)
 		pagefault_disable();
 		ret =3D copy_user_to_fpregs_zeroing(buf_fx, xfeatures_user, fx_only);
 		pagefault_enable();
+
+		if (!ret)
+			ret =3D restore_cet_from_sigframe(0, buf);
+
 		if (!ret) {
 			if (xfeatures_mask_supervisor())
 				copy_kernel_to_xregs(&fpu->state.xsave,
@@ -397,6 +464,10 @@ static int __fpu__restore_sig(void __user *buf, void=
 __user *buf_fx, int size)
 		sanitize_restored_user_xstate(&fpu->state, envp, xfeatures_user,
 					      fx_only);
=20
+		ret =3D restore_cet_from_sigframe((int)ia32_fxstate, buf);
+		if (ret)
+			goto err_out;
+
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
@@ -468,12 +539,30 @@ int fpu__restore_sig(void __user *buf, int ia32_fra=
me)
 	return __fpu__restore_sig(buf, buf_fx, size);
 }
=20
+static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
+{
+	/*
+	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
+	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
+	 */
+	if (cpu_x86_cet_enabled()) {
+		struct cet_status *cet =3D &current->thread.cet;
+
+		if (cet->shstk_enabled)
+			sp -=3D (sizeof(struct sc_ext) + 8);
+	}
+
+	return sp;
+}
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
index ce9421ec285f..b26f5084a8a1 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -46,6 +46,7 @@
=20
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/cet.h>
=20
 #define COPY(x)			do {			\
 	get_user_ex(regs->x, &sc->x);			\
@@ -246,6 +247,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *=
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
@@ -277,6 +281,12 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs =
*regs, size_t frame_size,
 	if (onsigstack && !likely(on_sig_stack(sp)))
 		return (void __user *)-1L;
=20
+#ifdef CONFIG_X86_64
+	if (ka->sa.sa_flags & SA_RESTORER)
+		restorer =3D ka->sa.sa_restorer;
+	ret =3D save_cet_to_sigframe(*fpstate, (unsigned long)restorer, 0);
+#endif
+
 	/* save i387 and extended state */
 	ret =3D copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_=
size);
 	if (ret < 0)
--=20
2.21.0
