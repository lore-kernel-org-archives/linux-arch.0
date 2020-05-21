From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 1/5] x86/cet/shstk: Modify ARCH_X86_CET_ALLOC_SHSTK for 32-bit address range
Date: Thu, 21 May 2020 14:17:16 -0700
Message-ID: <20200521211720.20236-2-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Sometimes a 64-bit task might need to have a shadow stack allocated from
within 32-bit address range.  One example is selftests/x86/sigreturn.

Currently arch_prctl(ARCH_X86_CET_ALLOC_SHSTK) takes a input parameter for
the desired shadow stack size.  Modify it and use bit[0] of the parameter
to indicate the desire to allocate from 32-bit address range.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
 int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp);
 void cet_restore_signal(struct sc_ext *sc);
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index d962f0ec9ccf..e254c6a21475 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -19,4 +19,6 @@
 #define ARCH_X86_CET_LOCK		0x3003
 #define ARCH_X86_CET_ALLOC_SHSTK	0x3004
 
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
 
-static unsigned long alloc_shstk(unsigned long size)
+static unsigned long alloc_shstk(unsigned long size, int map_32bit)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr, populate;
+	unsigned long map_flags;
+
+	map_flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	if (map_32bit)
+		map_flags |= MAP_32BIT;
 
 	down_write(&mm->mmap_sem);
-	addr = do_mmap(NULL, 0, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,
-		       VM_SHSTK, 0, &populate, NULL);
+	addr = do_mmap(NULL, 0, size, PROT_READ, map_flags, VM_SHSTK, 0,
+		       &populate, NULL);
 	up_write(&mm->mmap_sem);
 
 	if (populate)
@@ -147,14 +152,14 @@ static int create_rstor_token(bool ia32, unsigned long ssp,
 	return 0;
 }
 
-int cet_alloc_shstk(unsigned long *arg)
+int cet_alloc_shstk(unsigned long *arg, int map_32bit)
 {
 	unsigned long len = *arg;
 	unsigned long addr;
 	unsigned long token;
 	unsigned long ssp;
 
-	addr = alloc_shstk(round_up(len, PAGE_SIZE));
+	addr = alloc_shstk(round_up(len, PAGE_SIZE), map_32bit);
 
 	if (IS_ERR((void *)addr))
 		return PTR_ERR((void *)addr);
@@ -185,7 +190,7 @@ int cet_setup_shstk(void)
 		return -EOPNOTSUPP;
 
 	size = round_up(min(rlimit(RLIMIT_STACK), 1UL << 32), PAGE_SIZE);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(size, 0);
 
 	if (IS_ERR((void *)addr))
 		return PTR_ERR((void *)addr);
@@ -226,7 +231,7 @@ int cet_setup_thread_shstk(struct task_struct *tsk)
 	if (in_compat_syscall())
 		size /= 4;
 	size = round_up(size, PAGE_SIZE);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(size, 0);
 
 	if (IS_ERR((void *)addr)) {
 		cet->shstk_base = 0;
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index a8e68fefd524..364ed2420202 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -35,12 +35,16 @@ static int handle_alloc_shstk(u64 arg2)
 	unsigned long arg;
 	unsigned long addr = 0;
 	unsigned long size = 0;
+	int map_32bit;
 
 	if (get_user(arg, (unsigned long __user *)arg2))
 		return -EFAULT;
 
+	map_32bit = (arg & ARCH_X86_CET_ALLOC_SHSTK_32BIT) ? 1 : 0;
+	arg &= ~(ARCH_X86_CET_ALLOC_SHSTK_32BIT);
+
 	size = arg;
-	err = cet_alloc_shstk(&arg);
+	err = cet_alloc_shstk(&arg, map_32bit);
 	if (err)
 		return err;
 
-- 
2.21.0
