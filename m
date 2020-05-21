Return-Path: <SRS0=Ax4L=7D=kvack.org=owner-linux-mm@kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH 1/5] x86/cet/shstk: Modify ARCH_X86_CET_ALLOC_SHSTK for 32-bit address range
Date: Thu, 21 May 2020 14:17:16 -0700
Message-ID: <20200521211720.20236-2-yu-cheng.yu@intel.com>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200521211716.Bj90r9vvRMlWoI07yGfKWyY0VqVZvDqs7w9Hf25ZbiM@z>

Sometimes a 64-bit task might need to have a shadow stack allocated from
within 32-bit address range.  One example is selftests/x86/sigreturn.

Currently arch_prctl(ARCH_X86_CET_ALLOC_SHSTK) takes a input parameter fo=
r
the desired shadow stack size.  Modify it and use bit[0] of the parameter
to indicate the desire to allocate from 32-bit address range.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h        |  2 +-
 arch/x86/include/uapi/asm/prctl.h |  2 ++
 arch/x86/kernel/cet.c             | 19 ++++++++++++-------
 arch/x86/kernel/cet_prctl.c       |  6 +++++-
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index f163c805a559..534b02785a39 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -22,7 +22,7 @@ struct cet_status {
 int prctl_cet(int option, u64 arg2);
 int cet_setup_shstk(void);
 int cet_setup_thread_shstk(struct task_struct *p);
-int cet_alloc_shstk(unsigned long *arg);
+int cet_alloc_shstk(unsigned long *arg, int map_32bit);
 void cet_disable_free_shstk(struct task_struct *p);
 int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *=
new_ssp);
 void cet_restore_signal(struct sc_ext *sc);
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/as=
m/prctl.h
index d962f0ec9ccf..e254c6a21475 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -19,4 +19,6 @@
 #define ARCH_X86_CET_LOCK		0x3003
 #define ARCH_X86_CET_ALLOC_SHSTK	0x3004
=20
+#define ARCH_X86_CET_ALLOC_SHSTK_32BIT	0x1UL
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 92b8730c0b08..d6f93e1864b2 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -57,14 +57,19 @@ static unsigned long cet_get_shstk_addr(void)
 	return ssp;
 }
=20
-static unsigned long alloc_shstk(unsigned long size)
+static unsigned long alloc_shstk(unsigned long size, int map_32bit)
 {
 	struct mm_struct *mm =3D current->mm;
 	unsigned long addr, populate;
+	unsigned long map_flags;
+
+	map_flags =3D MAP_ANONYMOUS | MAP_PRIVATE;
+	if (map_32bit)
+		map_flags |=3D MAP_32BIT;
=20
 	down_write(&mm->mmap_sem);
-	addr =3D do_mmap(NULL, 0, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,
-		       VM_SHSTK, 0, &populate, NULL);
+	addr =3D do_mmap(NULL, 0, size, PROT_READ, map_flags, VM_SHSTK, 0,
+		       &populate, NULL);
 	up_write(&mm->mmap_sem);
=20
 	if (populate)
@@ -147,14 +152,14 @@ static int create_rstor_token(bool ia32, unsigned l=
ong ssp,
 	return 0;
 }
=20
-int cet_alloc_shstk(unsigned long *arg)
+int cet_alloc_shstk(unsigned long *arg, int map_32bit)
 {
 	unsigned long len =3D *arg;
 	unsigned long addr;
 	unsigned long token;
 	unsigned long ssp;
=20
-	addr =3D alloc_shstk(round_up(len, PAGE_SIZE));
+	addr =3D alloc_shstk(round_up(len, PAGE_SIZE), map_32bit);
=20
 	if (IS_ERR((void *)addr))
 		return PTR_ERR((void *)addr);
@@ -185,7 +190,7 @@ int cet_setup_shstk(void)
 		return -EOPNOTSUPP;
=20
 	size =3D round_up(min(rlimit(RLIMIT_STACK), 1UL << 32), PAGE_SIZE);
-	addr =3D alloc_shstk(size);
+	addr =3D alloc_shstk(size, 0);
=20
 	if (IS_ERR((void *)addr))
 		return PTR_ERR((void *)addr);
@@ -226,7 +231,7 @@ int cet_setup_thread_shstk(struct task_struct *tsk)
 	if (in_compat_syscall())
 		size /=3D 4;
 	size =3D round_up(size, PAGE_SIZE);
-	addr =3D alloc_shstk(size);
+	addr =3D alloc_shstk(size, 0);
=20
 	if (IS_ERR((void *)addr)) {
 		cet->shstk_base =3D 0;
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index a8e68fefd524..364ed2420202 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -35,12 +35,16 @@ static int handle_alloc_shstk(u64 arg2)
 	unsigned long arg;
 	unsigned long addr =3D 0;
 	unsigned long size =3D 0;
+	int map_32bit;
=20
 	if (get_user(arg, (unsigned long __user *)arg2))
 		return -EFAULT;
=20
+	map_32bit =3D (arg & ARCH_X86_CET_ALLOC_SHSTK_32BIT) ? 1 : 0;
+	arg &=3D ~(ARCH_X86_CET_ALLOC_SHSTK_32BIT);
+
 	size =3D arg;
-	err =3D cet_alloc_shstk(&arg);
+	err =3D cet_alloc_shstk(&arg, map_32bit);
 	if (err)
 		return err;
=20
--=20
2.21.0
