Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55191 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863Ab2HNRxJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:09 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 16/31] arm64: ELF definitions
Date: Tue, 14 Aug 2012 18:52:17 +0100
Message-ID: <1344966752-16102-17-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175217.uduDqAJO5dqSzenKEAciJ-jdjRBwnBXE4VGhICkLVyU@z>

This patch adds definitions for the ELF format, including personality
personality setting and EXEC_PAGESIZE. The are only two hwcap
definitions for 64-bit applications - HWCAP_FP and HWCAP_ASIMD.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/auxvec.h   |   22 +++++
 arch/arm64/include/asm/elf.h      |  176 +++++++++++++++++++++++++++++++++=
++++
 arch/arm64/include/asm/hwcap.h    |   57 ++++++++++++
 arch/arm64/include/asm/param.h    |   23 +++++
 arch/arm64/include/asm/shmparam.h |   28 ++++++
 arch/arm64/kernel/elf.c           |   41 +++++++++
 6 files changed, 347 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/auxvec.h
 create mode 100644 arch/arm64/include/asm/elf.h
 create mode 100644 arch/arm64/include/asm/hwcap.h
 create mode 100644 arch/arm64/include/asm/param.h
 create mode 100644 arch/arm64/include/asm/shmparam.h
 create mode 100644 arch/arm64/kernel/elf.c

diff --git a/arch/arm64/include/asm/auxvec.h b/arch/arm64/include/asm/auxve=
c.h
new file mode 100644
index 0000000..22d6d88
--- /dev/null
+++ b/arch/arm64/include/asm/auxvec.h
@@ -0,0 +1,22 @@
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
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* vDSO location */
+#define AT_SYSINFO_EHDR=0933
+
+#endif
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
new file mode 100644
index 0000000..9d62a7a
--- /dev/null
+++ b/arch/arm64/include/asm/elf.h
@@ -0,0 +1,176 @@
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
+#ifndef __ASM_ELF_H
+#define __ASM_ELF_H
+
+#include <asm/hwcap.h>
+
+/*
+ * ELF register definitions..
+ */
+#include <asm/ptrace.h>
+#include <asm/user.h>
+
+typedef unsigned long elf_greg_t;
+typedef unsigned long elf_freg_t[3];
+
+#define ELF_NGREG (sizeof (struct pt_regs) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef struct user_fp elf_fpregset_t;
+
+#define EM_AARCH64=09=09183
+
+/*
+ * AArch64 static relocation types.
+ */
+
+/* Miscellaneous. */
+#define R_ARM_NONE=09=09=090
+#define R_AARCH64_NONE=09=09=09256
+
+/* Data. */
+#define R_AARCH64_ABS64=09=09=09257
+#define R_AARCH64_ABS32=09=09=09258
+#define R_AARCH64_ABS16=09=09=09259
+#define R_AARCH64_PREL64=09=09260
+#define R_AARCH64_PREL32=09=09261
+#define R_AARCH64_PREL16=09=09262
+
+/* Instructions. */
+#define R_AARCH64_MOVW_UABS_G0=09=09263
+#define R_AARCH64_MOVW_UABS_G0_NC=09264
+#define R_AARCH64_MOVW_UABS_G1=09=09265
+#define R_AARCH64_MOVW_UABS_G1_NC=09266
+#define R_AARCH64_MOVW_UABS_G2=09=09267
+#define R_AARCH64_MOVW_UABS_G2_NC=09268
+#define R_AARCH64_MOVW_UABS_G3=09=09269
+
+#define R_AARCH64_MOVW_SABS_G0=09=09270
+#define R_AARCH64_MOVW_SABS_G1=09=09271
+#define R_AARCH64_MOVW_SABS_G2=09=09272
+
+#define R_AARCH64_LD_PREL_LO19=09=09273
+#define R_AARCH64_ADR_PREL_LO21=09=09274
+#define R_AARCH64_ADR_PREL_PG_HI21=09275
+#define R_AARCH64_ADR_PREL_PG_HI21_NC=09276
+#define R_AARCH64_ADD_ABS_LO12_NC=09277
+#define R_AARCH64_LDST8_ABS_LO12_NC=09278
+
+#define R_AARCH64_TSTBR14=09=09279
+#define R_AARCH64_CONDBR19=09=09280
+#define R_AARCH64_JUMP26=09=09282
+#define R_AARCH64_CALL26=09=09283
+#define R_AARCH64_LDST16_ABS_LO12_NC=09284
+#define R_AARCH64_LDST32_ABS_LO12_NC=09285
+#define R_AARCH64_LDST64_ABS_LO12_NC=09286
+#define R_AARCH64_LDST128_ABS_LO12_NC=09299
+
+#define R_AARCH64_MOVW_PREL_G0=09=09287
+#define R_AARCH64_MOVW_PREL_G0_NC=09288
+#define R_AARCH64_MOVW_PREL_G1=09=09289
+#define R_AARCH64_MOVW_PREL_G1_NC=09290
+#define R_AARCH64_MOVW_PREL_G2=09=09291
+#define R_AARCH64_MOVW_PREL_G2_NC=09292
+#define R_AARCH64_MOVW_PREL_G3=09=09293
+
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS=09ELFCLASS64
+#define ELF_DATA=09ELFDATA2LSB
+#define ELF_ARCH=09EM_AARCH64
+
+#define ELF_PLATFORM_SIZE=0916
+#define ELF_PLATFORM=09=09("aarch64")
+
+/*
+ * This is used to ensure we don't load something for the wrong architectu=
re.
+ */
+#define elf_check_arch(x)=09=09((x)->e_machine =3D=3D EM_AARCH64)
+
+#define elf_read_implies_exec(ex,stk)=09(stk !=3D EXSTACK_DISABLE_X)
+
+#define CORE_DUMP_USE_REGSET
+#define ELF_EXEC_PAGESIZE=09PAGE_SIZE
+
+/*
+ * This is the location that an ET_DYN program is loaded if exec'ed.  Typi=
cal
+ * use of this is to invoke "./ld.so someprog" to test out a new version o=
f
+ * the loader.  We need to make sure that it is out of the way of the prog=
ram
+ * that it will "exec", and that there is sufficient room for the brk.
+ */
+extern unsigned long randomize_et_dyn(unsigned long base);
+#define ELF_ET_DYN_BASE=09(randomize_et_dyn(2 * TASK_SIZE_64 / 3))
+
+/*
+ * When the program starts, a1 contains a pointer to a function to be
+ * registered with atexit, as per the SVR4 ABI.  A value of 0 means we hav=
e no
+ * such handler.
+ */
+#define ELF_PLAT_INIT(_r, load_addr)=09(_r)->regs[0] =3D 0
+
+extern void=09=09=09=09elf_set_personality(int personality);
+#define SET_PERSONALITY(ex)=09=09elf_set_personality(PER_LINUX)
+
+#define ARCH_DLINFO=09=09=09=09=09=09=09\
+do {=09=09=09=09=09=09=09=09=09\
+=09NEW_AUX_ENT(AT_SYSINFO_EHDR,=09=09=09=09=09\
+=09=09    (elf_addr_t)current->mm->context.vdso);=09=09\
+} while (0)
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+=09=09=09=09       int uses_interp);
+
+/* 1GB of VA */
+#define STACK_RND_MASK=09=09=09(test_thread_flag(TIF_32BIT) ? \
+=09=09=09=09=09=090x7ff >> (PAGE_SHIFT - 12) : \
+=09=09=09=09=09=090x3ffff >> (PAGE_SHIFT - 12))
+
+struct mm_struct;
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+#define arch_randomize_brk arch_randomize_brk
+
+#ifdef CONFIG_AARCH32_EMULATION
+#define EM_ARM=09=09=09=0940
+#define COMPAT_ELF_PLATFORM=09=09("v8l")
+
+#define COMPAT_ELF_ET_DYN_BASE=09=09(randomize_et_dyn(2 * TASK_SIZE_32 / 3=
))
+
+/* AArch32 registers. */
+#define COMPAT_ELF_NGREG=09=0918
+typedef unsigned int=09=09=09compat_elf_greg_t;
+typedef compat_elf_greg_t=09=09compat_elf_gregset_t[COMPAT_ELF_NGREG];
+
+/* AArch32 EABI. */
+#define EF_ARM_EABI_MASK=09=090xff000000
+#define compat_elf_check_arch(x)=09(((x)->e_machine =3D=3D EM_ARM) && \
+=09=09=09=09=09 ((x)->e_flags & EF_ARM_EABI_MASK))
+
+#define compat_start_thread=09=09compat_start_thread
+#define COMPAT_SET_PERSONALITY(ex)=09elf_set_personality(PER_LINUX32)
+#define COMPAT_ARCH_DLINFO
+extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
+=09=09=09=09      int uses_interp);
+#define compat_arch_setup_additional_pages \
+=09=09=09=09=09aarch32_setup_vectors_page
+
+#endif /* CONFIG_AARCH32_EMULATION */
+
+#endif
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.=
h
new file mode 100644
index 0000000..0cc7c03
--- /dev/null
+++ b/arch/arm64/include/asm/hwcap.h
@@ -0,0 +1,57 @@
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
+#ifndef __ASM_HWCAP_H
+#define __ASM_HWCAP_H
+
+/*
+ * HWCAP flags - for elf_hwcap (in kernel) and AT_HWCAP
+ */
+#define HWCAP_FP=09=09(1 << 0)
+#define HWCAP_ASIMD=09=09(1 << 1)
+
+#ifdef CONFIG_AARCH32_EMULATION
+#define COMPAT_HWCAP_HALF=09(1 << 1)
+#define COMPAT_HWCAP_THUMB=09(1 << 2)
+#define COMPAT_HWCAP_FAST_MULT=09(1 << 4)
+#define COMPAT_HWCAP_VFP=09(1 << 6)
+#define COMPAT_HWCAP_EDSP=09(1 << 7)
+#define COMPAT_HWCAP_NEON=09(1 << 12)
+#define COMPAT_HWCAP_VFPv3=09(1 << 13)
+#define COMPAT_HWCAP_TLS=09(1 << 15)
+#define COMPAT_HWCAP_VFPv4=09(1 << 16)
+#define COMPAT_HWCAP_IDIVA=09(1 << 17)
+#define COMPAT_HWCAP_IDIVT=09(1 << 18)
+#define COMPAT_HWCAP_IDIV=09(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
+
+#endif /* CONFIG_AARCH32_EMULATION */
+
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this cpu supports.
+ */
+#define ELF_HWCAP=09=09(elf_hwcap)
+#ifdef CONFIG_AARCH32_EMULATION
+#define COMPAT_ELF_HWCAP=09(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
+=09=09=09=09 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
+=09=09=09=09 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
+=09=09=09=09 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
+=09=09=09=09 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV)
+#endif
+extern unsigned int elf_hwcap;
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/param.h b/arch/arm64/include/asm/param.=
h
new file mode 100644
index 0000000..8e3a281
--- /dev/null
+++ b/arch/arm64/include/asm/param.h
@@ -0,0 +1,23 @@
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
+#ifndef __ASM_PARAM_H
+#define __ASM_PARAM_H
+
+#define EXEC_PAGESIZE=0965536
+
+#include <asm-generic/param.h>
+
+#endif
diff --git a/arch/arm64/include/asm/shmparam.h b/arch/arm64/include/asm/shm=
param.h
new file mode 100644
index 0000000..4df608a
--- /dev/null
+++ b/arch/arm64/include/asm/shmparam.h
@@ -0,0 +1,28 @@
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
+#ifndef __ASM_SHMPARAM_H
+#define __ASM_SHMPARAM_H
+
+/*
+ * For IPC syscalls from compat tasks, we need to use the legacy 16k
+ * alignment value. Since we don't have aliasing D-caches, the rest of
+ * the time we can safely use PAGE_SIZE.
+ */
+#define COMPAT_SHMLBA=090x4000
+
+#include <asm-generic/shmparam.h>
+
+#endif /* __ASM_SHMPARAM_H */
diff --git a/arch/arm64/kernel/elf.c b/arch/arm64/kernel/elf.c
new file mode 100644
index 0000000..6f98076
--- /dev/null
+++ b/arch/arm64/kernel/elf.c
@@ -0,0 +1,41 @@
+/*
+ * ELF personality setting
+ *
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
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/personality.h>
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+
+void elf_set_personality(int personality)
+{
+=09switch (personality & PER_MASK) {
+=09case PER_LINUX:
+=09=09clear_thread_flag(TIF_32BIT);
+=09=09break;
+=09case PER_LINUX32:
+=09=09set_thread_flag(TIF_32BIT);
+=09=09break;
+=09default:
+=09=09pr_warning("Process %s tried to assume unknown personality %d\n",
+=09=09=09   current->comm, personality);
+=09=09return;
+=09}
+
+=09current->personality =3D personality;
+}
+EXPORT_SYMBOL(elf_set_personality);

