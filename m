Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 27 Jul 2005 13:34:35 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: auxiliary-vector-cleanups.patch
Message-Id: <20050727133435.488242b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: "H. J. Lu" <hjl@lucon.org>
List-ID: <linux-arch.vger.kernel.org>


For your reviewing pleasure.


From: "H. J. Lu" <hjl@lucon.org>

The size of auxiliary vector is fixed at 42 in linux/sched.h.  But it isn't
very obvious when looking at linux/elf.h.  This patch adds AT_VECTOR_SIZE
so that we can change it if necessary when a new vector is added.

Because of include file ordering problems, doing this necessitated the
extraction of the AT_* symbols into a standalone header file.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-alpha/auxvec.h     |   24 ++++++++++++++++++++++++
 include/asm-alpha/elf.h        |   22 ++--------------------
 include/asm-arm/auxvec.h       |    4 ++++
 include/asm-arm26/auxvec.h     |    4 ++++
 include/asm-cris/auxvec.h      |    4 ++++
 include/asm-h8300/auxvec.h     |    4 ++++
 include/asm-i386/auxvec.h      |   11 +++++++++++
 include/asm-i386/elf.h         |    8 +-------
 include/asm-ia64/auxvec.h      |   11 +++++++++++
 include/asm-ia64/elf.h         |    8 +-------
 include/asm-m32r/auxvec.h      |    4 ++++
 include/asm-m68k/auxvec.h      |    4 ++++
 include/asm-m68knommu/auxvec.h |    4 ++++
 include/asm-mips/auxvec.h      |    4 ++++
 include/asm-parisc/auxvec.h    |    4 ++++
 include/asm-ppc/auxvec.h       |   14 ++++++++++++++
 include/asm-ppc/elf.h          |   11 +----------
 include/asm-ppc64/auxvec.h     |   19 +++++++++++++++++++
 include/asm-ppc64/elf.h        |   16 +---------------
 include/asm-s390/auxvec.h      |    4 ++++
 include/asm-sh/auxvec.h        |    4 ++++
 include/asm-sh64/auxvec.h      |    4 ++++
 include/asm-sparc/auxvec.h     |    4 ++++
 include/asm-sparc64/auxvec.h   |    4 ++++
 include/asm-um/auxvec.h        |    4 ++++
 include/asm-v850/auxvec.h      |    4 ++++
 include/asm-x86_64/auxvec.h    |    4 ++++
 include/linux/auxvec.h         |   31 +++++++++++++++++++++++++++++++
 include/linux/elf.h            |   24 +-----------------------
 include/linux/sched.h          |    4 +++-
 30 files changed, 188 insertions(+), 83 deletions(-)

diff -puN /dev/null include/asm-alpha/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-alpha/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,24 @@
+#ifndef __ASM_ALPHA_AUXVEC_H
+#define __ASM_ALPHA_AUXVEC_H
+
+/* Reserve these numbers for any future use of a VDSO.  */
+#if 0
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+#endif
+
+/* More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
+   value is -1, then the cache doesn't exist.  Otherwise:
+
+      bit 0-3:	  Cache set-associativity; 0 means fully associative.
+      bit 4-7:	  Log2 of cacheline size.
+      bit 8-31:	  Size of the entire cache >> 8.
+      bit 32-63:  Reserved.
+*/
+
+#define AT_L1I_CACHESHAPE	34
+#define AT_L1D_CACHESHAPE	35
+#define AT_L2_CACHESHAPE	36
+#define AT_L3_CACHESHAPE	37
+
+#endif /* __ASM_ALPHA_AUXVEC_H */
diff -puN include/asm-alpha/elf.h~auxiliary-vector-cleanups include/asm-alpha/elf.h
--- devel/include/asm-alpha/elf.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/asm-alpha/elf.h	2005-07-27 13:32:41.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef __ASM_ALPHA_ELF_H
 #define __ASM_ALPHA_ELF_H
 
+#include <asm/auxvec.h>
+
 /* Special values for the st_other field in the symbol table.  */
 
 #define STO_ALPHA_NOPV		0x80
@@ -142,26 +144,6 @@ extern int dump_elf_task_fp(elf_fpreg_t 
 	: amask (AMASK_CIX) ? "ev6" : "ev67");	\
 })
 
-/* Reserve these numbers for any future use of a VDSO.  */
-#if 0
-#define AT_SYSINFO		32
-#define AT_SYSINFO_EHDR		33
-#endif
-
-/* More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
-   value is -1, then the cache doesn't exist.  Otherwise:
-
-      bit 0-3:	  Cache set-associativity; 0 means fully associative.
-      bit 4-7:	  Log2 of cacheline size.
-      bit 8-31:	  Size of the entire cache >> 8.
-      bit 32-63:  Reserved.
-*/
-
-#define AT_L1I_CACHESHAPE	34
-#define AT_L1D_CACHESHAPE	35
-#define AT_L2_CACHESHAPE	36
-#define AT_L3_CACHESHAPE	37
-
 #ifdef __KERNEL__
 
 #define SET_PERSONALITY(EX, IBCS2)				\
diff -puN /dev/null include/asm-arm26/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-arm26/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMARM_AUXVEC_H
+#define __ASMARM_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-arm/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-arm/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMARM_AUXVEC_H
+#define __ASMARM_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-cris/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-cris/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMCRIS_AUXVEC_H
+#define __ASMCRIS_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-h8300/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-h8300/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMH8300_AUXVEC_H
+#define __ASMH8300_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-i386/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-i386/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,11 @@
+#ifndef __ASMi386_AUXVEC_H
+#define __ASMi386_AUXVEC_H
+
+/*
+ * Architecture-neutral AT_ values in 0-17, leave some room
+ * for more of them, start the x86-specific ones at 32.
+ */
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+
+#endif
diff -puN include/asm-i386/elf.h~auxiliary-vector-cleanups include/asm-i386/elf.h
--- devel/include/asm-i386/elf.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/asm-i386/elf.h	2005-07-27 13:32:41.000000000 -0700
@@ -9,6 +9,7 @@
 #include <asm/user.h>
 #include <asm/processor.h>
 #include <asm/system.h>		/* for savesegment */
+#include <asm/auxvec.h>
 
 #include <linux/utsname.h>
 
@@ -109,13 +110,6 @@ typedef struct user_fxsr_struct elf_fpxr
 
 #define ELF_PLATFORM  (system_utsname.machine)
 
-/*
- * Architecture-neutral AT_ values in 0-17, leave some room
- * for more of them, start the x86-specific ones at 32.
- */
-#define AT_SYSINFO		32
-#define AT_SYSINFO_EHDR		33
-
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
diff -puN /dev/null include/asm-ia64/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-ia64/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,11 @@
+#ifndef _ASM_IA64_AUXVEC_H
+#define _ASM_IA64_AUXVEC_H
+
+/*
+ * Architecture-neutral AT_ values are in the range 0-17.  Leave some room for more of
+ * them, start the architecture-specific ones at 32.
+ */
+#define AT_SYSINFO	32
+#define AT_SYSINFO_EHDR	33
+
+#endif /* _ASM_IA64_AUXVEC_H */
diff -puN include/asm-ia64/elf.h~auxiliary-vector-cleanups include/asm-ia64/elf.h
--- devel/include/asm-ia64/elf.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/asm-ia64/elf.h	2005-07-27 13:32:41.000000000 -0700
@@ -12,6 +12,7 @@
 
 #include <asm/fpu.h>
 #include <asm/page.h>
+#include <asm/auxvec.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
@@ -177,13 +178,6 @@ extern void ia64_elf_core_copy_regs (str
    relevant until we have real hardware to play with... */
 #define ELF_PLATFORM	NULL
 
-/*
- * Architecture-neutral AT_ values are in the range 0-17.  Leave some room for more of
- * them, start the architecture-specific ones at 32.
- */
-#define AT_SYSINFO	32
-#define AT_SYSINFO_EHDR	33
-
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2)	set_personality(PER_LINUX)
 #define elf_read_implies_exec(ex, executable_stack)					\
diff -puN /dev/null include/asm-m32r/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-m32r/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_M32R__AUXVEC_H
+#define _ASM_M32R__AUXVEC_H
+
+#endif  /* _ASM_M32R__AUXVEC_H */
diff -puN /dev/null include/asm-m68k/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-m68k/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMm68k_AUXVEC_H
+#define __ASMm68k_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-m68knommu/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-m68knommu/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMm68k_AUXVEC_H
+#define __ASMm68k_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-mips/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-mips/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_AUXVEC_H
+#define _ASM_AUXVEC_H
+
+#endif /* _ASM_AUXVEC_H */
diff -puN /dev/null include/asm-parisc/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-parisc/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMPARISC_AUXVEC_H
+#define __ASMPARISC_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-ppc64/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-ppc64/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,19 @@
+#ifndef __PPC64_AUXVEC_H
+#define __PPC64_AUXVEC_H
+
+/*
+ * We need to put in some extra aux table entries to tell glibc what
+ * the cache block size is, so it can use the dcbz instruction safely.
+ */
+#define AT_DCACHEBSIZE		19
+#define AT_ICACHEBSIZE		20
+#define AT_UCACHEBSIZE		21
+/* A special ignored type value for PPC, for glibc compatibility.  */
+#define AT_IGNOREPPC		22
+
+/* The vDSO location. We have to use the same value as x86 for glibc's
+ * sake :-)
+ */
+#define AT_SYSINFO_EHDR		33
+
+#endif /* __PPC64_AUXVEC_H */
diff -puN include/asm-ppc64/elf.h~auxiliary-vector-cleanups include/asm-ppc64/elf.h
--- devel/include/asm-ppc64/elf.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/asm-ppc64/elf.h	2005-07-27 13:32:41.000000000 -0700
@@ -4,6 +4,7 @@
 #include <asm/types.h>
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
+#include <asm/auxvec.h>
 
 /* PowerPC relocations defined by the ABIs */
 #define R_PPC_NONE		0
@@ -237,21 +238,6 @@ do {								\
 
 #endif
 
-/*
- * We need to put in some extra aux table entries to tell glibc what
- * the cache block size is, so it can use the dcbz instruction safely.
- */
-#define AT_DCACHEBSIZE		19
-#define AT_ICACHEBSIZE		20
-#define AT_UCACHEBSIZE		21
-/* A special ignored type value for PPC, for glibc compatibility.  */
-#define AT_IGNOREPPC		22
-
-/* The vDSO location. We have to use the same value as x86 for glibc's
- * sake :-)
- */
-#define AT_SYSINFO_EHDR		33
-
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
diff -puN /dev/null include/asm-ppc/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-ppc/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,14 @@
+#ifndef __PPC_AUXVEC_H
+#define __PPC_AUXVEC_H
+
+/*
+ * We need to put in some extra aux table entries to tell glibc what
+ * the cache block size is, so it can use the dcbz instruction safely.
+ */
+#define AT_DCACHEBSIZE		19
+#define AT_ICACHEBSIZE		20
+#define AT_UCACHEBSIZE		21
+/* A special ignored type value for PPC, for glibc compatibility.  */
+#define AT_IGNOREPPC		22
+
+#endif
diff -puN include/asm-ppc/elf.h~auxiliary-vector-cleanups include/asm-ppc/elf.h
--- devel/include/asm-ppc/elf.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/asm-ppc/elf.h	2005-07-27 13:32:41.000000000 -0700
@@ -7,6 +7,7 @@
 #include <asm/types.h>
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
+#include <asm/auxvec.h>
 
 /* PowerPC relocations defined by the ABIs */
 #define R_PPC_NONE		0
@@ -122,16 +123,6 @@ extern int dump_task_fpu(struct task_str
 
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
 
-/*
- * We need to put in some extra aux table entries to tell glibc what
- * the cache block size is, so it can use the dcbz instruction safely.
- */
-#define AT_DCACHEBSIZE		19
-#define AT_ICACHEBSIZE		20
-#define AT_UCACHEBSIZE		21
-/* A special ignored type value for PPC, for glibc compatibility.  */
-#define AT_IGNOREPPC		22
-
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
diff -puN /dev/null include/asm-s390/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-s390/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMS390_AUXVEC_H
+#define __ASMS390_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-sh64/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sh64/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_SH64_AUXVEC_H
+#define __ASM_SH64_AUXVEC_H
+
+#endif /* __ASM_SH64_AUXVEC_H */
diff -puN /dev/null include/asm-sh/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sh/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_SH_AUXVEC_H
+#define __ASM_SH_AUXVEC_H
+
+#endif /* __ASM_SH_AUXVEC_H */
diff -puN /dev/null include/asm-sparc64/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sparc64/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_SPARC64_AUXVEC_H
+#define __ASM_SPARC64_AUXVEC_H
+
+#endif /* !(__ASM_SPARC64_AUXVEC_H) */
diff -puN /dev/null include/asm-sparc/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sparc/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASMSPARC_AUXVEC_H
+#define __ASMSPARC_AUXVEC_H
+
+#endif /* !(__ASMSPARC_AUXVEC_H) */
diff -puN /dev/null include/asm-um/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-um/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __UM_AUXVEC_H
+#define __UM_AUXVEC_H
+
+#endif
diff -puN /dev/null include/asm-v850/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-v850/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __V850_AUXVEC_H__
+#define __V850_AUXVEC_H__
+
+#endif /* __V850_AUXVEC_H__ */
diff -puN /dev/null include/asm-x86_64/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-x86_64/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_X86_64_AUXVEC_H
+#define __ASM_X86_64_AUXVEC_H
+
+#endif
diff -puN /dev/null include/linux/auxvec.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/auxvec.h	2005-07-27 13:32:41.000000000 -0700
@@ -0,0 +1,31 @@
+#ifndef _LINUX_AUXVEC_H
+#define _LINUX_AUXVEC_H
+
+#include <asm/auxvec.h>
+
+/* Symbolic values for the entries in the auxiliary table
+   put on the initial stack */
+#define AT_NULL   0	/* end of vector */
+#define AT_IGNORE 1	/* entry should be ignored */
+#define AT_EXECFD 2	/* file descriptor of program */
+#define AT_PHDR   3	/* program headers for program */
+#define AT_PHENT  4	/* size of program header entry */
+#define AT_PHNUM  5	/* number of program headers */
+#define AT_PAGESZ 6	/* system page size */
+#define AT_BASE   7	/* base address of interpreter */
+#define AT_FLAGS  8	/* flags */
+#define AT_ENTRY  9	/* entry point of program */
+#define AT_NOTELF 10	/* program is not ELF */
+#define AT_UID    11	/* real uid */
+#define AT_EUID   12	/* effective uid */
+#define AT_GID    13	/* real gid */
+#define AT_EGID   14	/* effective gid */
+#define AT_PLATFORM 15  /* string identifying CPU for optimizations */
+#define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
+#define AT_CLKTCK 17	/* frequency at which times() increments */
+
+#define AT_SECURE 23   /* secure mode boolean */
+
+#define AT_VECTOR_SIZE  42 /* Size of auxiliary table.  */
+
+#endif /* _LINUX_AUXVEC_H */
diff -puN include/linux/elf.h~auxiliary-vector-cleanups include/linux/elf.h
--- devel/include/linux/elf.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/linux/elf.h	2005-07-27 13:32:41.000000000 -0700
@@ -2,6 +2,7 @@
 #define _LINUX_ELF_H
 
 #include <linux/types.h>
+#include <linux/auxvec.h>
 #include <asm/elf.h>
 
 #ifndef elf_read_implies_exec
@@ -158,29 +159,6 @@ typedef __s64	Elf64_Sxword;
 #define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
 #define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
 
-/* Symbolic values for the entries in the auxiliary table
-   put on the initial stack */
-#define AT_NULL   0	/* end of vector */
-#define AT_IGNORE 1	/* entry should be ignored */
-#define AT_EXECFD 2	/* file descriptor of program */
-#define AT_PHDR   3	/* program headers for program */
-#define AT_PHENT  4	/* size of program header entry */
-#define AT_PHNUM  5	/* number of program headers */
-#define AT_PAGESZ 6	/* system page size */
-#define AT_BASE   7	/* base address of interpreter */
-#define AT_FLAGS  8	/* flags */
-#define AT_ENTRY  9	/* entry point of program */
-#define AT_NOTELF 10	/* program is not ELF */
-#define AT_UID    11	/* real uid */
-#define AT_EUID   12	/* effective uid */
-#define AT_GID    13	/* real gid */
-#define AT_EGID   14	/* effective gid */
-#define AT_PLATFORM 15  /* string identifying CPU for optimizations */
-#define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
-#define AT_CLKTCK 17	/* frequency at which times() increments */
-
-#define AT_SECURE 23   /* secure mode boolean */
-
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
diff -puN include/linux/sched.h~auxiliary-vector-cleanups include/linux/sched.h
--- devel/include/linux/sched.h~auxiliary-vector-cleanups	2005-07-27 13:32:41.000000000 -0700
+++ devel-akpm/include/linux/sched.h	2005-07-27 13:32:41.000000000 -0700
@@ -35,6 +35,8 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 
+#include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
+
 struct exec_domain;
 
 /*
@@ -261,7 +263,7 @@ struct mm_struct {
 	mm_counter_t _rss;
 	mm_counter_t _anon_rss;
 
-	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
+	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:2;
 	cpumask_t cpu_vm_mask;
_
