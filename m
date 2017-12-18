From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 15/36] nds32: ELF definitions
Date: Mon, 18 Dec 2017 14:46:27 +0800
Message-ID: <89f08e3178cb0924da8201cd35c7782f8bb7616f.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1513577007.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1513577007.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1513577007.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, pombredanne-od1rfyK75/E@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch adds definitions for the ELF format, relocation types, vdso
locations and EXEC_PAGESIZE.

Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
---
 arch/nds32/include/asm/elf.h         |  179 ++++++++++++++++++++++++++++++++++
 arch/nds32/include/uapi/asm/auxvec.h |   12 +++
 arch/nds32/include/uapi/asm/param.h  |   11 +++
 3 files changed, 202 insertions(+)
 create mode 100644 arch/nds32/include/asm/elf.h
 create mode 100644 arch/nds32/include/uapi/asm/auxvec.h
 create mode 100644 arch/nds32/include/uapi/asm/param.h

diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
new file mode 100644
index 0000000..99203f1
--- /dev/null
+++ b/arch/nds32/include/asm/elf.h
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASMNDS32_ELF_H
+#define __ASMNDS32_ELF_H
+
+/*
+ * ELF register definitions..
+ */
+
+#include <asm/ptrace.h>
+
+typedef unsigned long elf_greg_t;
+typedef unsigned long elf_freg_t[3];
+
+extern unsigned int elf_hwcap;
+
+#define EM_NDS32			167
+
+#define R_NDS32_NONE			0
+#define R_NDS32_16_RELA			19
+#define R_NDS32_32_RELA			20
+#define R_NDS32_9_PCREL_RELA		22
+#define R_NDS32_15_PCREL_RELA		23
+#define R_NDS32_17_PCREL_RELA		24
+#define R_NDS32_25_PCREL_RELA		25
+#define R_NDS32_HI20_RELA		26
+#define R_NDS32_LO12S3_RELA		27
+#define R_NDS32_LO12S2_RELA		28
+#define R_NDS32_LO12S1_RELA		29
+#define R_NDS32_LO12S0_RELA		30
+#define R_NDS32_SDA15S3_RELA    	31
+#define R_NDS32_SDA15S2_RELA    	32
+#define R_NDS32_SDA15S1_RELA    	33
+#define R_NDS32_SDA15S0_RELA    	34
+#define R_NDS32_GOT20			37
+#define R_NDS32_25_PLTREL		38
+#define R_NDS32_COPY			39
+#define R_NDS32_GLOB_DAT		40
+#define R_NDS32_JMP_SLOT		41
+#define R_NDS32_RELATIVE		42
+#define R_NDS32_GOTOFF			43
+#define R_NDS32_GOTPC20			44
+#define R_NDS32_GOT_HI20		45
+#define R_NDS32_GOT_LO12		46
+#define R_NDS32_GOTPC_HI20		47
+#define R_NDS32_GOTPC_LO12		48
+#define R_NDS32_GOTOFF_HI20		49
+#define R_NDS32_GOTOFF_LO12		50
+#define R_NDS32_INSN16			51
+#define R_NDS32_LABEL			52
+#define R_NDS32_LONGCALL1		53
+#define R_NDS32_LONGCALL2		54
+#define R_NDS32_LONGCALL3		55
+#define R_NDS32_LONGJUMP1		56
+#define R_NDS32_LONGJUMP2		57
+#define R_NDS32_LONGJUMP3		58
+#define R_NDS32_LOADSTORE		59
+#define R_NDS32_9_FIXED_RELA		60
+#define R_NDS32_15_FIXED_RELA		61
+#define R_NDS32_17_FIXED_RELA		62
+#define R_NDS32_25_FIXED_RELA		63
+#define R_NDS32_PLTREL_HI20		64
+#define R_NDS32_PLTREL_LO12		65
+#define R_NDS32_PLT_GOTREL_HI20		66
+#define R_NDS32_PLT_GOTREL_LO12		67
+#define R_NDS32_LO12S0_ORI_RELA		72
+#define R_NDS32_DWARF2_OP1_RELA     	77
+#define R_NDS32_DWARF2_OP2_RELA     	78
+#define R_NDS32_DWARF2_LEB_RELA     	79
+#define R_NDS32_WORD_9_PCREL_RELA	94
+#define R_NDS32_LONGCALL4 		107
+#define R_NDS32_RELA_NOP_MIX		192
+#define R_NDS32_RELA_NOP_MAX		255
+
+#define ELF_NGREG (sizeof (struct pt_regs) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+/* Core file format: The core file is written in such a way that gdb
+   can understand it and provide useful information to the user (under
+   linux we use the 'trad-core' bfd).  There are quite a number of
+   obstacles to being able to view the contents of the floating point
+   registers, and until these are solved you will not be able to view the
+   contents of them.  Actually, you can read in the core file and look at
+   the contents of the user struct to find out what the floating point
+   registers contain.
+   The actual file contents are as follows:
+   UPAGE: 1 page consisting of a user struct that tells gdb what is present
+   in the file.  Directly after this is a copy of the task_struct, which
+   is currently not used by gdb, but it may come in useful at some point.
+   All of the registers are stored as part of the upage.  The upage should
+   always be only one page.
+   DATA: The data area is stored.  We use current->end_text to
+   current->brk to pick up all of the user variables, plus any memory
+   that may have been malloced.  No attempt is made to determine if a page
+   is demand-zero or if a page is totally unused, we just cover the entire
+   range.  All of the addresses are rounded in such a way that an integral
+   number of pages is written.
+   STACK: We need the stack information in order to get a meaningful
+   backtrace.  We need to write the data from (esp) to
+   current->start_stack, so we round each of these off in order to be able
+   to write an integer number of pages.
+   The minimum core file size is 3 pages, or 12288 bytes.
+*/
+
+struct user_fp {
+	struct fp_reg {
+		unsigned int sign1:1;
+		unsigned int unused:15;
+		unsigned int sign2:1;
+		unsigned int exponent:14;
+		unsigned int j:1;
+		unsigned int mantissa1:31;
+		unsigned int mantissa0:32;
+	} fpregs[8];
+	unsigned int fpsr:32;
+	unsigned int fpcr:32;
+	unsigned char ftype[8];
+	unsigned int init_flag;
+};
+
+typedef struct user_fp elf_fpregset_t;
+
+struct elf32_hdr;
+#define elf_check_arch(x)		((x)->e_machine == EM_NDS32)
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS32
+#ifdef __NDS32_EB__
+#define ELF_DATA	ELFDATA2MSB;
+#else
+#define ELF_DATA	ELFDATA2LSB;
+#endif
+#define ELF_ARCH	EM_NDS32
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE	PAGE_SIZE
+
+/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+   use of this is to invoke "./ld.so someprog" to test out a new version of
+   the loader.  We need to make sure that it is out of the way of the program
+   that it will "exec", and that there is sufficient room for the brk.  */
+
+#define ELF_ET_DYN_BASE	(2 * TASK_SIZE / 3)
+
+/* When the program starts, a1 contains a pointer to a function to be
+   registered with atexit, as per the SVR4 ABI.  A value of 0 means we
+   have no such handler.  */
+#define ELF_PLAT_INIT(_r, load_addr)	(_r)->uregs[0] = 0
+
+/* This yields a mask that user programs can use to figure out what
+   instruction set this cpu supports. */
+
+#define ELF_HWCAP	(elf_hwcap)
+
+#ifdef __KERNEL__
+
+#define ELF_PLATFORM    (NULL)
+
+/* Old NetWinder binaries were compiled in such a way that the iBCS
+   heuristic always trips on them.  Until these binaries become uncommon
+   enough not to care, don't trust the `ibcs' flag here.  In any case
+   there is no other ELF system currently supported by iBCS.
+   @@ Could print a warning message to encourage users to upgrade.  */
+#define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
+
+#endif
+
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
+		    (elf_addr_t)current->mm->context.vdso);	\
+} while (0)
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+int arch_setup_additional_pages(struct linux_binprm *, int);
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
new file mode 100644
index 0000000..56043ce
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* VDSO location */
+#define AT_SYSINFO_EHDR	33
+
+#define AT_VECTOR_SIZE_ARCH 1
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/param.h b/arch/nds32/include/uapi/asm/param.h
new file mode 100644
index 0000000..e3fb723
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/param.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_PARAM_H
+#define __ASM_NDS32_PARAM_H
+
+#define EXEC_PAGESIZE	8192
+
+#include <asm-generic/param.h>
+
+#endif /* __ASM_NDS32_PARAM_H */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
