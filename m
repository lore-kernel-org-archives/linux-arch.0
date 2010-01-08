From: akpm@linux-foundation.org
Subject: + elf-coredump-replace-elf_core_extra_-macros-by-functions.patch added to -mm tree
Date: Thu, 07 Jan 2010 16:29:51 -0800
Message-ID: <201001080029.o080Tpoq026460@imap1.linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45754 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753706Ab0AHAb3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2010 19:31:29 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mm-commits@vger.kernel.org
Cc: d.hatayama@jp.fujitsu.com, alan@lxorguk.ukuu.org.uk, andi@firstfloor.org, dhowells@redhat.com, gerg@snapgear.com, jdike@addtoit.com, linux-arch@vger.kernel.org, mingo@elte.hu, oleg@redhat.com, roland@redhat.com, tony.luck@intel.com, viro@zeniv.linux.org.uk


The patch titled
     elf coredump: replace ELF_CORE_EXTRA_* macros by functions
has been added to the -mm tree.  Its filename is
     elf-coredump-replace-elf_core_extra_-macros-by-functions.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/SubmitChecklist when testing your code ***

See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
out what to do about this

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
Subject: elf coredump: replace ELF_CORE_EXTRA_* macros by functions
From: Daisuke HATAYAMA <d.hatayama@jp.fujitsu.com>

elf_core_dump() and elf_fdpic_core_dump() use #ifdef and the corresponding
macro for hiding _multiline_ logics in functions.  This patch removes
#ifdef and replaces ELF_CORE_EXTRA_* by corresponding functions.  For
architectures not implemeonting ELF_CORE_EXTRA_*, we use weak functions in
order to reduce a range of modification.

This cleanup is for my next patches, but I think this cleanup itself is
worth doing regardless of my firnal purpose.

Signed-off-by: Daisuke HATAYAMA <d.hatayama@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Greg Ungerer <gerg@snapgear.com>
Cc: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/ia64/ia32/binfmt_elf32.c |    1 
 arch/ia64/ia32/elfcore32.h    |   17 ++++++++
 arch/ia64/include/asm/elf.h   |   48 ----------------------
 arch/ia64/kernel/Makefile     |    2 
 arch/ia64/kernel/elfcore.c    |   64 ++++++++++++++++++++++++++++++
 arch/um/sys-i386/Makefile     |    2 
 arch/um/sys-i386/asm/elf.h    |   43 --------------------
 arch/um/sys-i386/elfcore.c    |   67 ++++++++++++++++++++++++++++++++
 fs/binfmt_elf.c               |   14 ++----
 fs/binfmt_elf_fdpic.c         |   14 ++----
 include/linux/elf.h           |    2 
 include/linux/elfcore.h       |   16 +++++++
 kernel/Makefile               |    2 
 kernel/elfcore.c              |   23 ++++++++++
 14 files changed, 206 insertions(+), 109 deletions(-)

diff -puN arch/ia64/ia32/binfmt_elf32.c~elf-coredump-replace-elf_core_extra_-macros-by-functions arch/ia64/ia32/binfmt_elf32.c
--- a/arch/ia64/ia32/binfmt_elf32.c~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/arch/ia64/ia32/binfmt_elf32.c
@@ -43,6 +43,7 @@ randomize_stack_top(unsigned long stack_
 #undef SET_PERSONALITY
 #define SET_PERSONALITY(ex)	elf32_set_personality()
 
+#undef elf_read_implies_exec
 #define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
 
 /* Ugly but avoids duplication */
diff -puN arch/ia64/ia32/elfcore32.h~elf-coredump-replace-elf_core_extra_-macros-by-functions arch/ia64/ia32/elfcore32.h
--- a/arch/ia64/ia32/elfcore32.h~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/arch/ia64/ia32/elfcore32.h
@@ -8,6 +8,8 @@
 #ifndef _ELFCORE32_H_
 #define _ELFCORE32_H_
 
+#include <linux/elf.h>
+
 #include <asm/intrinsics.h>
 #include <asm/uaccess.h>
 
@@ -145,4 +147,19 @@ elf_core_copy_task_xfpregs(struct task_s
 	return 1;
 }
 
+/*
+ * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the gate DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the gate DSO was being used.
+ */
+extern Elf32_Half elf_core_extra_phdrs(void);
+extern int
+elf_core_write_extra_phdrs(struct file *file, loff_t offset, size_t *size,
+			   unsigned long limit);
+extern int
+elf_core_write_extra_data(struct file *file, size_t *size, unsigned long limit);
+
 #endif /* _ELFCORE32_H_ */
diff -puN arch/ia64/include/asm/elf.h~elf-coredump-replace-elf_core_extra_-macros-by-functions arch/ia64/include/asm/elf.h
--- a/arch/ia64/include/asm/elf.h~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/arch/ia64/include/asm/elf.h
@@ -217,54 +217,6 @@ do {										\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR, (unsigned long) GATE_EHDR);		\
 } while (0)
 
-
-/*
- * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
- * extra segments containing the gate DSO contents.  Dumping its
- * contents makes post-mortem fully interpretable later without matching up
- * the same kernel and hardware config to see what PC values meant.
- * Dumping its extra ELF program headers includes all the other information
- * a debugger needs to easily find how the gate DSO was being used.
- */
-#define ELF_CORE_EXTRA_PHDRS		(GATE_EHDR->e_phnum)
-#define ELF_CORE_WRITE_EXTRA_PHDRS						\
-do {										\
-	const struct elf_phdr *const gate_phdrs =			      \
-		(const struct elf_phdr *) (GATE_ADDR + GATE_EHDR->e_phoff);   \
-	int i;									\
-	Elf64_Off ofs = 0;						      \
-	for (i = 0; i < GATE_EHDR->e_phnum; ++i) {				\
-		struct elf_phdr phdr = gate_phdrs[i];			      \
-		if (phdr.p_type == PT_LOAD) {					\
-			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
-			phdr.p_filesz = phdr.p_memsz;			      \
-			if (ofs == 0) {					      \
-				ofs = phdr.p_offset = offset;		      \
-			offset += phdr.p_filesz;				\
-		}							      \
-		else							      \
-				phdr.p_offset = ofs;			      \
-		}							      \
-		else							      \
-			phdr.p_offset += ofs;					\
-		phdr.p_paddr = 0; /* match other core phdrs */			\
-		DUMP_WRITE(&phdr, sizeof(phdr));				\
-	}									\
-} while (0)
-#define ELF_CORE_WRITE_EXTRA_DATA					\
-do {									\
-	const struct elf_phdr *const gate_phdrs =			      \
-		(const struct elf_phdr *) (GATE_ADDR + GATE_EHDR->e_phoff);   \
-	int i;								\
-	for (i = 0; i < GATE_EHDR->e_phnum; ++i) {			\
-		if (gate_phdrs[i].p_type == PT_LOAD) {			      \
-			DUMP_WRITE((void *) gate_phdrs[i].p_vaddr,	      \
-				   PAGE_ALIGN(gate_phdrs[i].p_memsz));	      \
-			break;						      \
-		}							      \
-	}								\
-} while (0)
-
 /*
  * format for entries in the Global Offset Table
  */
diff -puN arch/ia64/kernel/Makefile~elf-coredump-replace-elf_core_extra_-macros-by-functions arch/ia64/kernel/Makefile
--- a/arch/ia64/kernel/Makefile~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/arch/ia64/kernel/Makefile
@@ -49,6 +49,8 @@ endif
 obj-$(CONFIG_DMAR)		+= pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= pci-swiotlb.o
 
+obj-$(CONFIG_BINFMT_ELF)	+= elfcore.o
+
 # fp_emulate() expects f2-f5,f16-f31 to contain the user-level state.
 CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
 
diff -puN /dev/null arch/ia64/kernel/elfcore.c
--- /dev/null
+++ a/arch/ia64/kernel/elfcore.c
@@ -0,0 +1,64 @@
+#include <linux/elf.h>
+#include <linux/coredump.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+
+#include <asm/elf.h>
+
+
+Elf64_Half elf_core_extra_phdrs(void)
+{
+	return GATE_EHDR->e_phnum;
+}
+
+int elf_core_write_extra_phdrs(struct file *file, loff_t offset, size_t *size,
+			       unsigned long limit)
+{
+	const struct elf_phdr *const gate_phdrs =
+		(const struct elf_phdr *) (GATE_ADDR + GATE_EHDR->e_phoff);
+	int i;
+	Elf64_Off ofs = 0;
+
+	for (i = 0; i < GATE_EHDR->e_phnum; ++i) {
+		struct elf_phdr phdr = gate_phdrs[i];
+
+		if (phdr.p_type == PT_LOAD) {
+			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);
+			phdr.p_filesz = phdr.p_memsz;
+			if (ofs == 0) {
+				ofs = phdr.p_offset = offset;
+				offset += phdr.p_filesz;
+			} else {
+				phdr.p_offset = ofs;
+			}
+		} else {
+			phdr.p_offset += ofs;
+		}
+		phdr.p_paddr = 0; /* match other core phdrs */
+		*size += sizeof(phdr);
+		if (*size > limit || !dump_write(file, &phdr, sizeof(phdr)))
+			return 0;
+	}
+	return 1;
+}
+
+int elf_core_write_extra_data(struct file *file, size_t *size,
+			      unsigned long limit)
+{
+	const struct elf_phdr *const gate_phdrs =
+		(const struct elf_phdr *) (GATE_ADDR + GATE_EHDR->e_phoff);
+	int i;
+
+	for (i = 0; i < GATE_EHDR->e_phnum; ++i) {
+		if (gate_phdrs[i].p_type == PT_LOAD) {
+			void *addr = (void *)gate_phdrs[i].p_vaddr;
+			size_t memsz = PAGE_ALIGN(gate_phdrs[i].p_memsz);
+
+			*size += memsz;
+			if (*size > limit || !dump_write(file, addr, memsz))
+				return 0;
+			break;
+		}
+	}
+	return 1;
+}
diff -puN arch/um/sys-i386/Makefile~elf-coredump-replace-elf_core_extra_-macros-by-functions arch/um/sys-i386/Makefile
--- a/arch/um/sys-i386/Makefile~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/arch/um/sys-i386/Makefile
@@ -6,6 +6,8 @@ obj-y = bug.o bugs.o checksum.o delay.o 
 	ptrace_user.o setjmp.o signal.o stub.o stub_segv.o syscalls.o sysrq.o \
 	sys_call_table.o tls.o
 
+obj-$(CONFIG_BINFMT_ELF) += elfcore.o
+
 subarch-obj-y = lib/semaphore_32.o lib/string_32.o
 subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem_32.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
diff -puN arch/um/sys-i386/asm/elf.h~elf-coredump-replace-elf_core_extra_-macros-by-functions arch/um/sys-i386/asm/elf.h
--- a/arch/um/sys-i386/asm/elf.h~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/arch/um/sys-i386/asm/elf.h
@@ -116,47 +116,4 @@ do {								\
 	}							\
 } while (0)
 
-/*
- * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
- * extra segments containing the vsyscall DSO contents.  Dumping its
- * contents makes post-mortem fully interpretable later without matching up
- * the same kernel and hardware config to see what PC values meant.
- * Dumping its extra ELF program headers includes all the other information
- * a debugger needs to easily find how the vsyscall DSO was being used.
- */
-#define ELF_CORE_EXTRA_PHDRS						      \
-	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
-
-#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
-if ( vsyscall_ehdr ) {							      \
-	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
-	const struct elf_phdr *const phdrp =				      \
-		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
-	int i;								      \
-	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
-		struct elf_phdr phdr = phdrp[i];			      \
-		if (phdr.p_type == PT_LOAD) {				      \
-			ofs = phdr.p_offset = offset;			      \
-			offset += phdr.p_filesz;			      \
-		}							      \
-		else							      \
-			phdr.p_offset += ofs;				      \
-		phdr.p_paddr = 0; /* match other core phdrs */		      \
-		DUMP_WRITE(&phdr, sizeof(phdr));			      \
-	}								      \
-}
-#define ELF_CORE_WRITE_EXTRA_DATA					      \
-if ( vsyscall_ehdr ) {							      \
-	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
-	const struct elf_phdr *const phdrp =				      \
-		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
-	int i;								      \
-	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
-		if (phdrp[i].p_type == PT_LOAD)				      \
-			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
-				   phdrp[i].p_filesz);			      \
-	}								      \
-}
-
 #endif
diff -puN /dev/null arch/um/sys-i386/elfcore.c
--- /dev/null
+++ a/arch/um/sys-i386/elfcore.c
@@ -0,0 +1,67 @@
+#include <linux/elf.h>
+#include <linux/coredump.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+
+#include <asm/elf.h>
+
+
+Elf32_Half elf_core_extra_phdrs(void)
+{
+	return vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0;
+}
+
+int elf_core_write_extra_phdrs(struct file *file, loff_t offset, size_t *size,
+			       unsigned long limit)
+{
+	if ( vsyscall_ehdr ) {
+		const struct elfhdr *const ehdrp =
+			(struct elfhdr *) vsyscall_ehdr;
+		const struct elf_phdr *const phdrp =
+			(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);
+		int i;
+		Elf32_Off ofs = 0;
+
+		for (i = 0; i < ehdrp->e_phnum; ++i) {
+			struct elf_phdr phdr = phdrp[i];
+
+			if (phdr.p_type == PT_LOAD) {
+				ofs = phdr.p_offset = offset;
+				offset += phdr.p_filesz;
+			} else {
+				phdr.p_offset += ofs;
+			}
+			phdr.p_paddr = 0; /* match other core phdrs */
+			*size += sizeof(phdr);
+			if (*size > limit
+			    || !dump_write(file, &phdr, sizeof(phdr)))
+				return 0;
+		}
+	}
+	return 1;
+}
+
+int elf_core_write_extra_data(struct file *file, size_t *size,
+			      unsigned long limit)
+{
+	if ( vsyscall_ehdr ) {
+		const struct elfhdr *const ehdrp =
+			(struct elfhdr *) vsyscall_ehdr;
+		const struct elf_phdr *const phdrp =
+			(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);
+		int i;
+
+		for (i = 0; i < ehdrp->e_phnum; ++i) {
+			if (phdrp[i].p_type == PT_LOAD) {
+				void *addr = (void *) phdrp[i].p_vaddr;
+				size_t filesz = phdrp[i].p_filesz;
+
+				*size += filesz;
+				if (*size > limit
+				    || !dump_write(file, addr, filesz))
+					return 0;
+			}
+		}
+	}
+	return 1;
+}
diff -puN fs/binfmt_elf.c~elf-coredump-replace-elf_core_extra_-macros-by-functions fs/binfmt_elf.c
--- a/fs/binfmt_elf.c~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/fs/binfmt_elf.c
@@ -1901,9 +1901,7 @@ static int elf_core_dump(struct coredump
 	 * Please check DEFAULT_MAX_MAP_COUNT definition when you modify here.
 	 */
 	segs = current->mm->map_count;
-#ifdef ELF_CORE_EXTRA_PHDRS
-	segs += ELF_CORE_EXTRA_PHDRS;
-#endif
+	segs += elf_core_extra_phdrs();
 
 	gate_vma = get_gate_vma(current);
 	if (gate_vma != NULL)
@@ -1981,9 +1979,8 @@ static int elf_core_dump(struct coredump
 			goto end_coredump;
 	}
 
-#ifdef ELF_CORE_WRITE_EXTRA_PHDRS
-	ELF_CORE_WRITE_EXTRA_PHDRS;
-#endif
+	if (!elf_core_write_extra_phdrs(cprm->file, offset, &size, cprm->limit))
+		goto end_coredump;
 
  	/* write out the notes section */
 	if (!write_note_info(&info, cprm->file, &foffset))
@@ -2022,9 +2019,8 @@ static int elf_core_dump(struct coredump
 		}
 	}
 
-#ifdef ELF_CORE_WRITE_EXTRA_DATA
-	ELF_CORE_WRITE_EXTRA_DATA;
-#endif
+	if (!elf_core_write_extra_data(cprm->file, &size, cprm->limit))
+		goto end_coredump;
 
 end_coredump:
 	set_fs(fs);
diff -puN fs/binfmt_elf_fdpic.c~elf-coredump-replace-elf_core_extra_-macros-by-functions fs/binfmt_elf_fdpic.c
--- a/fs/binfmt_elf_fdpic.c~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/fs/binfmt_elf_fdpic.c
@@ -1661,9 +1661,7 @@ static int elf_fdpic_core_dump(struct co
 	elf_core_copy_regs(&prstatus->pr_reg, cprm->regs);
 
 	segs = current->mm->map_count;
-#ifdef ELF_CORE_EXTRA_PHDRS
-	segs += ELF_CORE_EXTRA_PHDRS;
-#endif
+	segs += elf_core_extra_phdrs();
 
 	/* Set up header */
 	fill_elf_fdpic_header(elf, segs + 1);	/* including notes section */
@@ -1770,9 +1768,8 @@ static int elf_fdpic_core_dump(struct co
 			goto end_coredump;
 	}
 
-#ifdef ELF_CORE_WRITE_EXTRA_PHDRS
-	ELF_CORE_WRITE_EXTRA_PHDRS;
-#endif
+	if (!elf_core_write_extra_phdrs(cprm->file, offset, &size, cprm->limit))
+		goto end_coredump;
 
  	/* write out the notes section */
 	for (i = 0; i < numnote; i++)
@@ -1796,9 +1793,8 @@ static int elf_fdpic_core_dump(struct co
 				    mm_flags) < 0)
 		goto end_coredump;
 
-#ifdef ELF_CORE_WRITE_EXTRA_DATA
-	ELF_CORE_WRITE_EXTRA_DATA;
-#endif
+	if (!elf_core_write_extra_data(cprm->file, &size, cprm->limit))
+		goto end_coredump;
 
 	if (cprm->file->f_pos != offset) {
 		/* Sanity check */
diff -puN include/linux/elf.h~elf-coredump-replace-elf_core_extra_-macros-by-functions include/linux/elf.h
--- a/include/linux/elf.h~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/include/linux/elf.h
@@ -386,6 +386,7 @@ extern Elf32_Dyn _DYNAMIC [];
 #define elf_phdr	elf32_phdr
 #define elf_note	elf32_note
 #define elf_addr_t	Elf32_Off
+#define Elf_Half	Elf32_Half
 
 #else
 
@@ -394,6 +395,7 @@ extern Elf64_Dyn _DYNAMIC [];
 #define elf_phdr	elf64_phdr
 #define elf_note	elf64_note
 #define elf_addr_t	Elf64_Off
+#define Elf_Half	Elf64_Half
 
 #endif
 
diff -puN include/linux/elfcore.h~elf-coredump-replace-elf_core_extra_-macros-by-functions include/linux/elfcore.h
--- a/include/linux/elfcore.h~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/include/linux/elfcore.h
@@ -8,6 +8,8 @@
 #include <linux/user.h>
 #endif
 #include <linux/ptrace.h>
+#include <linux/elf.h>
+#include <linux/fs.h>
 
 struct elf_siginfo
 {
@@ -150,5 +152,19 @@ static inline int elf_core_copy_task_xfp
 
 #endif /* __KERNEL__ */
 
+/*
+ * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the gate DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the gate DSO was being used.
+ */
+extern Elf_Half elf_core_extra_phdrs(void);
+extern int
+elf_core_write_extra_phdrs(struct file *file, loff_t offset, size_t *size,
+			   unsigned long limit);
+extern int
+elf_core_write_extra_data(struct file *file, size_t *size, unsigned long limit);
 
 #endif /* _LINUX_ELFCORE_H */
diff -puN kernel/Makefile~elf-coredump-replace-elf_core_extra_-macros-by-functions kernel/Makefile
--- a/kernel/Makefile~elf-coredump-replace-elf_core_extra_-macros-by-functions
+++ a/kernel/Makefile
@@ -101,6 +101,8 @@ obj-$(CONFIG_SLOW_WORK_DEBUG) += slow-wo
 obj-$(CONFIG_PERF_EVENTS) += perf_event.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
+obj-$(CONFIG_BINFMT_ELF) += elfcore.o
+obj-$(CONFIG_BINFMT_ELF_FDPIC) += elfcore.o
 
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -puN /dev/null kernel/elfcore.c
--- /dev/null
+++ a/kernel/elfcore.c
@@ -0,0 +1,23 @@
+#include <linux/elf.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+
+#include <asm/elf.h>
+
+
+Elf_Half __weak elf_core_extra_phdrs(void)
+{
+	return 0;
+}
+
+int __weak elf_core_write_extra_phdrs(struct file *file, loff_t offset, size_t *size,
+				      unsigned long limit)
+{
+	return 1;
+}
+
+int __weak elf_core_write_extra_data(struct file *file, size_t *size,
+				     unsigned long limit)
+{
+	return 1;
+}
_

Patches currently in -mm which might be from d.hatayama@jp.fujitsu.com are

coredump-unify-dump_seek-implementations-for-each-binfmt_c.patch
coredump-move-dump_write-and-dump_seek-into-a-header-file.patch
elf-coredump-replace-elf_core_extra_-macros-by-functions.patch
elf-coredump-make-offset-calculation-process-and-writing-process-explicit.patch
elf-coredump-add-extended-numbering-support.patch
