From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v4 05/24] arm64: compat: Alloc separate pages for vectors and
 sigpage
Date: Tue, 15 Jan 2019 13:55:20 +0000
Message-ID: <20190115135539.24762-6-vincenzo.frascino@arm.com>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190115135539.24762-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

In the current implementation AArch32 installs a special page called
"[vectors]" that contains sigreturn trampolines and kuser helpers,
and this is done at fixed address specified by the kuser helpers ABI.

Having sigreturn trampolines and kuser helpers in the same page, makes
difficult to maintain compatibility with arm because it makes not
possible to disable kuser helpers.

This patch addresses the problem creating separate pages for vectors and
sigpage in a similar fashion to what happens today on arm.

This patch changes as well the meaning of mm->context.vdso for AArch32
compat since it now points to sigpage and not to vectors anymore in
order to make simpler the implementation of the signal handling (the
address of sigpage is randomized).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/elf.h       |   6 +-
 arch/arm64/include/asm/processor.h |   4 +-
 arch/arm64/include/asm/signal32.h  |   2 -
 arch/arm64/kernel/signal32.c       |   5 +-
 arch/arm64/kernel/vdso.c           | 112 ++++++++++++++++++++++-------
 5 files changed, 93 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6adc1a90e7e6..355d120b78cb 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -214,10 +214,10 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 	set_thread_flag(TIF_32BIT);					\
  })
 #define COMPAT_ARCH_DLINFO
-extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
-				      int uses_interp);
+extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
+					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
+					aarch32_setup_additional_pages
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f1a7ab18faf3..5e8fb35fad33 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -78,9 +78,9 @@
 #endif /* CONFIG_ARM64_FORCE_52BIT */
 
 #ifdef CONFIG_COMPAT
-#define AARCH32_VECTORS_BASE	0xffff0000
+#define AARCH32_KUSER_BASE	0xffff0000
 #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
-				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
+				AARCH32_KUSER_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
 #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 81abea0b7650..58e288aaf0ba 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -20,8 +20,6 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
-#define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
-
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index cb7800acd19f..3846a1b710b5 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -379,6 +379,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	compat_ulong_t retcode;
 	compat_ulong_t spsr = regs->pstate & ~(PSR_f | PSR_AA32_E_BIT);
 	int thumb;
+	void *sigreturn_base;
 
 	/* Check if the handler is written for ARM or Thumb */
 	thumb = handler & 1;
@@ -399,12 +400,12 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	} else {
 		/* Set up sigreturn pointer */
 		unsigned int idx = thumb << 1;
+		sigreturn_base = current->mm->context.vdso;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
-		retcode = AARCH32_VECTORS_BASE +
-			  AARCH32_KERN_SIGRET_CODE_OFFSET +
+		retcode = ptr_to_compat(sigreturn_base) +
 			  (idx << 2) + thumb;
 	}
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index c91039b94f28..5df7aeef324a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -1,5 +1,7 @@
 /*
- * VDSO implementation for AArch64 and vector page setup for AArch32.
+ * VDSO implementation for AArch64 and for AArch32:
+ * AArch64: vDSO implementation contains pages setup and data page update.
+ * AArch32: vDSO implementation contains sigreturn and kuser pages setup.
  *
  * Copyright (C) 2012 ARM Limited
  *
@@ -54,61 +56,117 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
-static struct page *vectors_page[1] __ro_after_init;
+/*
+ * aarch32_vdso_pages:
+ * 0 - kuser helpers
+ * 1 - sigreturn code
+ */
+static struct page *aarch32_vdso_pages[2] __ro_after_init;
+static const struct vm_special_mapping aarch32_vdso_spec[2] = {
+	{
+		/* Must be named [vectors] for compatibility with arm. */
+		.name	= "[vectors]",
+		.pages	= &aarch32_vdso_pages[0],
+	},
+	{
+		/* Must be named [sigpage] for compatibility with arm. */
+		.name	= "[sigpage]",
+		.pages	= &aarch32_vdso_pages[1],
+	},
+};
 
-static int __init alloc_vectors_page(void)
+static int __init aarch32_alloc_vdso_pages(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
 	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
-	unsigned long vpage;
+	unsigned long vdso_pages[2];
 
-	vpage = get_zeroed_page(GFP_ATOMIC);
+	vdso_pages[0] = get_zeroed_page(GFP_ATOMIC);
+	if (!vdso_pages[0])
+		return -ENOMEM;
 
-	if (!vpage)
+	vdso_pages[1] = get_zeroed_page(GFP_ATOMIC);
+	if (!vdso_pages[1])
 		return -ENOMEM;
 
 	/* kuser helpers */
-	memcpy((void *)vpage + 0x1000 - kuser_sz, __kuser_helper_start,
-		kuser_sz);
+	memcpy((void *)(vdso_pages[0] + 0x1000 - kuser_sz),
+	       __kuser_helper_start,
+	       kuser_sz);
 
 	/* sigreturn code */
-	memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
-               __aarch32_sigret_code_start, sigret_sz);
+	memcpy((void *)vdso_pages[1],
+	       __aarch32_sigret_code_start,
+	       sigret_sz);
 
-	flush_icache_range(vpage, vpage + PAGE_SIZE);
-	vectors_page[0] = virt_to_page(vpage);
+	flush_icache_range(vdso_pages[0], vdso_pages[0] + PAGE_SIZE);
+	flush_icache_range(vdso_pages[1], vdso_pages[1] + PAGE_SIZE);
+
+	aarch32_vdso_pages[0] = virt_to_page(vdso_pages[0]);
+	aarch32_vdso_pages[1] = virt_to_page(vdso_pages[1]);
 
 	return 0;
 }
-arch_initcall(alloc_vectors_page);
+arch_initcall(aarch32_alloc_vdso_pages);
 
-int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr = AARCH32_VECTORS_BASE;
-	static const struct vm_special_mapping spec = {
-		.name	= "[vectors]",
-		.pages	= vectors_page,
+	void *ret;
+
+	/* The kuser helpers must be mapped at the ABI-defined high address */
+	ret = _install_special_mapping(mm, AARCH32_KUSER_BASE, PAGE_SIZE,
+				       VM_READ | VM_EXEC |
+				       VM_MAYREAD | VM_MAYEXEC,
+				       &aarch32_vdso_spec[0]);
+
+	return PTR_ERR_OR_ZERO(ret);
+}
 
-	};
+static int aarch32_sigreturn_setup(struct mm_struct *mm)
+{
+	unsigned long addr;
 	void *ret;
 
-	if (down_write_killable(&mm->mmap_sem))
-		return -EINTR;
-	current->mm->context.vdso = (void *)addr;
+	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = ERR_PTR(addr);
+		goto out;
+	}
 
-	/* Map vectors page at the high address. */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
-				       &spec);
+				       VM_READ | VM_EXEC | VM_MAYREAD |
+				       VM_MAYWRITE | VM_MAYEXEC,
+				       &aarch32_vdso_spec[1]);
+	if (IS_ERR(ret))
+		goto out;
 
-	up_write(&mm->mmap_sem);
+	mm->context.vdso = (void *)addr;
 
+out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+
+int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	ret = aarch32_kuser_helpers_setup(mm);
+	if (ret)
+		goto out;
+
+	ret = aarch32_sigreturn_setup(mm);
+
+out:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
 #endif /* CONFIG_COMPAT */
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
-- 
2.20.1
