From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/9] RISC-V: ELF and module implementation
Date: Tue,  4 Jul 2017 12:50:57 -0700
Message-ID: <20170704195102.3974-5-palmer@dabbelt.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170704195102.3974-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

This patch contains the code that interfaces with ELF objects on RISC-V
systems, the vast majority of which is present to load kernel modules.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/compat.h | 29 ++++++++++++++
 arch/riscv/include/asm/elf.h    | 83 +++++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/hwcap.h  | 37 ++++++++++++++++++
 arch/riscv/mm/extable.c         | 37 ++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 arch/riscv/include/asm/compat.h
 create mode 100644 arch/riscv/include/asm/elf.h
 create mode 100644 arch/riscv/include/asm/hwcap.h
 create mode 100644 arch/riscv/mm/extable.c

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
new file mode 100644
index 000000000000..044aecff8854
--- /dev/null
+++ b/arch/riscv/include/asm/compat.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_COMPAT_H
+#define __ASM_COMPAT_H
+#ifdef CONFIG_COMPAT
+
+#if defined(CONFIG_64BIT)
+#define COMPAT_UTS_MACHINE "riscv64\0\0"
+#elif defined(CONFIG_32BIT)
+#define COMPAT_UTS_MACHINE "riscv32\0\0"
+#else
+#error "Unknown RISC-V base ISA"
+#endif
+
+#endif /*CONFIG_COMPAT*/
+#endif /*__ASM_COMPAT_H*/
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
new file mode 100644
index 000000000000..5ded3f6f83ea
--- /dev/null
+++ b/arch/riscv/include/asm/elf.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
+ * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _ASM_RISCV_ELF_H
+#define _ASM_RISCV_ELF_H
+
+#include <uapi/asm/elf.h>
+#include <asm/auxvec.h>
+#include <asm/byteorder.h>
+
+/* TODO: Move definition into include/uapi/linux/elf-em.h */
+#define EM_RISCV	0xF3
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_ARCH	EM_RISCV
+
+#ifdef CONFIG_64BIT
+#define ELF_CLASS	ELFCLASS64
+#else
+#define ELF_CLASS	ELFCLASS32
+#endif
+
+#if defined(__LITTLE_ENDIAN)
+#define ELF_DATA	ELFDATA2LSB
+#elif defined(__BIG_ENDIAN)
+#define ELF_DATA	ELFDATA2MSB
+#else
+#error "Unknown endianness"
+#endif
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+
+#define CORE_DUMP_USE_REGSET
+#define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
+
+/*
+ * This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+ * use of this is to invoke "./ld.so someprog" to test out a new version of
+ * the loader.  We need to make sure that it is out of the way of the program
+ * that it will "exec", and that there is sufficient room for the brk.
+ */
+#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
+
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this CPU supports.  This could be done in user space,
+ * but it's not easy, and we've already done it here.
+ */
+#define ELF_HWCAP	(0)
+
+/*
+ * This yields a string that ld.so will use to load implementation
+ * specific libraries for optimization.  This is more specific in
+ * intent than poking at uname or /proc/cpuinfo.
+ */
+#define ELF_PLATFORM	(NULL)
+
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
+		(elf_addr_t)current->mm->context.vdso);		\
+} while (0)
+
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+	int uses_interp);
+
+#endif /* _ASM_RISCV_ELF_H */
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
new file mode 100644
index 000000000000..8a4ed7bbcbea
--- /dev/null
+++ b/arch/riscv/include/asm/hwcap.h
@@ -0,0 +1,37 @@
+/*
+ * Copied from arch/arm64/include/asm/hwcap.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_HWCAP_H
+#define __ASM_HWCAP_H
+
+#include <uapi/asm/hwcap.h>
+
+#ifndef __ASSEMBLY__
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this cpu supports.
+ */
+#define ELF_HWCAP		(elf_hwcap)
+
+enum {
+	CAP_HWCAP = 1,
+};
+
+extern unsigned long elf_hwcap;
+#endif
+#endif
diff --git a/arch/riscv/mm/extable.c b/arch/riscv/mm/extable.c
new file mode 100644
index 000000000000..11bb9417123b
--- /dev/null
+++ b/arch/riscv/mm/extable.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2013 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+
+#include <linux/extable.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+
+int fixup_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(regs->sepc);
+	if (fixup) {
+		regs->sepc = fixup->fixup;
+		return 1;
+	}
+	return 0;
+}
-- 
2.13.0
