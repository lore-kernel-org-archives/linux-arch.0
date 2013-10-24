From: Steve Capper <steve.capper@linaro.org>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Thu, 24 Oct 2013 11:51:44 +0100
Message-ID: <20131024105143.GA24288@linaro.org>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:52591 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab3JXKvv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2013 06:51:51 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so2086437wes.23
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2013 03:51:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Thu, Oct 24, 2013 at 08:16:00AM +0100, Russell King - ARM Linux wrot=
e:
> This is very similar to x86.  I'm just throwing the patch out if peop=
le
> wish to use this to look at things; I'm going to be working on mergin=
g
> it with the x86 version, and hopefully we can have the bulk of this
> support provided in a generic way such that architectures just need t=
o
> define some bitfield data, macros and region data.

Hi Russell,
I've given this a quick go on an Arndale with LPAE, and have a few
suggestions below.

>=20
> 8<=3D=3D=3D
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> ARM: add support to dump the kernel page tables
>=20
> This patch allows the kernel page tables to be dumped via a debugfs f=
ile,
> allowing kernel developers to check the layout of the kernel page tab=
les
> and the verify the various permissions and type settings.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig.debug                |   12 ++
>  arch/arm/include/asm/pgtable-2level.h |    1 +
>  arch/arm/include/asm/pgtable-3level.h |    1 +
>  arch/arm/mm/Makefile                  |    1 +
>  arch/arm/mm/dump.c                    |  328 +++++++++++++++++++++++=
++++++++++
>  5 files changed, 343 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mm/dump.c
>=20
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 583f4a0..261cc75 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -2,6 +2,18 @@ menu "Kernel hacking"
> =20
>  source "lib/Kconfig.debug"
> =20
> +config ARM_PTDUMP
> +	bool "Export kernel pagetable layout ot userspace via debugfs"
> +	depends on DEBUG_KERNEL
> +	select DEBUG_FS
> +	---help---
> +	  Say Y here if you want to show the kernel pagetable layout in a
> +	  debugfs file. This information is only useful for kernel develope=
rs
> +	  who are working in architecture specific areas of the kernel.
> +	  It is probably not a good idea to enable this feature in a produc=
tion
> +	  kernel.
> +	  If in doubt, say "N"
> +
>  config STRICT_DEVMEM
>  	bool "Filter access to /dev/mem"
>  	depends on MMU
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include=
/asm/pgtable-2level.h
> index f97ee02..b082d00 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -160,6 +160,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsig=
ned long addr)
>  	return (pmd_t *)pud;
>  }
> =20
> +#define pmd_large(pmd)		(pmd_val(pmd) & 2)
>  #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
> =20
>  #define copy_pmd(pmdpd,pmdps)		\
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include=
/asm/pgtable-3level.h
> index 5689c18..d7682cd 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -140,6 +140,7 @@
>  						 PMD_TYPE_TABLE)
>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D \
>  						 PMD_TYPE_SECT)
> +#define pmd_large(pmd)		pmd_sect(pmd)

Could we please instead do something like:
#define pmd_large(pmd)         (pmd_val(pmd) && !(pmd_val(pmd) & PMD_TA=
BLE_BIT))

This matches the logic used in the huge pages patches (it picks up the
PROT_NONE case) that would be missed above.

> =20
>  #define pud_clear(pudp)			\
>  	do {				\
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index ecfe6e5..7f39ce2 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -12,6 +12,7 @@ ifneq ($(CONFIG_MMU),y)
>  obj-y				+=3D nommu.o
>  endif
> =20
> +obj-$(CONFIG_ARM_PTDUMP)	+=3D dump.o
>  obj-$(CONFIG_MODULES)		+=3D proc-syms.o
> =20
>  obj-$(CONFIG_ALIGNMENT_TRAP)	+=3D alignment.o
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> new file mode 100644
> index 0000000..4979d4c
> --- /dev/null
> +++ b/arch/arm/mm/dump.c
> @@ -0,0 +1,328 @@
> +/*
> + * Debug helper to dump the current kernel pagetables of the system
> + * so that we can see what the various memory ranges are set to.
> + *
> + * Derived from x86 implementation:
> + * (C) Copyright 2008 Intel Corporation
> + *
> + * Author: Arjan van de Ven <arjan@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/fixmap.h>
> +#include <asm/pgtable.h>
> +
> +struct addr_marker {
> +	unsigned long start_address;
> +	const char *name;
> +};
> +
> +static struct addr_marker address_markers[] =3D {
> +	{ MODULES_VADDR,	"Modules" },
> +	{ PAGE_OFFSET,		"Kernel Mapping" },
> +	{ 0,			"vmalloc() Area" },
> +	{ VMALLOC_END,		"vmalloc() End" },
> +	{ FIXADDR_START,	"Fixmap Area" },
> +	{ CONFIG_VECTORS_BASE,	"Vectors" },
> +	{ CONFIG_VECTORS_BASE + PAGE_SIZE * 2, "Vectors End" },
> +	{ -1,			NULL },
> +};
> +
> +struct pg_state {
> +	struct seq_file *seq;
> +	const struct addr_marker *marker;
> +	unsigned long start_address;
> +	unsigned level;
> +	u64 current_prot;
> +};
> +
> +struct prot_bits {
> +	u64		mask;
> +	u64		val;
> +	const char	*set;
> +	const char	*clear;
> +};
> +
> +static const struct prot_bits pte_bits[] =3D {
> +	{
> +		.mask	=3D L_PTE_USER,
> +		.val	=3D L_PTE_USER,
> +		.set	=3D "USR",
> +		.clear	=3D "   ",
> +	}, {
> +		.mask	=3D L_PTE_RDONLY,
> +		.val	=3D L_PTE_RDONLY,
> +		.set	=3D "ro",
> +		.clear	=3D "RW",
> +	}, {
> +		.mask	=3D L_PTE_XN,
> +		.val	=3D L_PTE_XN,
> +		.set	=3D "NX",
> +		.clear	=3D "x ",
> +	}, {
> +		.mask	=3D L_PTE_SHARED,
> +		.val	=3D L_PTE_SHARED,
> +		.set	=3D "SHD",
> +		.clear	=3D "   ",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_UNCACHED,
> +		.set	=3D "SO/UNCACHED",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_BUFFERABLE,
> +		.set	=3D "MEM/BUFFERABLE/WC",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_WRITETHROUGH,
> +		.set	=3D "MEM/CACHED/WT",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_WRITEBACK,
> +		.set	=3D "MEM/CACHED/WBRA",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_MINICACHE,
> +		.set	=3D "MEM/MINICACHE",
> +	}, {

This throws the following compile error when I have LPAE enabled:
arch/arm/mm/dump.c:93:10: error: =E2=80=98L_PTE_MT_MINICACHE=E2=80=99 u=
ndeclared here (not in a function)

> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_WRITEALLOC,
> +		.set	=3D "MEM/CACHED/WBWA",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_DEV_SHARED,
> +		.set	=3D "DEV/SHARED",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_DEV_NONSHARED,
> +		.set	=3D "DEV/NONSHARED",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_DEV_WC,
> +		.set	=3D "DEV/WC",
> +	}, {
> +		.mask	=3D L_PTE_MT_MASK,
> +		.val	=3D L_PTE_MT_DEV_CACHED,
> +		.set	=3D "DEV/CACHED",
> +	},
> +};
> +
> +static const struct prot_bits section_bits[] =3D {
> +	/* These are approximate */
> +	{
> +		.mask	=3D PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	=3D 0,
> +		.set	=3D "    ro",
> +	}, {
> +		.mask	=3D PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	=3D PMD_SECT_AP_WRITE,
> +		.set	=3D "    RW",
> +	}, {
> +		.mask	=3D PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	=3D PMD_SECT_AP_READ,
> +		.set	=3D "USR RO",
> +	}, {
> +		.mask	=3D PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	=3D PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.set	=3D "USR RW",
> +	}, {
> +		.mask	=3D PMD_SECT_XN,
> +		.val	=3D PMD_SECT_XN,
> +		.set	=3D "NX",
> +		.clear	=3D "x ",
> +	}, {
> +		.mask	=3D PMD_SECT_S,
> +		.val	=3D PMD_SECT_S,
> +		.set	=3D "SHD",
> +		.clear	=3D "   ",
> +	},
> +};
> +
> +struct pg_level {
> +	const struct prot_bits *bits;
> +	size_t num;
> +	u64 mask;
> +};
> +
> +static struct pg_level pg_level[] =3D {
> +	{
> +	}, { /* pgd */
> +	}, { /* pud */
> +	}, { /* pmd */
> +		.bits	=3D section_bits,
> +		.num	=3D ARRAY_SIZE(section_bits),
> +	}, { /* pte */
> +		.bits	=3D pte_bits,
> +		.num	=3D ARRAY_SIZE(pte_bits),
> +	},
> +};
> +
> +static void dump_prot(struct pg_state *st, const struct prot_bits *b=
its, size_t num)
> +{
> +	unsigned i;
> +
> +	for (i =3D 0; i < num; i++, bits++) {
> +		const char *s;
> +
> +		if ((st->current_prot & bits->mask) =3D=3D bits->val)
> +			s =3D bits->set;
> +		else
> +			s =3D bits->clear;
> +
> +		if (s)
> +			seq_printf(st->seq, " %s", s);
> +	}
> +}
> +
> +static void note_page(struct pg_state *st, unsigned long addr, unsig=
ned level, u64 val)
> +{
> +	static const char units[] =3D "KMGTPE";
> +	u64 prot =3D val & pg_level[level].mask;
> +
> +	if (addr < USER_PGTABLES_CEILING)
> +		return;
> +
> +	if (!st->level) {
> +		st->level =3D level;
> +		st->current_prot =3D prot;
> +		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +	} else if (prot !=3D st->current_prot || level !=3D st->level ||
> +		   addr >=3D st->marker[1].start_address) {
> +		const char *unit =3D units;
> +		unsigned long delta;
> +
> +		if (st->current_prot) {
> +			seq_printf(st->seq, "0x%08lx-0x%08lx   ",
> +				   st->start_address, addr);
> +
> +			delta =3D (addr - st->start_address) >> 10;
> +			while (!(delta & 1023) && unit[1]) {
> +				delta >>=3D 10;
> +				unit++;
> +			}
> +			seq_printf(st->seq, "%9lu%c", delta, *unit);
> +			if (pg_level[st->level].bits)
> +				dump_prot(st, pg_level[st->level].bits, pg_level[st->level].num)=
;
> +			seq_printf(st->seq, "\n");
> +		}
> +
> +		if (addr >=3D st->marker[1].start_address) {
> +			st->marker++;
> +			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +		}
> +		st->start_address =3D addr;
> +		st->current_prot =3D prot;
> +		st->level =3D level;
> +	}
> +}
> +
> +static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long =
start)
> +{
> +	pte_t *pte =3D pte_offset_kernel(pmd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i =3D 0; i < PTRS_PER_PTE; i++, pte++) {
> +		addr =3D start + i * PAGE_SIZE;
> +		note_page(st, addr, 4, pte_val(*pte));
> +	}
> +}
> +
> +static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long =
start)
> +{
> +	pmd_t *pmd =3D pmd_offset(pud, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i =3D 0; i < PTRS_PER_PMD; i++, pmd++) {
> +		addr =3D start + i * PMD_SIZE;
> +		if (pmd_none(*pmd) || pmd_large(*pmd) || !pmd_present(*pmd))
> +			note_page(st, addr, 3, pmd_val(*pmd));
> +		else
> +			walk_pte(st, pmd, addr);
> +	}
> +}
> +
> +static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long =
start)
> +{
> +	pud_t *pud =3D pud_offset(pgd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i =3D 0; i < PTRS_PER_PUD; i++, pud++) {
> +		addr =3D start + i * PUD_SIZE;
> +		if (!pud_none(*pud)) {
> +			walk_pmd(st, pud, addr);
> +		} else {
> +			note_page(st, addr, 2, pud_val(*pud));
> +		}
> +	}
> +}
> +
> +static void walk_pgd(struct seq_file *m)
> +{
> +	pgd_t *pgd =3D swapper_pg_dir;
> +	struct pg_state st;
> +	unsigned long addr;
> +	unsigned i;
> +
> +	memset(&st, 0, sizeof(st));
> +	st.seq =3D m;
> +	st.marker =3D address_markers;
> +
> +	for (i =3D USER_PGTABLES_CEILING / PGDIR_SIZE;
> +	     i < PTRS_PER_PGD; i++, pgd++) {
> +		addr =3D i * PGDIR_SIZE;
> +		if (!pgd_none(*pgd)) {
> +			walk_pud(&st, pgd, addr);
> +		} else {
> +			note_page(&st, addr, 1, pgd_val(*pgd));
> +		}
> +	}
> +
> +	note_page(&st, 0, 0, 0);
> +}

The logic here needs adjusting for LPAE. Without LPAE,
USER_PGTABLES_CEILING is equal to zero and i at 0.

With LPAE enabled, USER_PGTABLES_CEILING / PGDIR_SIZE =3D=3D 2 for me, =
but
pgd refers to the first pgd (not the third). Thus we walk the pgds we
don't want to walk and get empty output.

The following worked for me:
  static void walk_pgd(struct seq_file *m)
  {
          pgd_t *pgd =3D swapper_pg_dir;
          struct pg_state st;
          unsigned long addr;
          unsigned i, pgdoff =3D USER_PGTABLES_CEILING / PGDIR_SIZE;

          memset(&st, 0, sizeof(st));
          st.seq =3D m;
          st.marker =3D address_markers;

          pgd +=3D pgdoff;

          for (i =3D pgdoff; i < PTRS_PER_PGD; i++, pgd++) {
                  addr =3D i * PGDIR_SIZE;
                  if (!pgd_none(*pgd)) {
                          walk_pud(&st, pgd, addr);
                  } else {
                          note_page(&st, addr, 1, pgd_val(*pgd));
                  }
          }

          note_page(&st, 0, 0, 0);
  }

But pgdoff is a terrible variable name :-).

> +
> +static int ptdump_show(struct seq_file *m, void *v)
> +{
> +	walk_pgd(m);
> +	return 0;
> +}
> +
> +static int ptdump_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ptdump_show, NULL);
> +}
> +
> +static const struct file_operations ptdump_fops =3D {
> +	.open		=3D ptdump_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +};
> +
> +static int ptdump_init(void)
> +{
> +	struct dentry *pe;
> +	unsigned i, j;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pg_level); i++)
> +		if (pg_level[i].bits)
> +			for (j =3D 0; j < pg_level[i].num; j++)
> +				pg_level[i].mask |=3D pg_level[i].bits[j].mask;
> +
> +	address_markers[2].start_address =3D VMALLOC_START;
> +
> +	pe =3D debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
> +				 &ptdump_fops);
> +	return pe ? 0 : -ENOMEM;
> +}
> +__initcall(ptdump_init);
> --=20
> 1.7.4.4

Cheers,
--=20
Steve
