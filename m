Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266327AbUHGIH5@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:63186 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266296AbUHGIH5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Aug 2004 04:07:57 -0400
Date: Sat, 7 Aug 2004 01:07:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: copy_page_range()
Message-ID: <20040807080751.GX17188@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807000529.5ca6e8fe.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Aug 07, 2004 at 12:05:29AM -0700, David S. Miller wrote:
> Every couple months I look at this thing.
> The main issue is that it's very cache unfriendly,
> especially with how sparsely populated the page tables
> are for 64-bit processes.
> As a simple example, it's at the top of the kernel
> profile for 64-bit lat_proc {fork,exec,shell} on
> sparc64.
> And it's in fact the pmd array scans that take all
> of the cache misses, and thus most of the run time.
> An idea I've always been entertaining is to associate
> a bitmask with each pmd table.  For example, a possible
> current implementation could be to abuse page_struct->index
> for this bitmask, and use virt_to_page(pmdp)->index to get
> at it.

Sounds generally reasonable.


On Sat, Aug 07, 2004 at 12:05:29AM -0700, David S. Miller wrote:
> This divides the pmd table into BITS_PER_LONG sections.
> If the bit is set in ->index then we populated at least
> one of the pmd entries in that section.  We never clear
> bits, except at pmd table allocation time.
> Then the pmd scan iterates over ->index, and only actually
> dereferences the pmd entries iff it finds a set bit, and
> it only dereferences the section of pmd entries represented
> by that bit.
> Another idea I've also considered is to implement the
> pgd/pmd levels as a more compact tree, based upon virtual
> address, such as a radix tree.
> I think all of this could be experimented with if we
> abstracted out the pmd/pgd/pte iteration.  So much stuff
> in the kernel mm code is of the form:
> 	for_each_pgd(pgdp)
> 		for_each_pmd(pgdp, pmdp)
> 			for_each_pte(pmdp, ptep)
> 				do_something(ptep)
> At 2-levels, as on most of the 32-bit platforms, things
> aren't so bad.
> Comments?

The number of levels can be abstracted easily. Something to give an
idea of how might be something like this:

struct pte_walk_state {
	pgd_t *pgd;
	pmd_t *pmd;
	pte_t *pte;
	unsigned long vaddr;
};

int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
						struct vm_area_struct *vma)
{
	int cow, ret = 0;
	struct pte_walk_state walk_parent, walk_child;

	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
	spin_lock(&dst->page_table_lock);
	pte_walk_descend_and_create(dst, &walk_child, vma->vm_start);
	for_each_inuse_pte(src, &walk_parent, vma->vm_start, vma->vm_end) {
		if (pte_walk_move_and_create(&walk_child, walk_parent.vaddr)) {
			ret = -ENOMEM;
			break;
		}
		/*
		 * do stuff to child and parent ptes
		 */
		 ...
	}
	spin_unlock(&dst->page_table_lock);
	return ret;
}

void zap_page_range(struct vm_area_struct *vma, unsigned long start,
				unsigned long len, struct zap_details *details)
{
	struct pte_walk_state walk;

	spin_lock(&vma->vm_mm->page_table_lock);
	for_each_inuse_pte(vma->vm_mm, &walk, vma->vm_start, vma->vm_end) {
		/*
		 * wipe pte and do stuff
		 */
		...
	}
	spin_unlock(&vma->vm_mm->page_table_lock);
}

where #define for_each_inuse_pte(mm, walk, start, end) \
	for (pte_walk_descend(mm, walk, start); (walk)->vaddr < (end); \
						next_inuse_pte(walk))

etc.


-- wli
