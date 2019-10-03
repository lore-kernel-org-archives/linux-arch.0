From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Thu, 3 Oct 2019 09:11:45 +0200
Message-ID: <20191003071145.GM4536@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-2-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20191003013325.2614-2-leonardo@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbel>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 02, 2019 at 10:33:15PM -0300, Leonardo Bras wrote:
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 818691846c90..3043ea9812d5 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1171,6 +1171,64 @@ static inline bool arch_has_pfn_modify_check(void)
>  #endif
>  #endif
>  
> +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> +static inline unsigned long begin_lockless_pgtbl_walk(struct mm_struct *mm)
> +{
> +	unsigned long irq_mask;
> +
> +	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
> +		atomic_inc(&mm->lockless_pgtbl_walkers);

This will not work for file backed THP. Also, this is a fairly serious
contention point all on its own.

> +	/*
> +	 * Interrupts must be disabled during the lockless page table walk.
> +	 * That's because the deleting or splitting involves flushing TLBs,
> +	 * which in turn issues interrupts, that will block when disabled.
> +	 */
> +	local_irq_save(irq_mask);
> +
> +	/*
> +	 * This memory barrier pairs with any code that is either trying to
> +	 * delete page tables, or split huge pages. Without this barrier,
> +	 * the page tables could be read speculatively outside of interrupt
> +	 * disabling.
> +	 */
> +	smp_mb();

I don't think this is something smp_mb() can guarantee. smp_mb() is
defined to order memory accesses, in this case the store of the old
flags vs whatever comes after this.

It cannot (in generic) order against completion of prior instructions,
like clearing the interrupt enabled flags.

Possibly you want barrier_nospec().

> +
> +	return irq_mask;
> +}
