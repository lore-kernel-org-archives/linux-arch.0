From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] remove ibcs2/PER_SVR4 from SET_PERSONALITY
Date: Wed, 15 Oct 2008 14:05:52 +0200
Message-ID: <1224072352.16990.18.camel@localhost>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate8.de.ibm.com ([195.212.29.157]:39656 "EHLO
	mtagate8.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYJOMId (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Oct 2008 08:08:33 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9FC7oAY227106
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2008 12:07:50 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m9FC7oxc3014906
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2008 14:07:50 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m9FC7nZj008557
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2008 14:07:49 +0200
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org

Greetings,
this is the ibcs2/PER_SVR4 removal patch against today git tree. Nobody
complained so I guess it is ready for prime time. The question I have is
by which path should it go upstream? I can certainly create a branch on
git390 for it but that would be rather unusual since normally only s390
related patches go over that repository. Andrew, can you take care of
it ?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---
Subject: [PATCH] remove unused ibcs2/PER_SVR4 in SET_PERSONALITY

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The SET_PERSONALITY macro is always called with a second argument of 0.
Remove the ibcs argument and the various tests to set the PER_SVR4
personality.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/alpha/include/asm/elf.h      |    4 ++--
 arch/avr32/include/asm/elf.h      |    2 +-
 arch/blackfin/include/asm/elf.h   |    2 +-
 arch/h8300/include/asm/elf.h      |    2 +-
 arch/ia64/ia32/binfmt_elf32.c     |    2 +-
 arch/ia64/ia32/ia32priv.h         |    4 ++--
 arch/ia64/include/asm/elf.h       |    2 +-
 arch/m68knommu/include/asm/elf.h  |    2 +-
 arch/mips/include/asm/elf.h       |   10 +++-------
 arch/parisc/kernel/binfmt_elf32.c |    2 +-
 arch/powerpc/include/asm/elf.h    |    4 ++--
 arch/s390/include/asm/elf.h       |    8 +++-----
 arch/sh/include/asm/elf.h         |    2 +-
 arch/sparc/include/asm/elf_32.h   |    2 +-
 arch/sparc/include/asm/elf_64.h   |    6 ++----
 fs/binfmt_elf.c                   |    6 +++---
 include/asm-cris/elf.h            |    2 +-
 include/asm-frv/elf.h             |    2 +-
 include/asm-m32r/elf.h            |    2 +-
 include/asm-m68k/elf.h            |    2 +-
 include/asm-mn10300/elf.h         |    2 +-
 include/asm-parisc/elf.h          |    2 +-
 include/asm-um/elf-i386.h         |    2 +-
 include/asm-um/elf-ppc.h          |    2 +-
 include/asm-um/elf-x86_64.h       |    2 +-
 include/asm-x86/elf.h             |    4 ++--
 include/asm-xtensa/elf.h          |    2 +-
 27 files changed, 38 insertions(+), 46 deletions(-)

diff -urpN linux-2.6/arch/alpha/include/asm/elf.h linux-2.6-patched/arch/alpha/include/asm/elf.h
--- linux-2.6/arch/alpha/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/alpha/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -144,9 +144,9 @@ extern int dump_elf_task_fp(elf_fpreg_t 
 	: amask (AMASK_CIX) ? "ev6" : "ev67");	\
 })
 
-#define SET_PERSONALITY(EX, IBCS2)				\
+#define SET_PERSONALITY(EX)					\
 	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
-	   ? PER_LINUX_32BIT : (IBCS2) ? PER_SVR4 : PER_LINUX)
+	   ? PER_LINUX_32BIT : PER_LINUX)
 
 extern int alpha_l1i_cacheshape;
 extern int alpha_l1d_cacheshape;
diff -urpN linux-2.6/arch/avr32/include/asm/elf.h linux-2.6-patched/arch/avr32/include/asm/elf.h
--- linux-2.6/arch/avr32/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/avr32/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -103,6 +103,6 @@ typedef struct user_fpu_struct elf_fpreg
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX_32BIT)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX_32BIT)
 
 #endif /* __ASM_AVR32_ELF_H */
diff -urpN linux-2.6/arch/blackfin/include/asm/elf.h linux-2.6-patched/arch/blackfin/include/asm/elf.h
--- linux-2.6/arch/blackfin/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/blackfin/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -122,6 +122,6 @@ do {											\
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif
diff -urpN linux-2.6/arch/h8300/include/asm/elf.h linux-2.6-patched/arch/h8300/include/asm/elf.h
--- linux-2.6/arch/h8300/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/h8300/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -55,7 +55,7 @@ typedef unsigned long elf_fpregset_t;
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #define R_H8_NONE       0
 #define R_H8_DIR32      1
diff -urpN linux-2.6/arch/ia64/ia32/binfmt_elf32.c linux-2.6-patched/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.6/arch/ia64/ia32/binfmt_elf32.c	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/ia64/ia32/binfmt_elf32.c	2008-10-15 12:51:33.000000000 +0200
@@ -41,7 +41,7 @@ randomize_stack_top(unsigned long stack_
 #define elf_map				elf32_map
 
 #undef SET_PERSONALITY
-#define SET_PERSONALITY(ex, ibcs2)	elf32_set_personality()
+#define SET_PERSONALITY(ex)	elf32_set_personality()
 
 #define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
 
diff -urpN linux-2.6/arch/ia64/ia32/ia32priv.h linux-2.6-patched/arch/ia64/ia32/ia32priv.h
--- linux-2.6/arch/ia64/ia32/ia32priv.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/ia64/ia32/ia32priv.h	2008-10-15 12:51:33.000000000 +0200
@@ -332,8 +332,8 @@ void ia64_elf32_init(struct pt_regs *reg
 #define ELF_PLATFORM	NULL
 
 #ifdef __KERNEL__
-# define SET_PERSONALITY(EX,IBCS2)				\
-	(current->personality = (IBCS2) ? PER_SVR4 : PER_LINUX)
+# define SET_PERSONALITY(EX)				\
+	(current->personality = PER_LINUX)
 #endif
 
 #define IA32_EFLAG	0x200
diff -urpN linux-2.6/arch/ia64/include/asm/elf.h linux-2.6-patched/arch/ia64/include/asm/elf.h
--- linux-2.6/arch/ia64/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/ia64/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -202,7 +202,7 @@ extern void ia64_elf_core_copy_regs (str
    relevant until we have real hardware to play with... */
 #define ELF_PLATFORM	NULL
 
-#define SET_PERSONALITY(ex, ibcs2)	set_personality(PER_LINUX)
+#define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
 #define elf_read_implies_exec(ex, executable_stack)					\
 	((executable_stack!=EXSTACK_DISABLE_X) && ((ex).e_flags & EF_IA_64_LINUX_EXECUTABLE_STACK) != 0)
 
diff -urpN linux-2.6/arch/m68knommu/include/asm/elf.h linux-2.6-patched/arch/m68knommu/include/asm/elf.h
--- linux-2.6/arch/m68knommu/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/m68knommu/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -105,6 +105,6 @@ typedef struct user_m68kfp_struct elf_fp
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif
diff -urpN linux-2.6/arch/mips/include/asm/elf.h linux-2.6-patched/arch/mips/include/asm/elf.h
--- linux-2.6/arch/mips/include/asm/elf.h	2008-10-15 12:51:06.000000000 +0200
+++ linux-2.6-patched/arch/mips/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -247,10 +247,8 @@ extern struct mips_abi mips_abi_n32;
 
 #ifdef CONFIG_32BIT
 
-#define SET_PERSONALITY(ex, ibcs2)					\
+#define SET_PERSONALITY(ex)						\
 do {									\
-	if (ibcs2)							\
-		set_personality(PER_SVR4);				\
 	set_personality(PER_LINUX);					\
 									\
 	current->thread.abi = &mips_abi;				\
@@ -296,7 +294,7 @@ do {									\
 #define __SET_PERSONALITY32(ex)	do { } while (0)
 #endif
 
-#define SET_PERSONALITY(ex, ibcs2)					\
+#define SET_PERSONALITY(ex)						\
 do {									\
 	clear_thread_flag(TIF_32BIT_REGS);				\
 	clear_thread_flag(TIF_32BIT_ADDR);				\
@@ -306,9 +304,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	if (ibcs2)							\
-		set_personality(PER_SVR4);				\
-	else if (current->personality != PER_LINUX32)			\
+	if (current->personality != PER_LINUX32)			\
 		set_personality(PER_LINUX);				\
 } while (0)
 
diff -urpN linux-2.6/arch/parisc/kernel/binfmt_elf32.c linux-2.6-patched/arch/parisc/kernel/binfmt_elf32.c
--- linux-2.6/arch/parisc/kernel/binfmt_elf32.c	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/parisc/kernel/binfmt_elf32.c	2008-10-15 12:51:33.000000000 +0200
@@ -85,7 +85,7 @@ struct elf_prpsinfo32
  * could set a processor dependent flag in the thread_struct.
  */
 
-#define SET_PERSONALITY(ex, ibcs2) \
+#define SET_PERSONALITY(ex) \
 	set_thread_flag(TIF_32BIT); \
 	current->thread.map_base = DEFAULT_MAP_BASE32; \
 	current->thread.task_size = DEFAULT_TASK_SIZE32 \
diff -urpN linux-2.6/arch/powerpc/include/asm/elf.h linux-2.6-patched/arch/powerpc/include/asm/elf.h
--- linux-2.6/arch/powerpc/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/powerpc/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -232,7 +232,7 @@ typedef elf_vrregset_t elf_fpxregset_t;
 #endif /* __powerpc64__ */
 
 #ifdef __powerpc64__
-# define SET_PERSONALITY(ex, ibcs2)				\
+# define SET_PERSONALITY(ex)					\
 do {								\
 	unsigned long new_flags = 0;				\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
@@ -256,7 +256,7 @@ do {								\
 # define elf_read_implies_exec(ex, exec_stk) (test_thread_flag(TIF_32BIT) ? \
 		(exec_stk != EXSTACK_DISABLE_X) : 0)
 #else 
-# define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+# define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 #endif /* __powerpc64__ */
 
 extern int dcache_bsize;
diff -urpN linux-2.6/arch/s390/include/asm/elf.h linux-2.6-patched/arch/s390/include/asm/elf.h
--- linux-2.6/arch/s390/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/s390/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -166,13 +166,11 @@ extern char elf_platform[];
 #define ELF_PLATFORM (elf_platform)
 
 #ifndef __s390x__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 #else /* __s390x__ */
-#define SET_PERSONALITY(ex, ibcs2)			\
+#define SET_PERSONALITY(ex)				\
 do {							\
-	if (ibcs2)					\
-		set_personality(PER_SVR4);		\
-	else if (current->personality != PER_LINUX32)	\
+	if (current->personality != PER_LINUX32)	\
 		set_personality(PER_LINUX);		\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
 		set_thread_flag(TIF_31BIT);		\
diff -urpN linux-2.6/arch/sh/include/asm/elf.h linux-2.6-patched/arch/sh/include/asm/elf.h
--- linux-2.6/arch/sh/include/asm/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/sh/include/asm/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -189,7 +189,7 @@ do {									\
 } while (0)
 #endif
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX_32BIT)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX_32BIT)
 struct task_struct;
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
diff -urpN linux-2.6/arch/sparc/include/asm/elf_32.h linux-2.6-patched/arch/sparc/include/asm/elf_32.h
--- linux-2.6/arch/sparc/include/asm/elf_32.h	2008-10-15 12:51:06.000000000 +0200
+++ linux-2.6-patched/arch/sparc/include/asm/elf_32.h	2008-10-15 12:51:33.000000000 +0200
@@ -137,6 +137,6 @@ typedef struct {
 
 #define ELF_PLATFORM	(NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif /* !(__ASMSPARC_ELF_H) */
diff -urpN linux-2.6/arch/sparc/include/asm/elf_64.h linux-2.6-patched/arch/sparc/include/asm/elf_64.h
--- linux-2.6/arch/sparc/include/asm/elf_64.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/arch/sparc/include/asm/elf_64.h	2008-10-15 12:51:33.000000000 +0200
@@ -195,7 +195,7 @@ static inline unsigned int sparc64_elf_h
 
 #define ELF_PLATFORM	(NULL)
 
-#define SET_PERSONALITY(ex, ibcs2)			\
+#define SET_PERSONALITY(ex)				\
 do {	unsigned long new_flags = current_thread_info()->flags; \
 	new_flags &= _TIF_32BIT;			\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
@@ -208,9 +208,7 @@ do {	unsigned long new_flags = current_t
 	else						\
 		clear_thread_flag(TIF_ABI_PENDING);	\
 	/* flush_thread will update pgd cache */	\
-	if (ibcs2)					\
-		set_personality(PER_SVR4);		\
-	else if (current->personality != PER_LINUX32)	\
+	if (current->personality != PER_LINUX32)	\
 		set_personality(PER_LINUX);		\
 } while (0)
 
diff -urpN linux-2.6/fs/binfmt_elf.c linux-2.6-patched/fs/binfmt_elf.c
--- linux-2.6/fs/binfmt_elf.c	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/fs/binfmt_elf.c	2008-10-15 12:51:33.000000000 +0200
@@ -683,7 +683,7 @@ static int load_elf_binary(struct linux_
 			 * switch really is going to happen - do this in
 			 * flush_thread().	- akpm
 			 */
-			SET_PERSONALITY(loc->elf_ex, 0);
+			SET_PERSONALITY(loc->elf_ex);
 
 			interpreter = open_exec(elf_interpreter);
 			retval = PTR_ERR(interpreter);
@@ -734,7 +734,7 @@ static int load_elf_binary(struct linux_
 			goto out_free_dentry;
 	} else {
 		/* Executables without an interpreter also need a personality  */
-		SET_PERSONALITY(loc->elf_ex, 0);
+		SET_PERSONALITY(loc->elf_ex);
 	}
 
 	/* Flush all traces of the currently running executable */
@@ -748,7 +748,7 @@ static int load_elf_binary(struct linux_
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
-	SET_PERSONALITY(loc->elf_ex, 0);
+	SET_PERSONALITY(loc->elf_ex);
 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
diff -urpN linux-2.6/include/asm-cris/elf.h linux-2.6-patched/include/asm-cris/elf.h
--- linux-2.6/include/asm-cris/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-cris/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -88,6 +88,6 @@ typedef unsigned long elf_fpregset_t;
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif
diff -urpN linux-2.6/include/asm-frv/elf.h linux-2.6-patched/include/asm-frv/elf.h
--- linux-2.6/include/asm-frv/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-frv/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -137,6 +137,6 @@ do {											\
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif
diff -urpN linux-2.6/include/asm-m32r/elf.h linux-2.6-patched/include/asm-m32r/elf.h
--- linux-2.6/include/asm-m32r/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-m32r/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -129,6 +129,6 @@ typedef elf_fpreg_t elf_fpregset_t;
    intent than poking at uname or /proc/cpuinfo.  */
 #define ELF_PLATFORM	(NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif  /* _ASM_M32R__ELF_H */
diff -urpN linux-2.6/include/asm-m68k/elf.h linux-2.6-patched/include/asm-m68k/elf.h
--- linux-2.6/include/asm-m68k/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-m68k/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -114,6 +114,6 @@ typedef struct user_m68kfp_struct elf_fp
 
 #define ELF_PLATFORM  (NULL)
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 
 #endif
diff -urpN linux-2.6/include/asm-mn10300/elf.h linux-2.6-patched/include/asm-mn10300/elf.h
--- linux-2.6/include/asm-mn10300/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-mn10300/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -141,7 +141,7 @@ do {						\
 #define ELF_PLATFORM  (NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
 #endif
 
 #endif /* _ASM_ELF_H */
diff -urpN linux-2.6/include/asm-parisc/elf.h linux-2.6-patched/include/asm-parisc/elf.h
--- linux-2.6/include/asm-parisc/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-parisc/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -236,7 +236,7 @@ typedef unsigned long elf_greg_t;
 
 #define ELF_PLATFORM  ("PARISC\0")
 
-#define SET_PERSONALITY(ex, ibcs2) \
+#define SET_PERSONALITY(ex) \
 	current->personality = PER_LINUX; \
 	current->thread.map_base = DEFAULT_MAP_BASE; \
 	current->thread.task_size = DEFAULT_TASK_SIZE \
diff -urpN linux-2.6/include/asm-um/elf-i386.h linux-2.6-patched/include/asm-um/elf-i386.h
--- linux-2.6/include/asm-um/elf-i386.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-um/elf-i386.h	2008-10-15 12:51:33.000000000 +0200
@@ -86,7 +86,7 @@ extern long elf_aux_hwcap;
 extern char * elf_aux_platform;
 #define ELF_PLATFORM (elf_aux_platform)
 
-#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
+#define SET_PERSONALITY(ex) do { } while (0)
 
 extern unsigned long vsyscall_ehdr;
 extern unsigned long vsyscall_end;
diff -urpN linux-2.6/include/asm-um/elf-ppc.h linux-2.6-patched/include/asm-um/elf-ppc.h
--- linux-2.6/include/asm-um/elf-ppc.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-um/elf-ppc.h	2008-10-15 12:51:33.000000000 +0200
@@ -5,7 +5,7 @@
 extern long elf_aux_hwcap;
 #define ELF_HWCAP (elf_aux_hwcap)
 
-#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+#define SET_PERSONALITY(ex) do ; while(0)
 
 #define ELF_EXEC_PAGESIZE 4096
 
diff -urpN linux-2.6/include/asm-um/elf-x86_64.h linux-2.6-patched/include/asm-um/elf-x86_64.h
--- linux-2.6/include/asm-um/elf-x86_64.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-um/elf-x86_64.h	2008-10-15 12:51:33.000000000 +0200
@@ -114,6 +114,6 @@ extern long elf_aux_hwcap;
 
 #define ELF_PLATFORM "x86_64"
 
-#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+#define SET_PERSONALITY(ex) do ; while(0)
 
 #endif
diff -urpN linux-2.6/include/asm-x86/elf.h linux-2.6-patched/include/asm-x86/elf.h
--- linux-2.6/include/asm-x86/elf.h	2008-10-15 12:51:08.000000000 +0200
+++ linux-2.6-patched/include/asm-x86/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -186,7 +186,7 @@ do {							\
 	set_fs(USER_DS);				\
 } while (0)
 
-#define COMPAT_SET_PERSONALITY(ex, ibcs2)		\
+#define COMPAT_SET_PERSONALITY(ex)			\
 do {							\
 	if (test_thread_flag(TIF_IA32))			\
 		clear_thread_flag(TIF_ABI_PENDING);	\
@@ -267,7 +267,7 @@ extern int force_personality32;
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality_64bit()
+#define SET_PERSONALITY(ex) set_personality_64bit()
 
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
diff -urpN linux-2.6/include/asm-xtensa/elf.h linux-2.6-patched/include/asm-xtensa/elf.h
--- linux-2.6/include/asm-xtensa/elf.h	2008-10-10 00:13:53.000000000 +0200
+++ linux-2.6-patched/include/asm-xtensa/elf.h	2008-10-15 12:51:33.000000000 +0200
@@ -189,7 +189,7 @@ typedef struct {
 #endif
 } elf_xtregs_t;
 
-#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX_32BIT)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX_32BIT)
 
 struct task_struct;
 
