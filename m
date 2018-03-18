From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 08/19] csky: ELF and module probe
Date: Mon, 19 Mar 2018 03:51:30 +0800
Message-ID: <9cff9d50d77972e9a4952eefd26bb372b2325d83.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/elf.h | 151 ++++++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/module.c   | 130 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 281 insertions(+)
 create mode 100644 arch/csky/include/asm/elf.h
 create mode 100644 arch/csky/kernel/module.c

diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
new file mode 100644
index 0000000..f63a45d
--- /dev/null
+++ b/arch/csky/include/asm/elf.h
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASMCSKY_ELF_H
+#define __ASMCSKY_ELF_H
+
+/*
+ * ELF register definitions..
+ */
+
+#include <asm/ptrace.h>
+#include <asm/user.h>
+#include <abi/regdef.h>
+
+#define ELF_ARCH 39
+
+/* CSKY Relocations */
+#define R_CSKY_NONE               0
+#define R_CSKY_32                 1
+#define R_CSKY_PCIMM8BY4          2
+#define R_CSKY_PCIMM11BY2         3
+#define R_CSKY_PCIMM4BY2          4
+#define R_CSKY_PC32               5
+#define R_CSKY_PCRELJSR_IMM11BY2  6
+#define R_CSKY_GNU_VTINHERIT      7
+#define R_CSKY_GNU_VTENTRY        8
+#define R_CSKY_RELATIVE           9
+#define R_CSKY_COPY               10
+#define R_CSKY_GLOB_DAT           11
+#define R_CSKY_JUMP_SLOT          12
+#define R_CSKY_ADDR_HI16          24
+#define R_CSKY_ADDR_LO16          25
+#define R_CSKY_PCRELJSR_IMM26BY2  40
+
+typedef unsigned long elf_greg_t;
+
+
+#define ELF_NGREG (sizeof(struct pt_regs) / sizeof(elf_greg_t))
+
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef struct user_cskyfp_struct elf_fpregset_t;
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ((x)->e_machine == ELF_ARCH)
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE		4096
+#define ELF_CLASS			ELFCLASS32
+#define ELF_PLAT_INIT(_r, load_addr)	_r->a0 = 0
+
+#ifdef  __cskyBE__
+#define ELF_DATA	ELFDATA2MSB
+#else
+#define ELF_DATA	ELFDATA2LSB
+#endif
+
+/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+   use of this is to invoke "./ld.so someprog" to test out a new version of
+   the loader.  We need to make sure that it is out of the way of the program
+   that it will "exec", and that there is sufficient room for the brk.  */
+
+#define ELF_ET_DYN_BASE	0x0UL
+
+/* The member sort in array pr_reg[x] is pc, r1, r0, psr, r2, r3,r4,
+   r5, r6...... Because GDB difine */
+#if defined(__CSKYABIV2__)
+   #define ELF_CORE_COPY_REGS(pr_reg, regs)     \
+        pr_reg[0] = regs->pc;                   \
+        pr_reg[1] = regs->a1;                   \
+        pr_reg[2] = regs->a0;                   \
+        pr_reg[3] = regs->sr;                   \
+        pr_reg[4] = regs->a2;                   \
+        pr_reg[5] = regs->a3;                   \
+        pr_reg[6] = regs->regs[0];              \
+        pr_reg[7] = regs->regs[1];              \
+        pr_reg[8] = regs->regs[2];              \
+        pr_reg[9] = regs->regs[3];              \
+        pr_reg[10] = regs->regs[4];             \
+        pr_reg[11] = regs->regs[5];             \
+        pr_reg[12] = regs->regs[6];             \
+        pr_reg[13] = regs->regs[7];             \
+        pr_reg[14] = regs->regs[8];             \
+        pr_reg[15] = regs->regs[9];             \
+        pr_reg[16] = rdusp();		        \
+        pr_reg[17] = regs->r15;                 \
+        pr_reg[18] = regs->exregs[0];           \
+        pr_reg[19] = regs->exregs[1];           \
+        pr_reg[20] = regs->exregs[2];           \
+        pr_reg[21] = regs->exregs[3];           \
+        pr_reg[22] = regs->exregs[4];           \
+        pr_reg[23] = regs->exregs[5];           \
+        pr_reg[24] = regs->exregs[6];           \
+        pr_reg[25] = regs->exregs[7];           \
+        pr_reg[26] = regs->exregs[8];           \
+        pr_reg[27] = regs->exregs[9];           \
+        pr_reg[28] = regs->exregs[10];          \
+        pr_reg[29] = regs->exregs[11];          \
+        pr_reg[30] = regs->exregs[12];          \
+        pr_reg[31] = regs->exregs[13];          \
+        pr_reg[32] = regs->exregs[14];          \
+        pr_reg[33] = regs->exregs[15];
+#else
+     #define ELF_CORE_COPY_REGS(pr_reg, regs)   \
+        pr_reg[0] = regs->pc;                   \
+        pr_reg[1] = regs->regs[9];              \
+        pr_reg[2] = rdusp();                    \
+        pr_reg[3] = regs->sr;                   \
+        pr_reg[4] = regs->a0;                   \
+        pr_reg[5] = regs->a1;                   \
+        pr_reg[6] = regs->a2;                   \
+        pr_reg[7] = regs->a3;                   \
+        pr_reg[8] = regs->regs[0];              \
+        pr_reg[9] = regs->regs[1];              \
+        pr_reg[10] = regs->regs[2];             \
+        pr_reg[11] = regs->regs[3];             \
+        pr_reg[12] = regs->regs[4];             \
+        pr_reg[13] = regs->regs[5];             \
+        pr_reg[14] = regs->regs[6];             \
+        pr_reg[15] = regs->regs[7];             \
+        pr_reg[16] = regs->regs[8];             \
+        pr_reg[17] = regs->r15;
+#endif
+
+/* Similar, but for a thread other than current. */
+struct task_struct;
+extern int dump_task_regs(struct task_struct *, elf_gregset_t *);
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
+
+/* This yields a mask that user programs can use to figure out what
+   instruction set this cpu supports.  */
+
+#define ELF_HWCAP	(0)
+
+/* This yields a string that ld.so will use to load implementation
+   specific libraries for optimization.  This is more specific in
+   intent than poking at uname or /proc/cpuinfo.  */
+
+#define ELF_PLATFORM	(NULL)
+#define SET_PERSONALITY(ex) set_personality(PER_LINUX)
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+extern int arch_setup_additional_pages(
+		struct linux_binprm *bprm,
+		int uses_interp);
+
+#endif
diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
new file mode 100644
index 0000000..ca68315
--- /dev/null
+++ b/arch/csky/kernel/module.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/moduleloader.h>
+#include <linux/elf.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <asm/pgtable.h>
+
+#define IS_BSR32(hi16, lo16)        (((hi16) & 0xFC00) == 0xE000)
+#define IS_JSRI32(hi16, lo16)       ((hi16) == 0xEAE0)
+#define CHANGE_JSRI_TO_LRW(addr)    *(uint16_t *)(addr) = (*(uint16_t *)(addr) & 0xFF9F) | 0x0019; \
+							  *((uint16_t *)(addr) + 1) = *((uint16_t *)(addr) + 1) & 0xFFFF
+#define SET_JSR32_R25(addr)         *(uint16_t *)(addr) = 0xE8F9; \
+							  *((uint16_t *)(addr) + 1) = 0x0000;
+
+int apply_relocate(Elf_Shdr *sechdrs, const char *strtab, unsigned int symindex,
+		unsigned int relsec, struct module *me)
+{
+	unsigned int i;
+	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_addr;
+	Elf32_Sym *sym;
+	uint32_t *location;
+	short * temp;
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
+			+ ELF32_R_SYM(rel[i].r_info);
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_CSKY_NONE:
+		case R_CSKY_PCRELJSR_IMM11BY2:
+		case R_CSKY_PCRELJSR_IMM26BY2:
+			/* ignore */
+			break;
+		case R_CSKY_32:
+			/* We add the value into the location given */
+			*location += sym->st_value;
+			break;
+		case R_CSKY_PC32:
+			/* Add the value, subtract its postition */
+			*location += sym->st_value - (uint32_t)location;
+			break;
+		case R_CSKY_ADDR_HI16:
+			temp = ((short  *)location) + 1;
+			*temp = (short)((sym->st_value) >> 16);
+			break;
+		case R_CSKY_ADDR_LO16:
+			temp = ((short  *)location) + 1;
+			*temp = (short)((sym->st_value) & 0xffff);
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %u\n",
+					me->name, ELF32_R_TYPE(rel[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+}
+
+int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
+		unsigned int symindex, unsigned int relsec, struct module *me)
+{
+	unsigned int i;
+	Elf32_Rela *rel = (void *)sechdrs[relsec].sh_addr;
+	Elf32_Sym *sym;
+	uint32_t *location;
+	short * temp;
+#ifdef CONFIG_CPU_CSKYV2
+	uint16_t *location_tmp;
+#endif
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to.  Note that all
+		   undefined symbols have been resolved.  */
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
+			+ ELF32_R_SYM(rel[i].r_info);
+
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_CSKY_32:
+			/* We add the value into the location given */
+			*location = rel[i].r_addend + sym->st_value;
+			break;
+		case R_CSKY_PC32:
+			/* Add the value, subtract its postition */
+			*location = rel[i].r_addend + sym->st_value
+				- (uint32_t)location;
+			break;
+		case R_CSKY_PCRELJSR_IMM11BY2:
+			break;
+		case R_CSKY_PCRELJSR_IMM26BY2:
+#ifdef CONFIG_CPU_CSKYV2
+			location_tmp = (uint16_t *)location;
+			if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
+				break;
+			else if (IS_JSRI32(*location_tmp, *(location_tmp + 1))) {
+				/* jsri 0x...  --> lrw r25, 0x... */
+				CHANGE_JSRI_TO_LRW(location);
+				/* lsli r0, r0 --> jsr r25 */
+				SET_JSR32_R25(location + 1);
+			}
+#endif
+			break;
+		case R_CSKY_ADDR_HI16:
+			temp = ((short  *)location) + 1;
+			*temp = (short)((rel[i].r_addend + sym->st_value) >> 16);
+			break;
+		case R_CSKY_ADDR_LO16:
+			temp = ((short  *)location) + 1;
+			*temp = (short)((rel[i].r_addend + sym->st_value) & 0xffff);
+			break;
+		default:
+			printk(KERN_ERR "module %s: Unknown relocation: %u\n",
+					me->name, ELF32_R_TYPE(rel[i].r_info));
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+}
-- 
2.7.4
