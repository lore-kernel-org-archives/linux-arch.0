Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54930 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab2HNRxF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:05 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 02/31] arm64: Kernel booting and initialisation
Date: Tue, 14 Aug 2012 18:52:03 +0100
Message-ID: <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175203.VQdxOd-bY7G8vwJDSJ5GPEMYNFzlsgBYXZqqSDxm850@z>

The patch adds the kernel booting and the initial setup code.
Documentation/arm64/booting.txt describes the booting protocol on the
AArch64 Linux kernel. This is subject to change following the work on
boot standardisation, ACPI.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/booting.txt |  141 +++++++++++
 arch/arm64/include/asm/setup.h  |   26 ++
 arch/arm64/kernel/head.S        |  521 +++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/setup.c       |  357 +++++++++++++++++++++++++++
 4 files changed, 1045 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm64/booting.txt
 create mode 100644 arch/arm64/include/asm/setup.h
 create mode 100644 arch/arm64/kernel/head.S
 create mode 100644 arch/arm64/kernel/setup.c

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.=
txt
new file mode 100644
index 0000000..3197820
--- /dev/null
+++ b/Documentation/arm64/booting.txt
@@ -0,0 +1,141 @@
+=09=09=09Booting AArch64 Linux
+=09=09=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Author: Will Deacon <will.deacon@arm.com>
+Date  : 25 April 2012
+
+This document is based on the ARM booting document by Russell King and
+is relevant to all public releases of the AArch64 Linux kernel.
+
+The AArch64 exception model is made up of a number of exception levels
+(EL0 - EL3), with EL0 and EL1 having a secure and a non-secure
+counterpart.  EL2 is the hypervisor level and exists only in non-secure
+mode. EL3 is the highest priority level and exists only in secure mode.
+
+For the purposes of this document, we will use the term `boot loader'
+simply to define all software that executes on the CPU(s) before control
+is passed to the Linux kernel.  This may include secure monitor and
+hypervisor code, or it may just be a handful of instructions for
+preparing a minimal boot environment.
+
+Essentially, the boot loader should provide (as a minimum) the
+following:
+
+1. Setup and initialise the RAM
+2. Setup the device tree
+3. Decompress the kernel image
+4. Call the kernel image
+
+
+1. Setup and initialise RAM
+---------------------------
+
+Requirement: MANDATORY
+
+The boot loader is expected to find and initialise all RAM that the
+kernel will use for volatile data storage in the system.  It performs
+this in a machine dependent manner.  (It may use internal algorithms
+to automatically locate and size all RAM, or it may use knowledge of
+the RAM in the machine, or any other method the boot loader designer
+sees fit.)
+
+
+2. Setup the device tree
+-------------------------
+
+Requirement: MANDATORY
+
+The device tree blob (dtb) must be no bigger than 2 megabytes in size
+and placed at a 2-megabyte boundary within the first 512 megabytes from
+the start of the kernel image. This is to allow the kernel to map the
+blob using a single section mapping in the initial page tables.
+
+
+3. Decompress the kernel image
+------------------------------
+
+Requirement: OPTIONAL
+
+The AArch64 kernel does not provide a decompressor and therefore
+requires gzip decompression to be performed by the boot loader if the
+default Image.gz target is used.  For bootloaders that do not implement
+this requirement, the larger Image target is available instead.
+
+
+4. Call the kernel image
+------------------------
+
+Requirement: MANDATORY
+
+The decompressed kernel image contains a 32-byte header as follows:
+
+  u32 magic=09=3D 0x14000008;=09/* branch to stext, little-endian */
+  u32 res0=09=3D 0;=09=09/* reserved */
+  u64 text_offset;=09=09/* Image load offset */
+  u64 res1=09=3D 0;=09=09/* reserved */
+  u64 res2=09=3D 0;=09=09/* reserved */
+
+The image must be placed at the specified offset (currently 0x80000)
+from the start of the system RAM and called there. The start of the
+system RAM must be aligned to 2MB.
+
+Before jumping into the kernel, the following conditions must be met:
+
+- Quiesce all DMA capable devices so that memory does not get
+  corrupted by bogus network packets or disk data.  This will save
+  you many hours of debug.
+
+- Primary CPU general-purpose register settings
+  x0 =3D physical address of device tree blob (dtb) in system RAM.
+
+- CPU mode
+  All forms of interrupts must be masked in PSTATE.DAIF (Debug, SError,
+  IRQ and FIQ).
+  The CPU must be in either EL2 (RECOMMENDED in order to have access to
+  the virtualisation extensions) or non-secure EL1.
+
+- Caches, MMUs
+  The MMU must be off.
+  Instruction cache may be on or off.
+  Data cache must be off and invalidated.
+
+- Architected timers
+  CNTFRQ must be programmed with the timer frequency.
+  If entering the kernel at EL1, CNTHCTL_EL2 must have EL1PCTEN (bit 0)
+  set where available.
+
+- Coherency
+  All CPUs to be booted by the kernel must be part of the same coherency
+  domain on entry to the kernel.  This may require IMPLEMENTATION DEFINED
+  initialisation to enable the receiving of maintenance operations on
+  each CPU.
+
+- System registers
+  All writable architected system registers at the exception level where
+  the kernel image will be entered must be initialised by software at a
+  higher exception level to prevent execution in an UNKNOWN state.
+
+The boot loader is expected to enter the kernel on each CPU in the
+following manner:
+
+- The primary CPU must jump directly to the first instruction of the
+  kernel image.  The device tree blob passed by this CPU must contain
+  for each CPU node:
+
+    1. An 'enable-method' property. Currently, the only supported value
+       for this field is the string "spin-table".
+
+    2. A 'cpu-release-addr' property identifying a 64-bit,
+       zero-initialised memory location.
+
+  It is expected that the bootloader will generate these device tree
+  properties and insert them into the blob prior to kernel entry.
+
+- Any secondary CPUs must spin outside of the kernel in a reserved area
+  of memory (communicated to the kernel by a /memreserve/ region in the
+  device tree) polling their cpu-release-addr location, which must be
+  contained in the reserved region.  A wfe instruction may be inserted
+  to reduce the overhead of the busy-loop and a sev will be issued by
+  the primary CPU.  When a read of the location pointed to by the
+  cpu-release-addr returns a non-zero value, the CPU must jump directly
+  to this value.
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.=
h
new file mode 100644
index 0000000..d766493
--- /dev/null
+++ b/arch/arm64/include/asm/setup.h
@@ -0,0 +1,26 @@
+/*
+ * Based on arch/arm/include/asm/setup.h
+ *
+ * Copyright (C) 1997-1999 Russell King
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
+#ifndef __ASM_SETUP_H
+#define __ASM_SETUP_H
+
+#include <linux/types.h>
+
+#define COMMAND_LINE_SIZE 1024
+
+#endif
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
new file mode 100644
index 0000000..34ccdc0
--- /dev/null
+++ b/arch/arm64/kernel/head.S
@@ -0,0 +1,521 @@
+/*
+ * Low-level CPU initialisation
+ * Based on arch/arm/kernel/head.S
+ *
+ * Copyright (C) 1994-2002 Russell King
+ * Copyright (C) 2003-2012 ARM Ltd.
+ * Authors:=09Catalin Marinas <catalin.marinas@arm.com>
+ *=09=09Will Deacon <will.deacon@arm.com>
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
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+#include <asm/assembler.h>
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+#include <asm/memory.h>
+#include <asm/thread_info.h>
+#include <asm/pgtable-hwdef.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+
+/*
+ * swapper_pg_dir is the virtual address of the initial page table. We pla=
ce
+ * the page tables 3 * PAGE_SIZE below KERNEL_RAM_VADDR. The idmap_pg_dir =
has
+ * 2 pages and is placed below swapper_pg_dir.
+ */
+#define KERNEL_RAM_VADDR=09(PAGE_OFFSET + TEXT_OFFSET)
+
+#if (KERNEL_RAM_VADDR & 0xfffff) !=3D 0x80000
+#error KERNEL_RAM_VADDR must start at 0xXXX80000
+#endif
+
+#define SWAPPER_DIR_SIZE=09(3 * PAGE_SIZE)
+#define IDMAP_DIR_SIZE=09=09(2 * PAGE_SIZE)
+
+=09.globl=09swapper_pg_dir
+=09.equ=09swapper_pg_dir, KERNEL_RAM_VADDR - SWAPPER_DIR_SIZE
+
+=09.globl=09idmap_pg_dir
+=09.equ=09idmap_pg_dir, swapper_pg_dir - IDMAP_DIR_SIZE
+
+=09.macro=09pgtbl, ttb0, ttb1, phys
+=09add=09\ttb1, \phys, #TEXT_OFFSET - SWAPPER_DIR_SIZE
+=09sub=09\ttb0, \ttb1, #IDMAP_DIR_SIZE
+=09.endm
+
+#ifdef CONFIG_ARM64_64K_PAGES
+#define BLOCK_SHIFT=09PAGE_SHIFT
+#define BLOCK_SIZE=09PAGE_SIZE
+#else
+#define BLOCK_SHIFT=09SECTION_SHIFT
+#define BLOCK_SIZE=09SECTION_SIZE
+#endif
+
+#define KERNEL_START=09KERNEL_RAM_VADDR
+#define KERNEL_END=09_end
+
+/*
+ * Initial memory map attributes.
+ */
+#ifndef CONFIG_SMP
+#define PTE_FLAGS=09PTE_ATTRINDX(MT_NORMAL) | PTE_AF
+#define PMD_FLAGS=09PMD_ATTRINDX(MT_NORMAL) | PMD_SECT_AF
+#else
+#define PTE_FLAGS=09PTE_ATTRINDX(MT_NORMAL) | PTE_AF | PTE_SHARED
+#define PMD_FLAGS=09PMD_ATTRINDX(MT_NORMAL) | PMD_SECT_AF | PMD_SECT_S
+#endif
+
+#ifdef CONFIG_ARM64_64K_PAGES
+#define MM_MMUFLAGS=09PTE_TYPE_PAGE | PTE_FLAGS
+#define IO_MMUFLAGS=09PTE_TYPE_PAGE | PTE_XN | PTE_FLAGS
+#else
+#define MM_MMUFLAGS=09PMD_TYPE_SECT | PMD_FLAGS
+#define IO_MMUFLAGS=09PMD_TYPE_SECT | PMD_SECT_XN | PMD_FLAGS
+#endif
+
+/*
+ * Kernel startup entry point.
+ * ---------------------------
+ *
+ * The requirements are:
+ *   MMU =3D off, D-cache =3D off, I-cache =3D on or off,
+ *   x0 =3D physical address to the FDT blob.
+ *
+ * This code is mostly position independent so you call this at
+ * __pa(PAGE_OFFSET + TEXT_OFFSET).
+ *
+ * Note that the callee-saved registers are used for storing variables
+ * that are useful before the MMU is enabled. The allocations are describe=
d
+ * in the entry routines.
+ */
+=09__HEAD
+
+=09/*
+=09 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
+=09 */
+=09b=09stext=09=09=09=09// branch to kernel start, magic
+=09.long=090=09=09=09=09// reserved
+=09.quad=09TEXT_OFFSET=09=09=09// Image load offset from start of RAM
+=09.quad=090=09=09=09=09// reserved
+=09.quad=090=09=09=09=09// reserved
+
+ENTRY(stext)
+=09mov=09x21, x0=09=09=09=09// x21=3DFDT
+=09bl=09el2_setup=09=09=09// Drop to EL1
+=09mrs=09x22, midr_el1=09=09=09// x22=3Dcpuid
+=09mov=09x0, x22
+=09bl=09__lookup_processor_type
+=09mov=09x23, x0=09=09=09=09// x23=3Dprocinfo
+=09cbz=09x23, __error_p=09=09=09// invalid processor (x23=3D0)?
+=09bl=09__calc_phys_offset=09=09// x24=3Dphys offset
+=09bl=09__vet_fdt
+=09bl=09__create_page_tables=09=09// x25=3DTTBR0, x26=3DTTBR1
+=09/*
+=09 * The following calls CPU specific code in a position independent
+=09 * manner. See arch/arm64/mm/proc.S for details. x23 =3D base of
+=09 * cpu_proc_info structure selected by __lookup_processor_type above.
+=09 * On return, the CPU will be ready for the MMU to be turned on and
+=09 * the TCR will have been set.
+=09 */
+=09ldr=09x27, __switch_data=09=09// address to jump to after
+=09=09=09=09=09=09// MMU has been enabled
+=09adr=09lr, __enable_mmu=09=09// return (PIC) address
+=09add=09x12, x23, #PROCINFO_INITFUNC
+=09br=09x12=09=09=09=09// initialise processor
+ENDPROC(stext)
+
+/*
+ * If we're fortunate enough to boot at EL2, ensure that the world is
+ * sane before dropping to EL1.
+ */
+ENTRY(el2_setup)
+=09mrs=09x0, CurrentEL
+=09cmp=09x0, #PSR_MODE_EL2t
+=09ccmp=09x0, #PSR_MODE_EL2h, #0x4, ne
+=09b.eq=091f
+=09ret
+
+=09/* Hyp configuration. */
+1:=09mov=09x0, #(1 << 31)=09=09=09// 64-bit EL1
+=09msr=09hcr_el2, x0
+
+=09/* Generic timers. */
+=09mrs=09x0, cnthctl_el2
+=09orr=09x0, x0, #3=09=09=09// Enable EL1 physical timers
+=09msr=09cnthctl_el2, x0
+
+=09/* Populate ID registers. */
+=09mrs=09x0, midr_el1
+=09mrs=09x1, mpidr_el1
+=09msr=09vpidr_el2, x0
+=09msr=09vmpidr_el2, x1
+
+=09/* sctlr_el1 */
+=09mov=09x0, #0x0800=09=09=09// Set/clear RES{1,0} bits
+=09movk=09x0, #0x30d0, lsl #16
+=09msr=09sctlr_el1, x0
+
+=09/* Coprocessor traps. */
+=09mov=09x0, #0x33ff
+=09msr=09cptr_el2, x0=09=09=09// Disable copro. traps to EL2
+
+#ifdef CONFIG_AARCH32_EMULATION
+=09msr=09hstr_el2, xzr=09=09=09// Disable CP15 traps to EL2
+#endif
+
+=09/* spsr */
+=09mov=09x0, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
+=09=09      PSR_MODE_EL1h)
+=09msr=09spsr_el2, x0
+=09msr=09elr_el2, lr
+=09eret
+ENDPROC(el2_setup)
+
+=09.align=093
+2:=09.quad=09.
+=09.quad=09PAGE_OFFSET
+
+#ifdef CONFIG_SMP
+=09.pushsection    .smp.pen.text, "ax"
+=09.align=093
+1:=09.quad=09.
+=09.quad=09secondary_holding_pen_release
+
+=09/*
+=09 * This provides a "holding pen" for platforms to hold all secondary
+=09 * cores are held until we're ready for them to initialise.
+=09 */
+ENTRY(secondary_holding_pen)
+=09bl=09el2_setup=09=09=09// Drop to EL1
+=09mrs=09x0, mpidr_el1
+=09and=09x0, x0, #15=09=09=09// CPU number
+=09adr=09x1, 1b
+=09ldp=09x2, x3, [x1]
+=09sub=09x1, x1, x2
+=09add=09x3, x3, x1
+pen:=09ldr=09x4, [x3]
+=09cmp=09x4, x0
+=09b.eq=09secondary_startup
+=09wfe
+=09b=09pen
+ENDPROC(secondary_holding_pen)
+=09.popsection
+
+ENTRY(secondary_startup)
+=09/*
+=09 * Common entry point for secondary CPUs.
+=09 */
+=09mrs=09x22, midr_el1=09=09=09// x22=3Dcpuid
+=09mov=09x0, x22
+=09bl=09__lookup_processor_type
+=09mov=09x23, x0=09=09=09=09// x23=3Dprocinfo
+=09cbz=09x23, __error_p=09=09=09// invalid processor (x23=3D0)?
+
+=09bl=09__calc_phys_offset=09=09// x24=3Dphys offset
+=09pgtbl=09x25, x26, x24=09=09=09// x25=3DTTBR0, x26=3DTTBR1
+=09add=09x12, x23, #PROCINFO_INITFUNC
+=09blr=09x12=09=09=09=09// initialise processor
+
+=09ldr=09x21, =3Dsecondary_data
+=09ldr=09x27, =3D__secondary_switched=09// address to jump to after enabli=
ng the MMU
+=09b=09__enable_mmu
+ENDPROC(secondary_startup)
+
+ENTRY(__secondary_switched)
+=09ldr=09x0, [x21]=09=09=09// get secondary_data.stack
+=09mov=09sp, x0
+=09mov=09x29, #0
+=09b=09secondary_start_kernel
+ENDPROC(__secondary_switched)
+#endif=09/* CONFIG_SMP */
+
+/*
+ * Setup common bits before finally enabling the MMU. Essentially this is =
just
+ * loading the page table pointer and vector base registers.
+ *
+ * On entry to this code, x0 must contain the SCTLR_EL1 value for turning =
on
+ * the MMU.
+ */
+__enable_mmu:
+=09ldr=09x5, =3Dvectors
+=09msr=09vbar_el1, x5
+=09msr=09ttbr0_el1, x25=09=09=09// load TTBR0
+=09msr=09ttbr1_el1, x26=09=09=09// load TTBR1
+=09isb
+=09b=09__turn_mmu_on
+ENDPROC(__enable_mmu)
+
+/*
+ * Enable the MMU. This completely changes the structure of the visible me=
mory
+ * space. You will not be able to trace execution through this.
+ *
+ *  x0  =3D system control register
+ *  x27 =3D *virtual* address to jump to upon completion
+ *
+ * other registers depend on the function called upon completion
+ */
+=09.align=096
+__turn_mmu_on:
+=09msr=09sctlr_el1, x0
+=09isb
+=09br=09x27
+ENDPROC(__turn_mmu_on)
+
+/*
+ * Calculate the start of physical memory.
+ */
+__calc_phys_offset:
+=09adr=09x0, 1f
+=09ldp=09x1, x2, [x0]
+=09sub=09x3, x0, x1=09=09=09// PHYS_OFFSET - PAGE_OFFSET
+=09add=09x24, x2, x3=09=09=09// x24=3DPHYS_OFFSET
+=09ret
+ENDPROC(__calc_phys_offset)
+
+=09.align 3
+1:=09.quad=09.
+=09.quad=09PAGE_OFFSET
+
+/*
+ * Macro to populate the PGD for the corresponding block entry in the next
+ * level (tbl) for the given virtual address.
+ *
+ * Preserves:=09pgd, tbl, virt
+ * Corrupts:=09tmp1, tmp2
+ */
+=09.macro=09create_pgd_entry, pgd, tbl, virt, tmp1, tmp2
+=09lsr=09\tmp1, \virt, #PGDIR_SHIFT
+=09and=09\tmp1, \tmp1, #PTRS_PER_PGD - 1=09// PGD index
+=09orr=09\tmp2, \tbl, #3=09=09=09// PGD entry table type
+=09str=09\tmp2, [\pgd, \tmp1, lsl #3]
+=09.endm
+
+/*
+ * Macro to populate block entries in the page table for the start..end
+ * virtual range (inclusive).
+ *
+ * Preserves:=09tbl, flags
+ * Corrupts:=09phys, start, end, pstate
+ */
+=09.macro=09create_block_map, tbl, flags, phys, start, end, idmap=3D0
+=09lsr=09\phys, \phys, #BLOCK_SHIFT
+=09.if=09\idmap
+=09and=09\start, \phys, #PTRS_PER_PTE - 1=09// table index
+=09.else
+=09lsr=09\start, \start, #BLOCK_SHIFT
+=09and=09\start, \start, #PTRS_PER_PTE - 1=09// table index
+=09.endif
+=09orr=09\phys, \flags, \phys, lsl #BLOCK_SHIFT=09// table entry
+=09.ifnc=09\start,\end
+=09lsr=09\end, \end, #BLOCK_SHIFT
+=09and=09\end, \end, #PTRS_PER_PTE - 1=09=09// table end index
+=09.endif
+9999:=09str=09\phys, [\tbl, \start, lsl #3]=09=09// store the entry
+=09.ifnc=09\start,\end
+=09add=09\start, \start, #1=09=09=09// next entry
+=09add=09\phys, \phys, #BLOCK_SIZE=09=09// next block
+=09cmp=09\start, \end
+=09b.ls=099999b
+=09.endif
+=09.endm
+
+/*
+ * Setup the initial page tables. We only setup the barest amount which is
+ * required to get the kernel running. The following sections are required=
:
+ *   - identity mapping to enable the MMU (low address, TTBR0)
+ *   - first few MB of the kernel linear mapping to jump to once the MMU h=
as
+ *     been enabled, including the FDT blob (TTBR1)
+ */
+__create_page_tables:
+=09pgtbl=09x25, x26, x24=09=09=09// idmap_pg_dir and swapper_pg_dir addres=
ses
+
+=09/*
+=09 * Clear the idmap and swapper page tables.
+=09 */
+=09mov=09x0, x25
+=09add=09x6, x26, #SWAPPER_DIR_SIZE
+1:=09stp=09xzr, xzr, [x0], #16
+=09stp=09xzr, xzr, [x0], #16
+=09stp=09xzr, xzr, [x0], #16
+=09stp=09xzr, xzr, [x0], #16
+=09cmp=09x0, x6
+=09b.lo=091b
+
+=09ldr=09x7, =3DMM_MMUFLAGS
+
+=09/*
+=09 * Create the identity mapping.
+=09 */
+=09add=09x0, x25, #PAGE_SIZE=09=09// section table address
+=09adr=09x3, __turn_mmu_on=09=09// virtual/physical address
+=09create_pgd_entry x25, x0, x3, x5, x6
+=09create_block_map x0, x7, x3, x5, x5, idmap=3D1
+
+=09/*
+=09 * Map the kernel image (starting with PHYS_OFFSET).
+=09 */
+=09add=09x0, x26, #PAGE_SIZE=09=09// section table address
+=09mov=09x5, #PAGE_OFFSET
+=09create_pgd_entry x26, x0, x5, x3, x6
+=09ldr=09x6, =3DKERNEL_END - 1
+=09mov=09x3, x24=09=09=09=09// phys offset
+=09create_block_map x0, x7, x3, x5, x6
+
+=09/*
+=09 * Map the FDT blob (maximum 2MB; must be within 512MB of
+=09 * PHYS_OFFSET).
+=09 */
+=09mov=09x3, x21=09=09=09=09// FDT phys address
+=09and=09x3, x3, #~((1 << 21) - 1)=09// 2MB aligned
+=09mov=09x6, #PAGE_OFFSET
+=09sub=09x5, x3, x24=09=09=09// subtract PHYS_OFFSET
+=09tst=09x5, #~((1 << 29) - 1)=09=09// within 512MB?
+=09csel=09x21, xzr, x21, ne=09=09// zero the FDT pointer
+=09b.ne=091f
+=09add=09x5, x5, x6=09=09=09// __va(FDT blob)
+=09add=09x6, x5, #1 << 21=09=09// 2MB for the FDT blob
+=09sub=09x6, x6, #1=09=09=09// inclusive range
+=09create_block_map x0, x7, x3, x5, x6
+1:
+=09ret
+ENDPROC(__create_page_tables)
+=09.ltorg
+
+=09.align=093
+=09.type=09__switch_data, %object
+__switch_data:
+=09.quad=09__mmap_switched
+=09.quad=09__data_loc=09=09=09// x4
+=09.quad=09_data=09=09=09=09// x5
+=09.quad=09__bss_start=09=09=09// x6
+=09.quad=09_end=09=09=09=09// x7
+=09.quad=09processor_id=09=09=09// x4
+=09.quad=09__fdt_pointer=09=09=09// x5
+=09.quad=09memstart_addr=09=09=09// x6
+=09.quad=09init_thread_union + THREAD_START_SP // sp
+
+/*
+ * The following fragment of code is executed with the MMU on in MMU mode,=
 and
+ * uses absolute addresses; this is not position independent.
+ */
+__mmap_switched:
+=09adr=09x3, __switch_data + 8
+
+=09ldp=09x4, x5, [x3], #16
+=09ldp=09x6, x7, [x3], #16
+=09cmp=09x4, x5=09=09=09=09// Copy data segment if needed
+1:=09ccmp=09x5, x6, #4, ne
+=09b.eq=092f
+=09ldr=09x16, [x4], #8
+=09str=09x16, [x5], #8
+=09b=091b
+2:
+1:=09cmp=09x6, x7
+=09b.hs=092f
+=09str=09xzr, [x6], #8=09=09=09// Clear BSS
+=09b=091b
+2:
+=09ldp=09x4, x5, [x3], #16
+=09ldr=09x6, [x3], #8
+=09ldr=09x16, [x3]
+=09mov=09sp, x16
+=09str=09x22, [x4]=09=09=09// Save processor ID
+=09str=09x21, [x5]=09=09=09// Save FDT pointer
+=09str=09x24, [x6]=09=09=09// Save PHYS_OFFSET
+=09mov=09x29, #0
+=09b=09start_kernel
+ENDPROC(__mmap_switched)
+
+/*
+ * Exception handling. Something went wrong and we can't proceed. We ought=
 to
+ * tell the user, but since we don't have any guarantee that we're even
+ * running on the right architecture, we do virtually nothing.
+ */
+__error_p:
+ENDPROC(__error_p)
+
+__error:
+1:=09nop
+=09b=091b
+ENDPROC(__error)
+
+/*
+ * Read processor ID register and look up in the linker-built supported
+ * processor list. Note that we can't use the absolute addresses for the
+ * __proc_info lists since we aren't running with the MMU on (and therefor=
e,
+ * we are not in the correct address space). We have to calculate the offs=
et.
+ *
+ * This routine can be called via C code, so to avoid needlessly saving
+ * callee-saved registers, we take the CPUID in x0 and return the physical
+ * proc_info pointer in x0 as well.
+ */
+__lookup_processor_type:
+=09adr=09x1, __lookup_processor_type_data
+=09ldr=09x2, [x1]
+=09ldp=09x3, x4, [x1, #8]
+=09sub=09x1, x1, x2=09=09=09// get offset between virt&phys
+=09add=09x3, x3, x1=09=09=09// convert virt addresses to
+=09add=09x4, x4, x1=09=09=09// physical address space
+1:
+=09ldp=09w5, w6, [x3]=09=09=09// load cpu_val and cpu_mask
+=09and=09x6, x6, x0
+=09cmp=09x5, x6
+=09b.eq=092f
+=09add=09x3, x3, #PROC_INFO_SZ
+=09cmp=09x4, x4
+=09b.ne=091b
+=09mov=09x3, #0=09=09=09=09// unknown processor
+2:
+=09mov=09x0, x3
+=09ret
+ENDPROC(__lookup_processor_type)
+
+/*
+ * This provides a C-API version of the above function.
+ */
+ENTRY(lookup_processor_type)
+=09mov=09x8, lr
+=09bl=09__lookup_processor_type
+=09ret=09x8
+ENDPROC(lookup_processor_type)
+
+=09.align=093
+=09.type=09__lookup_processor_type_data, %object
+__lookup_processor_type_data:
+=09.quad=09.
+=09.quad=09__proc_info_begin
+=09.quad=09__proc_info_end
+=09.size=09__lookup_processor_type_data, . - __lookup_processor_type_data
+
+/*
+ * Determine validity of the x21 FDT pointer.
+ * The dtb must be 8-byte aligned and live in the first 512M of memory.
+ */
+__vet_fdt:
+=09tst=09x21, #0x7
+=09b.ne=091f
+=09cmp=09x21, x24
+=09b.lt=091f
+=09mov=09x0, #(1 << 29)
+=09add=09x0, x0, x24
+=09cmp=09x21, x0
+=09b.ge=091f
+=09ret
+1:
+=09mov=09x21, #0
+=09ret
+ENDPROC(__vet_fdt)
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
new file mode 100644
index 0000000..f25186f
--- /dev/null
+++ b/arch/arm64/kernel/setup.c
@@ -0,0 +1,357 @@
+/*
+ * Based on arch/arm/kernel/setup.c
+ *
+ * Copyright (C) 1995-2001 Russell King
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
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/utsname.h>
+#include <linux/initrd.h>
+#include <linux/console.h>
+#include <linux/bootmem.h>
+#include <linux/seq_file.h>
+#include <linux/screen_info.h>
+#include <linux/init.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
+#include <linux/root_dev.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/memblock.h>
+#include <linux/of_fdt.h>
+
+#include <asm/cputype.h>
+#include <asm/elf.h>
+#include <asm/procinfo.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/traps.h>
+#include <asm/memblock.h>
+
+extern void paging_init(void);
+
+unsigned int processor_id;
+EXPORT_SYMBOL(processor_id);
+
+unsigned int elf_hwcap __read_mostly;
+EXPORT_SYMBOL(elf_hwcap);
+
+static const char *cpu_name;
+static const char *machine_name;
+phys_addr_t __fdt_pointer __initdata;
+
+/*
+ * Standard memory resources
+ */
+static struct resource mem_res[] =3D {
+=09{
+=09=09.name =3D "Kernel code",
+=09=09.start =3D 0,
+=09=09.end =3D 0,
+=09=09.flags =3D IORESOURCE_MEM
+=09},
+=09{
+=09=09.name =3D "Kernel data",
+=09=09.start =3D 0,
+=09=09.end =3D 0,
+=09=09.flags =3D IORESOURCE_MEM
+=09}
+};
+
+#define kernel_code mem_res[0]
+#define kernel_data mem_res[1]
+
+/*
+ * These functions re-use the assembly code in head.S, which
+ * already provide the required functionality.
+ */
+extern struct proc_info_list *lookup_processor_type(unsigned int);
+
+void __init early_print(const char *str, ...)
+{
+=09char buf[256];
+=09va_list ap;
+
+=09va_start(ap, str);
+=09vsnprintf(buf, sizeof(buf), str, ap);
+=09va_end(ap);
+
+=09printk("%s", buf);
+}
+
+static void __init setup_processor(void)
+{
+=09struct proc_info_list *list;
+
+=09/*
+=09 * locate processor in the list of supported processor
+=09 * types.  The linker builds this table for us from the
+=09 * entries in arch/arm/mm/proc.S
+=09 */
+=09list =3D lookup_processor_type(read_cpuid_id());
+=09if (!list) {
+=09=09printk("CPU configuration botched (ID %08x), unable to continue.\n",
+=09=09       read_cpuid_id());
+=09=09while (1);
+=09}
+
+=09cpu_name =3D list->cpu_name;
+
+=09printk("CPU: %s [%08x] revision %d\n",
+=09       cpu_name, read_cpuid_id(), read_cpuid_id() & 15);
+
+=09sprintf(init_utsname()->machine, "aarch64");
+=09elf_hwcap =3D 0;
+
+=09cpu_proc_init();
+}
+
+static void __init setup_machine_fdt(phys_addr_t dt_phys)
+{
+=09struct boot_param_header *devtree;
+=09unsigned long dt_root;
+
+=09/* Check we have a non-NULL DT pointer */
+=09if (!dt_phys) {
+=09=09early_print("\n"
+=09=09=09"Error: NULL or invalid device tree blob\n"
+=09=09=09"The dtb must be 8-byte aligned and passed in the first 512MB of =
memory\n"
+=09=09=09"\nPlease check your bootloader.\n");
+
+=09=09while (true)
+=09=09=09cpu_relax();
+
+=09}
+
+=09devtree =3D phys_to_virt(dt_phys);
+
+=09/* Check device tree validity */
+=09if (be32_to_cpu(devtree->magic) !=3D OF_DT_HEADER) {
+=09=09early_print("\n"
+=09=09=09"Error: invalid device tree blob at physical address 0x%p (virtua=
l address 0x%p)\n"
+=09=09=09"Expected 0x%x, found 0x%x\n"
+=09=09=09"\nPlease check your bootloader.\n",
+=09=09=09dt_phys, devtree, OF_DT_HEADER,
+=09=09=09be32_to_cpu(devtree->magic));
+
+=09=09while (true)
+=09=09=09cpu_relax();
+=09}
+
+=09initial_boot_params =3D devtree;
+=09dt_root =3D of_get_flat_dt_root();
+
+=09machine_name =3D of_get_flat_dt_prop(dt_root, "model", NULL);
+=09if (!machine_name)
+=09=09machine_name =3D of_get_flat_dt_prop(dt_root, "compatible", NULL);
+=09if (!machine_name)
+=09=09machine_name =3D "<unknown>";
+=09pr_info("Machine: %s\n", machine_name);
+
+=09/* Retrieve various information from the /chosen node */
+=09of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
+=09/* Initialize {size,address}-cells info */
+=09of_scan_flat_dt(early_init_dt_scan_root, NULL);
+=09/* Setup memory, calling early_init_dt_add_memory_arch */
+=09of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+}
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+=09size &=3D PAGE_MASK;
+=09memblock_add(base, size);
+}
+
+void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
+{
+=09return __va(memblock_alloc(size, align));
+}
+
+/*
+ * Limit the memory size that was specified via FDT.
+ */
+static int __init early_mem(char *p)
+{
+=09phys_addr_t limit;
+
+=09if (!p)
+=09=09return 1;
+
+=09limit =3D memparse(p, &p) & PAGE_MASK;
+=09pr_notice("Memory limited to %lldMB\n", limit >> 20);
+
+=09memblock_enforce_memory_limit(limit);
+
+=09return 0;
+}
+early_param("mem", early_mem);
+
+static void __init request_standard_resources(void)
+{
+=09struct memblock_region *region;
+=09struct resource *res;
+
+=09kernel_code.start   =3D virt_to_phys(_text);
+=09kernel_code.end     =3D virt_to_phys(_etext - 1);
+=09kernel_data.start   =3D virt_to_phys(_sdata);
+=09kernel_data.end     =3D virt_to_phys(_end - 1);
+
+=09for_each_memblock(memory, region) {
+=09=09res =3D alloc_bootmem_low(sizeof(*res));
+=09=09res->name  =3D "System RAM";
+=09=09res->start =3D __pfn_to_phys(memblock_region_memory_base_pfn(region)=
);
+=09=09res->end =3D __pfn_to_phys(memblock_region_memory_end_pfn(region)) -=
 1;
+=09=09res->flags =3D IORESOURCE_MEM | IORESOURCE_BUSY;
+
+=09=09request_resource(&iomem_resource, res);
+
+=09=09if (kernel_code.start >=3D res->start &&
+=09=09    kernel_code.end <=3D res->end)
+=09=09=09request_resource(res, &kernel_code);
+=09=09if (kernel_data.start >=3D res->start &&
+=09=09    kernel_data.end <=3D res->end)
+=09=09=09request_resource(res, &kernel_data);
+=09}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+=09setup_processor();
+
+=09setup_machine_fdt(__fdt_pointer);
+
+=09init_mm.start_code =3D (unsigned long) _text;
+=09init_mm.end_code   =3D (unsigned long) _etext;
+=09init_mm.end_data   =3D (unsigned long) _edata;
+=09init_mm.brk=09   =3D (unsigned long) _end;
+
+=09*cmdline_p =3D boot_command_line;
+
+=09parse_early_param();
+
+=09arm64_memblock_init();
+
+=09paging_init();
+=09request_standard_resources();
+
+=09unflatten_device_tree();
+
+#ifdef CONFIG_SMP
+=09smp_init_cpus();
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+=09conswitchp =3D &vga_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+=09conswitchp =3D &dummy_con;
+#endif
+#endif
+}
+
+static DEFINE_PER_CPU(struct cpu, cpu_data);
+
+static int __init topology_init(void)
+{
+=09int i;
+
+=09for_each_possible_cpu(i) {
+=09=09struct cpu *cpu =3D &per_cpu(cpu_data, i);
+=09=09cpu->hotpluggable =3D 1;
+=09=09register_cpu(cpu, i);
+=09}
+
+=09return 0;
+}
+subsys_initcall(topology_init);
+
+static const char *hwcap_str[] =3D {
+=09"fp",
+=09"asimd",
+=09NULL
+};
+
+static int c_show(struct seq_file *m, void *v)
+{
+=09int i;
+
+=09seq_printf(m, "Processor\t: %s rev %d (%s)\n",
+=09=09   cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
+
+=09for_each_online_cpu(i) {
+=09=09/*
+=09=09 * glibc reads /proc/cpuinfo to determine the number of
+=09=09 * online processors, looking for lines beginning with
+=09=09 * "processor".  Give glibc what it expects.
+=09=09 */
+#ifdef CONFIG_SMP
+=09=09seq_printf(m, "processor\t: %d\n", i);
+#endif
+=09=09seq_printf(m, "BogoMIPS\t: %lu.%02lu\n\n",
+=09=09=09   loops_per_jiffy / (500000UL/HZ),
+=09=09=09   loops_per_jiffy / (5000UL/HZ) % 100);
+=09}
+
+=09/* dump out the processor features */
+=09seq_puts(m, "Features\t: ");
+
+=09for (i =3D 0; hwcap_str[i]; i++)
+=09=09if (elf_hwcap & (1 << i))
+=09=09=09seq_printf(m, "%s ", hwcap_str[i]);
+
+=09seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
+=09seq_printf(m, "CPU architecture: AArch64\n");
+=09seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
+=09seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
+=09seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
+
+=09seq_puts(m, "\n");
+
+=09seq_printf(m, "Hardware\t: %s\n", machine_name);
+
+=09return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+=09return *pos < 1 ? (void *)1 : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+=09++*pos;
+=09return NULL;
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op =3D {
+=09.start=09=3D c_start,
+=09.next=09=3D c_next,
+=09.stop=09=3D c_stop,
+=09.show=09=3D c_show
+};

