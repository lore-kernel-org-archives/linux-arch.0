From: Laura Abbott <lauraa@codeaurora.org>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Thu, 31 Oct 2013 10:28:38 -0700
Message-ID: <52729346.7080709@codeaurora.org>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47870 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3JaR2l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 13:28:41 -0400
In-Reply-To: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org

On 10/24/2013 12:16 AM, Russell King - ARM Linux wrote:
...
> +
> +static const struct prot_bits pte_bits[] = {
> +	{
> +		.mask	= L_PTE_USER,
> +		.val	= L_PTE_USER,
> +		.set	= "USR",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= L_PTE_RDONLY,
> +		.val	= L_PTE_RDONLY,
> +		.set	= "ro",
> +		.clear	= "RW",
> +	}, {
> +		.mask	= L_PTE_XN,
> +		.val	= L_PTE_XN,
> +		.set	= "NX",
> +		.clear	= "x ",
> +	}, {
> +		.mask	= L_PTE_SHARED,
> +		.val	= L_PTE_SHARED,
> +		.set	= "SHD",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_UNCACHED,
> +		.set	= "SO/UNCACHED",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_BUFFERABLE,
> +		.set	= "MEM/BUFFERABLE/WC",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_WRITETHROUGH,
> +		.set	= "MEM/CACHED/WT",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_WRITEBACK,
> +		.set	= "MEM/CACHED/WBRA",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_MINICACHE,
> +		.set	= "MEM/MINICACHE",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_WRITEALLOC,
> +		.set	= "MEM/CACHED/WBWA",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_DEV_SHARED,
> +		.set	= "DEV/SHARED",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_DEV_NONSHARED,
> +		.set	= "DEV/NONSHARED",
> +	}, {

L_PTE_MT_DEV_SHARED and L_PTE_MT_DEV_NONSHARED are the same on LPAE 
systems which leads to bad output:

0xcd400000-0xcd401000           4K     RW NX SHD DEV/SHARED DEV/NONSHARED


> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_DEV_WC,
> +		.set	= "DEV/WC",
> +	}, {
> +		.mask	= L_PTE_MT_MASK,
> +		.val	= L_PTE_MT_DEV_CACHED,
> +		.set	= "DEV/CACHED",
> +	},
> +};
> +
> +static const struct prot_bits section_bits[] = {
> +	/* These are approximate */
> +	{
> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	= 0,
> +		.set	= "    ro",
> +	}, {
> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	= PMD_SECT_AP_WRITE,
> +		.set	= "    RW",
> +	}, {
> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	= PMD_SECT_AP_READ,
> +		.set	= "USR RO",
> +	}, {
> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.val	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
> +		.set	= "USR RW",
> +	}, {

Same issue here for PMD_SECT_AP_READ and PMD_SEC_AP_WRITE, both of those 
are 0 on LPAE so the output looks strange:

0xc0000000-0xcd400000         212M     ro     RW USR RO USR RW x  SHD


> +		.mask	= PMD_SECT_XN,
> +		.val	= PMD_SECT_XN,
> +		.set	= "NX",
> +		.clear	= "x ",
> +	}, {
> +		.mask	= PMD_SECT_S,
> +		.val	= PMD_SECT_S,
> +		.set	= "SHD",
> +		.clear	= "   ",
> +	},
> +};
> +
> +struct pg_level {
> +	const struct prot_bits *bits;
> +	size_t num;
> +	u64 mask;
> +};
> +
> +static struct pg_level pg_level[] = {
> +	{
> +	}, { /* pgd */
> +	}, { /* pud */
> +	}, { /* pmd */
> +		.bits	= section_bits,
> +		.num	= ARRAY_SIZE(section_bits),
> +	}, { /* pte */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	},
> +};
> +
> +static void dump_prot(struct pg_state *st, const struct prot_bits *bits, size_t num)
> +{
> +	unsigned i;
> +
> +	for (i = 0; i < num; i++, bits++) {
> +		const char *s;
> +
> +		if ((st->current_prot & bits->mask) == bits->val)
> +			s = bits->set;
> +		else
> +			s = bits->clear;
> +
> +		if (s)
> +			seq_printf(st->seq, " %s", s);
> +	}
> +}
> +
> +static void note_page(struct pg_state *st, unsigned long addr, unsigned level, u64 val)
> +{
> +	static const char units[] = "KMGTPE";
> +	u64 prot = val & pg_level[level].mask;
> +
> +	if (addr < USER_PGTABLES_CEILING)
> +		return;
> +
> +	if (!st->level) {
> +		st->level = level;
> +		st->current_prot = prot;
> +		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +	} else if (prot != st->current_prot || level != st->level ||
> +		   addr >= st->marker[1].start_address) {
> +		const char *unit = units;
> +		unsigned long delta;
> +
> +		if (st->current_prot) {
> +			seq_printf(st->seq, "0x%08lx-0x%08lx   ",
> +				   st->start_address, addr);
> +
> +			delta = (addr - st->start_address) >> 10;
> +			while (!(delta & 1023) && unit[1]) {
> +				delta >>= 10;
> +				unit++;
> +			}
> +			seq_printf(st->seq, "%9lu%c", delta, *unit);
> +			if (pg_level[st->level].bits)
> +				dump_prot(st, pg_level[st->level].bits, pg_level[st->level].num);
> +			seq_printf(st->seq, "\n");
> +		}
> +
> +		if (addr >= st->marker[1].start_address) {
> +			st->marker++;
> +			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +		}
> +		st->start_address = addr;
> +		st->current_prot = prot;
> +		st->level = level;
> +	}
> +}
> +
> +static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
> +{
> +	pte_t *pte = pte_offset_kernel(pmd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
> +		addr = start + i * PAGE_SIZE;
> +		note_page(st, addr, 4, pte_val(*pte));
> +	}
> +}
> +
> +static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> +{
> +	pmd_t *pmd = pmd_offset(pud, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
> +		addr = start + i * PMD_SIZE;
> +		if (pmd_none(*pmd) || pmd_large(*pmd) || !pmd_present(*pmd))
> +			note_page(st, addr, 3, pmd_val(*pmd));
> +		else
> +			walk_pte(st, pmd, addr);
> +	}
> +}
> +
> +static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +	pud_t *pud = pud_offset(pgd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
> +		addr = start + i * PUD_SIZE;
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
> +	pgd_t *pgd = swapper_pg_dir;
> +	struct pg_state st;
> +	unsigned long addr;
> +	unsigned i;
> +
> +	memset(&st, 0, sizeof(st));
> +	st.seq = m;
> +	st.marker = address_markers;
> +
> +	for (i = USER_PGTABLES_CEILING / PGDIR_SIZE;
> +	     i < PTRS_PER_PGD; i++, pgd++) {
> +		addr = i * PGDIR_SIZE;
> +		if (!pgd_none(*pgd)) {
> +			walk_pud(&st, pgd, addr);
> +		} else {
> +			note_page(&st, addr, 1, pgd_val(*pgd));
> +		}
> +	}
> +
> +	note_page(&st, 0, 0, 0);
> +}
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
> +static const struct file_operations ptdump_fops = {
> +	.open		= ptdump_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int ptdump_init(void)
> +{
> +	struct dentry *pe;
> +	unsigned i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
> +		if (pg_level[i].bits)
> +			for (j = 0; j < pg_level[i].num; j++)
> +				pg_level[i].mask |= pg_level[i].bits[j].mask;
> +
> +	address_markers[2].start_address = VMALLOC_START;
> +
> +	pe = debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
> +				 &ptdump_fops);
> +	return pe ? 0 : -ENOMEM;
> +}
> +__initcall(ptdump_init);
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
