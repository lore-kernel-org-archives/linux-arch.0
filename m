Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54964 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab2HNRxF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:05 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 04/31] arm64: MMU definitions
Date: Tue, 14 Aug 2012 18:52:05 +0100
Message-ID: <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175205.SEdMhz4u70PfUXL5sTLiyP23Q8_xKH-FzCZmREyobbk@z>

The virtual memory layout is described in
Documentation/arm64/memory.txt. This patch adds the MMU definitions for
the 4KB and 64KB translation table configurations. The SECTION_SIZE is
2MB with 4KB page and 512MB with 64KB page configuration.

PHYS_OFFSET is calculated at run-time and stored in a variable (no
run-time code patching at this stage).

On the current implementation, both user and kernel address spaces are
512G (39-bit) each with a maximum of 256G for the RAM linear mapping.
Linux uses 3 levels of translation tables with the 4K page configuration
and 2 levels with the 64K configuration. Extending the memory space
beyond 39-bit with the 4K pages or 42-bit with 64K pages requires an
additional level of translation tables.

The SPARSEMEM configuration is global to all AArch64 platforms and
allows for 1GB sections with SPARSEMEM_VMEMMAP enabled by default.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/memory.txt                |   69 +++++
 arch/arm64/include/asm/memory.h               |  144 +++++++++++
 arch/arm64/include/asm/mmu.h                  |   27 ++
 arch/arm64/include/asm/pgtable-2level-hwdef.h |   43 ++++
 arch/arm64/include/asm/pgtable-2level-types.h |   60 +++++
 arch/arm64/include/asm/pgtable-3level-hwdef.h |   50 ++++
 arch/arm64/include/asm/pgtable-3level-types.h |   66 +++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   94 +++++++
 arch/arm64/include/asm/pgtable.h              |  328 +++++++++++++++++++++=
++++
 arch/arm64/include/asm/sparsemem.h            |   24 ++
 10 files changed, 905 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm64/memory.txt
 create mode 100644 arch/arm64/include/asm/memory.h
 create mode 100644 arch/arm64/include/asm/mmu.h
 create mode 100644 arch/arm64/include/asm/pgtable-2level-hwdef.h
 create mode 100644 arch/arm64/include/asm/pgtable-2level-types.h
 create mode 100644 arch/arm64/include/asm/pgtable-3level-hwdef.h
 create mode 100644 arch/arm64/include/asm/pgtable-3level-types.h
 create mode 100644 arch/arm64/include/asm/pgtable-hwdef.h
 create mode 100644 arch/arm64/include/asm/pgtable.h
 create mode 100644 arch/arm64/include/asm/sparsemem.h

diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.tx=
t
new file mode 100644
index 0000000..7210af7
--- /dev/null
+++ b/Documentation/arm64/memory.txt
@@ -0,0 +1,69 @@
+=09=09     Memory Layout on AArch64 Linux
+=09=09     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Author: Catalin Marinas <catalin.marinas@arm.com>
+Date  : 20 February 2012
+
+This document describes the virtual memory layout used by the AArch64
+Linux kernel. The architecture allows up to 4 levels of translation
+tables with a 4KB page size and up to 3 levels with a 64KB page size.
+
+AArch64 Linux uses 3 levels of translation tables with the 4KB page
+configuration, allowing 39-bit (512GB) virtual addresses for both user
+and kernel. With 64KB pages, only 2 levels of translation tables are
+used but the memory layout is the same.
+
+User addresses have bits 63:39 set to 0 while the kernel addresses have
+the same bits set to 1. TTBRx selection is given by bit 63 of the
+virtual address. The swapper_pg_dir contains only kernel (global)
+mappings while the user pgd contains only user (non-global) mappings.
+The swapper_pgd_dir address is written to TTBR1 and never written to
+TTBR0.
+
+
+AArch64 Linux memory layout:
+
+Start=09=09=09End=09=09=09Size=09=09Use
+-----------------------------------------------------------------------
+0000000000000000=090000007fffffffff=09 512GB=09=09user
+
+ffffff8000000000=09ffffffbbfffeffff=09~240GB=09=09vmalloc
+
+ffffffbbffff0000=09ffffffbcffffffff=09  64KB=09=09[guard page]
+
+ffffffbc00000000=09ffffffbdffffffff=09   8GB=09=09vmemmap
+
+ffffffbe00000000=09ffffffbffbffffff=09  ~8GB=09=09[guard, future vmmemap]
+
+ffffffbffc000000=09ffffffbfffffffff=09  64MB=09=09modules
+
+ffffffc000000000=09ffffffffffffffff=09 256GB=09=09memory
+
+
+Translation table lookup with 4KB pages:
+
++--------+--------+--------+--------+--------+--------+--------+--------+
+|63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
++--------+--------+--------+--------+--------+--------+--------+--------+
+ |                 |         |         |         |         |
+ |                 |         |         |         |         v
+ |                 |         |         |         |   [11:0]  in-page offse=
t
+ |                 |         |         |         +-> [20:12] L3 index
+ |                 |         |         +-----------> [29:21] L2 index
+ |                 |         +---------------------> [38:30] L1 index
+ |                 +-------------------------------> [47:39] L0 index (not=
 used)
+ +-------------------------------------------------> [63] TTBR0/1
+
+
+Translation table lookup with 64KB pages:
+
++--------+--------+--------+--------+--------+--------+--------+--------+
+|63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
++--------+--------+--------+--------+--------+--------+--------+--------+
+ |                 |    |               |              |
+ |                 |    |               |              v
+ |                 |    |               |            [15:0]  in-page offse=
t
+ |                 |    |               +----------> [28:16] L3 index
+ |                 |    +--------------------------> [41:29] L2 index (onl=
y 38:29 used)
+ |                 +-------------------------------> [47:42] L1 index (not=
 used)
+ +-------------------------------------------------> [63] TTBR0/1
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memor=
y.h
new file mode 100644
index 0000000..3cfdc4b
--- /dev/null
+++ b/arch/arm64/include/asm/memory.h
@@ -0,0 +1,144 @@
+/*
+ * Based on arch/arm/include/asm/memory.h
+ *
+ * Copyright (C) 2000-2002 Russell King
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
+ *
+ * Note: this file should not be included by non-asm/.h files
+ */
+#ifndef __ASM_MEMORY_H
+#define __ASM_MEMORY_H
+
+#include <linux/compiler.h>
+#include <linux/const.h>
+#include <linux/types.h>
+#include <asm/sizes.h>
+
+/*
+ * Allow for constants defined here to be used from assembly code
+ * by prepending the UL suffix only with actual C code compilation.
+ */
+#define UL(x) _AC(x, UL)
+
+/*
+ * PAGE_OFFSET - the virtual address of the start of the kernel image.
+ * VA_BITS - the maximum number of bits for virtual addresses.
+ * TASK_SIZE - the maximum size of a user space task.
+ * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
+ * The module space lives between the addresses given by TASK_SIZE
+ * and PAGE_OFFSET - it must be within 128MB of the kernel text.
+ */
+#define PAGE_OFFSET=09=09UL(0xffffffc000000000)
+#define MODULES_END=09=09(PAGE_OFFSET)
+#define MODULES_VADDR=09=09(MODULES_END - SZ_64M)
+#define VA_BITS=09=09=09(39)
+#define TASK_SIZE_64=09=09(UL(1) << VA_BITS)
+
+#ifdef CONFIG_AARCH32_EMULATION
+#define TASK_SIZE_32=09=09UL(0x100000000)
+#define TASK_SIZE=09=09(test_thread_flag(TIF_32BIT) ? \
+=09=09=09=09TASK_SIZE_32 : TASK_SIZE_64)
+#else
+#define TASK_SIZE=09=09TASK_SIZE_64
+#endif /* CONFIG_AARCH32_EMULATION */
+
+#define TASK_UNMAPPED_BASE=09(PAGE_ALIGN(TASK_SIZE / 4))
+
+#if TASK_SIZE_64 > MODULES_VADDR
+#error Top of 64-bit user space clashes with start of module space
+#endif
+
+/*
+ * Physical vs virtual RAM address space conversion.  These are
+ * private definitions which should NOT be used outside memory.h
+ * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
+ */
+#define __virt_to_phys(x)=09(((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET=
))
+#define __phys_to_virt(x)=09((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFS=
ET))
+
+/*
+ * Convert a physical address to a Page Frame Number and back
+ */
+#define=09__phys_to_pfn(paddr)=09((unsigned long)((paddr) >> PAGE_SHIFT))
+#define=09__pfn_to_phys(pfn)=09((phys_addr_t)(pfn) << PAGE_SHIFT)
+
+/*
+ * Convert a page to/from a physical address
+ */
+#define page_to_phys(page)=09(__pfn_to_phys(page_to_pfn(page)))
+#define phys_to_page(phys)=09(pfn_to_page(__phys_to_pfn(phys)))
+
+/*
+ * Memory types available.
+ */
+#define MT_DEVICE_nGnRnE=090
+#define MT_DEVICE_nGnRE=09=091
+#define MT_DEVICE_GRE=09=092
+#define MT_NORMAL_NC=09=093
+#define MT_NORMAL=09=094
+
+#ifndef __ASSEMBLY__
+
+extern phys_addr_t=09=09memstart_addr;
+/* PHYS_OFFSET - the physical address of the start of memory. */
+#define PHYS_OFFSET=09=09({ memstart_addr; })
+
+/*
+ * PFNs are used to describe any physical page; this means
+ * PFN 0 =3D=3D physical address 0.
+ *
+ * This is the PFN of the first RAM page in the kernel
+ * direct-mapped view.  We assume this is the first page
+ * of RAM in the mem_map as well.
+ */
+#define PHYS_PFN_OFFSET=09(PHYS_OFFSET >> PAGE_SHIFT)
+
+/*
+ * Note: Drivers should NOT use these.  They are the wrong
+ * translation for translating DMA addresses.  Use the driver
+ * DMA support - see dma-mapping.h.
+ */
+static inline phys_addr_t virt_to_phys(const volatile void *x)
+{
+=09return __virt_to_phys((unsigned long)(x));
+}
+
+static inline void *phys_to_virt(phys_addr_t x)
+{
+=09return (void *)(__phys_to_virt(x));
+}
+
+/*
+ * Drivers should NOT use these either.
+ */
+#define __pa(x)=09=09=09__virt_to_phys((unsigned long)(x))
+#define __va(x)=09=09=09((void *)__phys_to_virt((phys_addr_t)(x)))
+#define pfn_to_kaddr(pfn)=09__va((pfn) << PAGE_SHIFT)
+
+/*
+ *  virt_to_page(k)=09convert a _valid_ virtual address to struct page *
+ *  virt_addr_valid(k)=09indicates whether a virtual address is valid
+ */
+#define ARCH_PFN_OFFSET=09=09PHYS_PFN_OFFSET
+
+#define virt_to_page(kaddr)=09pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define=09virt_addr_valid(kaddr)=09(((void *)(kaddr) >=3D (void *)PAGE_OFF=
SET) && \
+=09=09=09=09 ((void *)(kaddr) < (void *)high_memory))
+
+#endif
+
+#include <asm-generic/memory_model.h>
+
+#endif
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
new file mode 100644
index 0000000..981498a
--- /dev/null
+++ b/arch/arm64/include/asm/mmu.h
@@ -0,0 +1,27 @@
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
+#ifndef __ASM_MMU_H
+#define __ASM_MMU_H
+
+typedef struct {
+=09unsigned int id;
+=09spinlock_t id_lock;
+=09void *vdso;
+} mm_context_t;
+
+#define ASID(mm)=09((mm)->context.id & 0xffff)
+
+#endif
diff --git a/arch/arm64/include/asm/pgtable-2level-hwdef.h b/arch/arm64/inc=
lude/asm/pgtable-2level-hwdef.h
new file mode 100644
index 0000000..0a8ed3f
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-2level-hwdef.h
@@ -0,0 +1,43 @@
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
+#ifndef __ASM_PGTABLE_2LEVEL_HWDEF_H
+#define __ASM_PGTABLE_2LEVEL_HWDEF_H
+
+/*
+ * With LPAE and 64KB pages, there are 2 levels of page tables. Each level=
 has
+ * 8192 entries of 8 bytes each, occupying a 64KB page. Levels 0 and 1 are=
 not
+ * used. The 2nd level table (PGD for Linux) can cover a range of 4TB, eac=
h
+ * entry representing 512MB. The user and kernel address spaces are limite=
d to
+ * 512GB and therefore we only use 1024 entries in the PGD.
+ */
+#define PTRS_PER_PTE=09=098192
+#define PTRS_PER_PGD=09=091024
+
+/*
+ * PGDIR_SHIFT determines the size a top-level page table entry can map.
+ */
+#define PGDIR_SHIFT=09=0929
+#define PGDIR_SIZE=09=09(_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK=09=09(~(PGDIR_SIZE-1))
+
+/*
+ * section address mask and size definitions.
+ */
+#define SECTION_SHIFT=09=0929
+#define SECTION_SIZE=09=09(_AC(1, UL) << SECTION_SHIFT)
+#define SECTION_MASK=09=09(~(SECTION_SIZE-1))
+
+#endif
diff --git a/arch/arm64/include/asm/pgtable-2level-types.h b/arch/arm64/inc=
lude/asm/pgtable-2level-types.h
new file mode 100644
index 0000000..3c3ca7d
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-2level-types.h
@@ -0,0 +1,60 @@
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
+#ifndef __ASM_PGTABLE_2LEVEL_TYPES_H
+#define __ASM_PGTABLE_2LEVEL_TYPES_H
+
+typedef u64 pteval_t;
+typedef u64 pgdval_t;
+typedef pgdval_t pmdval_t;
+
+#undef STRICT_MM_TYPECHECKS
+
+#ifdef STRICT_MM_TYPECHECKS
+
+/*
+ * These are used to make use of C type-checking..
+ */
+typedef struct { pteval_t pte; } pte_t;
+typedef struct { pgdval_t pgd; } pgd_t;
+typedef struct { pteval_t pgprot; } pgprot_t;
+
+#define pte_val(x)      ((x).pte)
+#define pgd_val(x)=09((x).pgd)
+#define pgprot_val(x)   ((x).pgprot)
+
+#define __pte(x)        ((pte_t) { (x) } )
+#define __pgd(x)=09((pgd_t) { (x) } )
+#define __pgprot(x)     ((pgprot_t) { (x) } )
+
+#else=09/* !STRICT_MM_TYPECHECKS */
+
+typedef pteval_t pte_t;
+typedef pgdval_t pgd_t;
+typedef pteval_t pgprot_t;
+
+#define pte_val(x)=09(x)
+#define pgd_val(x)=09(x)
+#define pgprot_val(x)=09(x)
+
+#define __pte(x)=09(x)
+#define __pgd(x)=09(x)
+#define __pgprot(x)=09(x)
+
+#endif=09/* STRICT_MM_TYPECHECKS */
+
+#include <asm-generic/pgtable-nopmd.h>
+
+#endif=09/* __ASM_PGTABLE_2LEVEL_TYPES_H */
diff --git a/arch/arm64/include/asm/pgtable-3level-hwdef.h b/arch/arm64/inc=
lude/asm/pgtable-3level-hwdef.h
new file mode 100644
index 0000000..3dbf941
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-3level-hwdef.h
@@ -0,0 +1,50 @@
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
+#ifndef __ASM_PGTABLE_3LEVEL_HWDEF_H
+#define __ASM_PGTABLE_3LEVEL_HWDEF_H
+
+/*
+ * With LPAE and 4KB pages, there are 3 levels of page tables. Each level =
has
+ * 512 entries of 8 bytes each, occupying a 4K page. The first level table
+ * covers a range of 512GB, each entry representing 1GB. The user and kern=
el
+ * address spaces are limited to 512GB each.
+ */
+#define PTRS_PER_PTE=09=09512
+#define PTRS_PER_PMD=09=09512
+#define PTRS_PER_PGD=09=09512
+
+/*
+ * PGDIR_SHIFT determines the size a top-level page table entry can map.
+ */
+#define PGDIR_SHIFT=09=0930
+#define PGDIR_SIZE=09=09(_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK=09=09(~(PGDIR_SIZE-1))
+
+/*
+ * PMD_SHIFT determines the size a middle-level page table entry can map.
+ */
+#define PMD_SHIFT=09=0921
+#define PMD_SIZE=09=09(_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK=09=09(~(PMD_SIZE-1))
+
+/*
+ * section address mask and size definitions.
+ */
+#define SECTION_SHIFT=09=0921
+#define SECTION_SIZE=09=09(_AC(1, UL) << SECTION_SHIFT)
+#define SECTION_MASK=09=09(~(SECTION_SIZE-1))
+
+#endif
diff --git a/arch/arm64/include/asm/pgtable-3level-types.h b/arch/arm64/inc=
lude/asm/pgtable-3level-types.h
new file mode 100644
index 0000000..4489615
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-3level-types.h
@@ -0,0 +1,66 @@
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
+#ifndef __ASM_PGTABLE_3LEVEL_TYPES_H
+#define __ASM_PGTABLE_3LEVEL_TYPES_H
+
+typedef u64 pteval_t;
+typedef u64 pmdval_t;
+typedef u64 pgdval_t;
+
+#undef STRICT_MM_TYPECHECKS
+
+#ifdef STRICT_MM_TYPECHECKS
+
+/*
+ * These are used to make use of C type-checking..
+ */
+typedef struct { pteval_t pte; } pte_t;
+typedef struct { pmdval_t pmd; } pmd_t;
+typedef struct { pgdval_t pgd; } pgd_t;
+typedef struct { pteval_t pgprot; } pgprot_t;
+
+#define pte_val(x)      ((x).pte)
+#define pmd_val(x)      ((x).pmd)
+#define pgd_val(x)=09((x).pgd)
+#define pgprot_val(x)   ((x).pgprot)
+
+#define __pte(x)        ((pte_t) { (x) } )
+#define __pmd(x)        ((pmd_t) { (x) } )
+#define __pgd(x)=09((pgd_t) { (x) } )
+#define __pgprot(x)     ((pgprot_t) { (x) } )
+
+#else=09/* !STRICT_MM_TYPECHECKS */
+
+typedef pteval_t pte_t;
+typedef pmdval_t pmd_t;
+typedef pgdval_t pgd_t;
+typedef pteval_t pgprot_t;
+
+#define pte_val(x)=09(x)
+#define pmd_val(x)=09(x)
+#define pgd_val(x)=09(x)
+#define pgprot_val(x)=09(x)
+
+#define __pte(x)=09(x)
+#define __pmd(x)=09(x)
+#define __pgd(x)=09(x)
+#define __pgprot(x)=09(x)
+
+#endif=09/* STRICT_MM_TYPECHECKS */
+
+#include <asm-generic/pgtable-nopud.h>
+
+#endif=09/* __ASM_PGTABLE_3LEVEL_TYPES_H */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/as=
m/pgtable-hwdef.h
new file mode 100644
index 0000000..561fb08
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -0,0 +1,94 @@
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
+#ifndef __ASM_PGTABLE_HWDEF_H
+#define __ASM_PGTABLE_HWDEF_H
+
+#ifdef CONFIG_ARM64_64K_PAGES
+#include <asm/pgtable-2level-hwdef.h>
+#else
+#include <asm/pgtable-3level-hwdef.h>
+#endif
+
+/*
+ * Hardware page table definitions.
+ *
+ * Level 2 descriptor (PMD).
+ */
+#define PMD_TYPE_MASK=09=09(_AT(pmdval_t, 3) << 0)
+#define PMD_TYPE_FAULT=09=09(_AT(pmdval_t, 0) << 0)
+#define PMD_TYPE_TABLE=09=09(_AT(pmdval_t, 3) << 0)
+#define PMD_TYPE_SECT=09=09(_AT(pmdval_t, 1) << 0)
+
+/*
+ * Section
+ */
+#define PMD_SECT_S=09=09(_AT(pmdval_t, 3) << 8)
+#define PMD_SECT_AF=09=09(_AT(pmdval_t, 1) << 10)
+#define PMD_SECT_NG=09=09(_AT(pmdval_t, 1) << 11)
+#define PMD_SECT_XN=09=09(_AT(pmdval_t, 1) << 54)
+
+/*
+ * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registe=
rs).
+ */
+#define PMD_ATTRINDX(t)=09=09(_AT(pmdval_t, (t)) << 2)
+#define PMD_ATTRINDX_MASK=09(_AT(pmdval_t, 7) << 2)
+
+/*
+ * Level 3 descriptor (PTE).
+ */
+#define PTE_TYPE_MASK=09=09(_AT(pteval_t, 3) << 0)
+#define PTE_TYPE_FAULT=09=09(_AT(pteval_t, 0) << 0)
+#define PTE_TYPE_PAGE=09=09(_AT(pteval_t, 3) << 0)
+#define PTE_USER=09=09(_AT(pteval_t, 1) << 6)=09=09/* AP[1] */
+#define PTE_RDONLY=09=09(_AT(pteval_t, 1) << 7)=09=09/* AP[2] */
+#define PTE_SHARED=09=09(_AT(pteval_t, 3) << 8)=09=09/* SH[1:0], inner sha=
reable */
+#define PTE_AF=09=09=09(_AT(pteval_t, 1) << 10)=09/* Access Flag */
+#define PTE_NG=09=09=09(_AT(pteval_t, 1) << 11)=09/* nG */
+#define PTE_XN=09=09=09(_AT(pteval_t, 1) << 54)=09/* XN */
+
+/*
+ * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registe=
rs).
+ */
+#define PTE_ATTRINDX(t)=09=09(_AT(pteval_t, (t)) << 2)
+#define PTE_ATTRINDX_MASK=09(_AT(pteval_t, 7) << 2)
+
+/*
+ * 40-bit physical address supported.
+ */
+#define PHYS_MASK_SHIFT=09=09(40)
+#define PHYS_MASK=09=09((1UL << PHYS_MASK_SHIFT) - 1)
+
+/*
+ * TCR flags.
+ */
+#define TCR_TxSZ(x)=09=09(((64 - (x)) << 16) | ((64 - (x)) << 0))
+#define TCR_IRGN_NC=09=09((0 << 8) | (0 << 24))
+#define TCR_IRGN_WBWA=09=09((1 << 8) | (1 << 24))
+#define TCR_IRGN_WT=09=09((2 << 8) | (2 << 24))
+#define TCR_IRGN_WBnWA=09=09((3 << 8) | (3 << 24))
+#define TCR_IRGN_MASK=09=09((3 << 8) | (3 << 24))
+#define TCR_ORGN_NC=09=09((0 << 10) | (0 << 26))
+#define TCR_ORGN_WBWA=09=09((1 << 10) | (1 << 26))
+#define TCR_ORGN_WT=09=09((2 << 10) | (2 << 26))
+#define TCR_ORGN_WBnWA=09=09((3 << 10) | (3 << 26))
+#define TCR_ORGN_MASK=09=09((3 << 10) | (3 << 26))
+#define TCR_SHARED=09=09((3 << 12) | (3 << 28))
+#define TCR_TG0_64K=09=09(1 << 14)
+#define TCR_TG1_64K=09=09(1 << 30)
+#define TCR_IPS_40BIT=09=09(2 << 32)
+#define TCR_ASID16=09=09(1 << 36)
+
+#endif
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgta=
ble.h
new file mode 100644
index 0000000..6981da0
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable.h
@@ -0,0 +1,328 @@
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
+#ifndef __ASM_PGTABLE_H
+#define __ASM_PGTABLE_H
+
+#include <asm/proc-fns.h>
+
+#include <asm/memory.h>
+#include <asm/pgtable-hwdef.h>
+
+/*
+ * Software defined PTE bits definition.
+ */
+#define PTE_VALID=09=09(_AT(pteval_t, 1) << 0)=09/* pte_present() check */
+#define PTE_FILE=09=09(_AT(pteval_t, 1) << 2)=09/* only when !pte_present(=
) */
+#define PTE_DIRTY=09=09(_AT(pteval_t, 1) << 55)
+#define PTE_SPECIAL=09=09(_AT(pteval_t, 1) << 56)
+
+/*
+ * VMALLOC and SPARSEMEM_VMEMMAP ranges.
+ */
+#define VMALLOC_START=09=09UL(0xffffff8000000000)
+#define VMALLOC_END=09=09(PAGE_OFFSET - UL(0x400000000) - SZ_64K)
+
+#define vmemmap=09=09=09((struct page *)(VMALLOC_END + SZ_64K))
+
+#define FIRST_USER_ADDRESS=090
+
+#ifndef __ASSEMBLY__
+extern void __pte_error(const char *file, int line, unsigned long val);
+extern void __pmd_error(const char *file, int line, unsigned long val);
+extern void __pgd_error(const char *file, int line, unsigned long val);
+
+#define pte_ERROR(pte)=09=09__pte_error(__FILE__, __LINE__, pte_val(pte))
+#ifndef CONFIG_ARM64_64K_PAGES
+#define pmd_ERROR(pmd)=09=09__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
+#endif
+#define pgd_ERROR(pgd)=09=09__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
+
+/*
+ * The pgprot_* and protection_map entries will be fixed up at runtime to
+ * include the cachable and bufferable bits based on memory policy, as wel=
l as
+ * any architecture dependent bits like global/ASID and SMP shared mapping
+ * bits.
+ */
+#define _PAGE_DEFAULT=09=09PTE_TYPE_PAGE | PTE_AF
+
+extern pgprot_t pgprot_default;
+
+#define _MOD_PROT(p, b)=09__pgprot(pgprot_val(p) | (b))
+
+#define PAGE_NONE=09=09_MOD_PROT(pgprot_default, PTE_NG | PTE_XN | PTE_RDO=
NLY)
+#define PAGE_SHARED=09=09_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE=
_XN)
+#define PAGE_SHARED_EXEC=09_MOD_PROT(pgprot_default, PTE_USER | PTE_NG)
+#define PAGE_COPY=09=09_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | PTE_X=
N | PTE_RDONLY)
+#define PAGE_COPY_EXEC=09=09_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | =
PTE_RDONLY)
+#define PAGE_READONLY=09=09_MOD_PROT(pgprot_default, PTE_USER | PTE_NG | P=
TE_XN | PTE_RDONLY)
+#define PAGE_READONLY_EXEC=09_MOD_PROT(pgprot_default, PTE_USER | PTE_NG |=
 PTE_RDONLY)
+#define PAGE_KERNEL=09=09_MOD_PROT(pgprot_default, PTE_XN | PTE_DIRTY)
+#define PAGE_KERNEL_EXEC=09_MOD_PROT(pgprot_default, PTE_DIRTY)
+
+#define __PAGE_NONE=09=09__pgprot(_PAGE_DEFAULT | PTE_NG | PTE_XN | PTE_RD=
ONLY)
+#define __PAGE_SHARED=09=09__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PT=
E_XN)
+#define __PAGE_SHARED_EXEC=09__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG)
+#define __PAGE_COPY=09=09__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_=
XN | PTE_RDONLY)
+#define __PAGE_COPY_EXEC=09__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PT=
E_RDONLY)
+#define __PAGE_READONLY=09=09__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | =
PTE_XN | PTE_RDONLY)
+#define __PAGE_READONLY_EXEC=09__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG =
| PTE_RDONLY)
+
+#endif /* __ASSEMBLY__ */
+
+#define __P000  __PAGE_NONE
+#define __P001  __PAGE_READONLY
+#define __P010  __PAGE_COPY
+#define __P011  __PAGE_COPY
+#define __P100  __PAGE_READONLY_EXEC
+#define __P101  __PAGE_READONLY_EXEC
+#define __P110  __PAGE_COPY_EXEC
+#define __P111  __PAGE_COPY_EXEC
+
+#define __S000  __PAGE_NONE
+#define __S001  __PAGE_READONLY
+#define __S010  __PAGE_SHARED
+#define __S011  __PAGE_SHARED
+#define __S100  __PAGE_READONLY_EXEC
+#define __S101  __PAGE_READONLY_EXEC
+#define __S110  __PAGE_SHARED_EXEC
+#define __S111  __PAGE_SHARED_EXEC
+
+#ifndef __ASSEMBLY__
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern struct page *empty_zero_page;
+#define ZERO_PAGE(vaddr)=09(empty_zero_page)
+
+#define pte_pfn(pte)=09=09((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT)
+
+#define pfn_pte(pfn,prot)=09(__pte(((phys_addr_t)(pfn) << PAGE_SHIFT) | pg=
prot_val(prot)))
+
+#define pte_none(pte)=09=09(!pte_val(pte))
+#define pte_clear(mm,addr,ptep)=09set_pte(ptep, __pte(0))
+#define pte_page(pte)=09=09(pfn_to_page(pte_pfn(pte)))
+#define pte_offset_kernel(dir,addr)=09(pmd_page_vaddr(*(dir)) + __pte_inde=
x(addr))
+
+#define pte_offset_map(dir,addr)=09pte_offset_kernel((dir), (addr))
+#define pte_offset_map_nested(dir,addr)=09pte_offset_kernel((dir), (addr))
+#define pte_unmap(pte)=09=09=09do { } while (0)
+#define pte_unmap_nested(pte)=09=09do { } while (0)
+
+/*
+ * The following only work if pte_present(). Undefined behaviour otherwise=
.
+ */
+#define pte_present(pte)=09(pte_val(pte) & PTE_VALID)
+#define pte_dirty(pte)=09=09(pte_val(pte) & PTE_DIRTY)
+#define pte_young(pte)=09=09(pte_val(pte) & PTE_AF)
+#define pte_special(pte)=09(pte_val(pte) & PTE_SPECIAL)
+#define pte_write(pte)=09=09(!(pte_val(pte) & PTE_RDONLY))
+#define pte_exec(pte)=09=09(!(pte_val(pte) & PTE_XN))
+
+#define pte_present_exec_user(pte) \
+=09((pte_val(pte) & (PTE_VALID | PTE_USER | PTE_XN)) =3D=3D \
+=09 (PTE_VALID | PTE_USER))
+
+#define PTE_BIT_FUNC(fn,op) \
+static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
+
+PTE_BIT_FUNC(wrprotect, |=3D PTE_RDONLY);
+PTE_BIT_FUNC(mkwrite,   &=3D ~PTE_RDONLY);
+PTE_BIT_FUNC(mkclean,   &=3D ~PTE_DIRTY);
+PTE_BIT_FUNC(mkdirty,   |=3D PTE_DIRTY);
+PTE_BIT_FUNC(mkold,     &=3D ~PTE_AF);
+PTE_BIT_FUNC(mkyoung,   |=3D PTE_AF);
+PTE_BIT_FUNC(mkspecial, |=3D PTE_SPECIAL);
+
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+=09*ptep =3D pte;
+}
+
+extern void __sync_icache_dcache(pte_t pteval);
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+=09=09=09      pte_t *ptep, pte_t pte)
+{
+=09if (pte_present_exec_user(pte))
+=09=09__sync_icache_dcache(pte);
+=09set_pte(ptep, pte);
+}
+
+/*
+ * Huge pte definitions.
+ */
+#define pte_huge(pte)=09=09((pte_val(pte) & PTE_TYPE_MASK) =3D=3D PTE_TYPE=
_HUGEPAGE)
+#define pte_mkhuge(pte)=09=09(__pte((pte_val(pte) & ~PTE_TYPE_MASK) | PTE_=
TYPE_HUGEPAGE))
+
+#define __pgprot_modify(prot,mask,bits)=09=09\
+=09__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
+
+#define __HAVE_ARCH_PTE_SPECIAL
+
+/*
+ * Mark the prot value as uncacheable and unbufferable.
+ */
+#define pgprot_noncached(prot) \
+=09__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE)=
)
+#define pgprot_writecombine(prot) \
+=09__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_GRE))
+#define pgprot_dmacoherent(prot) \
+=09__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC))
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+=09=09=09=09     unsigned long size, pgprot_t vma_prot);
+
+#define pmd_none(pmd)=09=09(!pmd_val(pmd))
+#define pmd_present(pmd)=09(pmd_val(pmd))
+
+#define pmd_bad(pmd)=09=09(!(pmd_val(pmd) & 2))
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+=09*pmdp =3D pmd;
+=09dsb();
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+=09set_pmd(pmdp, __pmd(0));
+}
+
+static inline pte_t *pmd_page_vaddr(pmd_t pmd)
+{
+=09return __va(pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK);
+}
+
+#define pmd_page(pmd)=09=09pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_M=
ASK))
+
+/*
+ * Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ */
+#define mk_pte(page,prot)=09pfn_pte(page_to_pfn(page),prot)
+
+#ifndef CONFIG_ARM64_64K_PAGES
+
+#define pud_none(pud)=09=09(!pud_val(pud))
+#define pud_bad(pud)=09=09(!(pud_val(pud) & 2))
+#define pud_present(pud)=09(pud_val(pud))
+
+static inline void set_pud(pud_t *pudp, pud_t pud)
+{
+=09*pudp =3D pud;
+=09dsb();
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+=09set_pud(pudp, __pud(0));
+}
+
+static inline pmd_t *pud_page_vaddr(pud_t pud)
+{
+=09return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
+}
+
+#endif=09/* CONFIG_ARM64_64K_PAGES */
+
+/* to find an entry in a page-table-directory */
+#define pgd_index(addr)=09=09(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)=
)
+
+#define pgd_offset(mm, addr)=09((mm)->pgd+pgd_index(addr))
+
+/* to find an entry in a kernel page-table-directory */
+#define pgd_offset_k(addr)=09pgd_offset(&init_mm, addr)
+
+/* Find an entry in the second-level page table.. */
+#ifndef CONFIG_ARM64_64K_PAGES
+#define pmd_index(addr)=09=09(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
+{
+=09return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
+}
+#endif
+
+/* Find an entry in the third-level page table.. */
+#define __pte_index(addr)=09(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+=09const pteval_t mask =3D PTE_USER | PTE_XN | PTE_RDONLY;
+=09pte_val(pte) =3D (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
+=09return pte;
+}
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+
+#define SWAPPER_DIR_SIZE=09(3 * PAGE_SIZE)
+#define IDMAP_DIR_SIZE=09=09(2 * PAGE_SIZE)
+
+/*
+ * Encode and decode a swap entry:
+ *=09bits 0-1:=09present (must be zero)
+ *=09bit  2:=09=09PTE_FILE
+ *=09bits 3-8:=09swap type
+ *=09bits 9-63:=09swap offset
+ */
+#define __SWP_TYPE_SHIFT=093
+#define __SWP_TYPE_BITS=09=096
+#define __SWP_TYPE_MASK=09=09((1 << __SWP_TYPE_BITS) - 1)
+#define __SWP_OFFSET_SHIFT=09(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+
+#define __swp_type(x)=09=09(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MAS=
K)
+#define __swp_offset(x)=09=09((x).val >> __SWP_OFFSET_SHIFT)
+#define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SH=
IFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+
+#define __pte_to_swp_entry(pte)=09((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(swp)=09((pte_t) { (swp).val })
+
+/*
+ * Ensure that there are not more swap files than can be encoded in the ke=
rnel
+ * the PTEs.
+ */
+#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYP=
E_BITS)
+
+/*
+ * Encode and decode a file entry:
+ *=09bits 0-1:=09present (must be zero)
+ *=09bit  2:=09=09PTE_FILE
+ *=09bits 3-63:=09file offset / PAGE_SIZE
+ */
+#define pte_file(pte)=09=09(pte_val(pte) & PTE_FILE)
+#define pte_to_pgoff(x)=09=09(pte_val(x) >> 3)
+#define pgoff_to_pte(x)=09=09__pte(((x) << 3) | PTE_FILE)
+
+#define PTE_FILE_MAX_BITS=0961
+
+extern int kern_addr_valid(unsigned long addr);
+
+#include <asm-generic/pgtable.h>
+
+/*
+ * remap a physical page `pfn' of size `size' with page protection `prot'
+ * into virtual address `from'
+ */
+#define io_remap_pfn_range(vma,from,pfn,size,prot) \
+=09=09remap_pfn_range(vma, from, pfn, size, prot)
+
+#define pgtable_cache_init() do { } while (0)
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sp=
arsemem.h
new file mode 100644
index 0000000..1be62bc
--- /dev/null
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -0,0 +1,24 @@
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
+#ifndef __ASM_SPARSEMEM_H
+#define __ASM_SPARSEMEM_H
+
+#ifdef CONFIG_SPARSEMEM
+#define MAX_PHYSMEM_BITS=0940
+#define SECTION_SIZE_BITS=0930
+#endif
+
+#endif

