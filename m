Return-Path: <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v6 01/11] asm-generic/pgtable: Adds generic functions to
 track lockless pgtable walks
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-2-leonardo@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f55e593c-27d5-df12-602f-ea217f62c5a1@c-s.fr>
Date: Thu, 6 Feb 2020 06:54:39 +0100
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-2-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
To: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206055439.YQTJSwlNIRkEoUJstZ0XdkH2ikmIdWYsOnQzO5gNtmw@z>



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> It's necessary to track lockless pagetable walks, in order to avoid doing
> THP splitting/collapsing during them.
> 
> The default solution is to disable irq before lockless pagetable walks and
> enable it after it's finished.
> 
> On code, this means you can find local_irq_disable() and local_irq_enable()
> around some pieces of code, usually without comments on why it is needed.
> 
> This patch proposes a set of generic functions to be called before starting
> and after finishing a lockless pagetable walk. It is supposed to make clear
> that a lockless pagetable walk happens there, and also carries information
> on why the irq disable/enable is needed.
> 
> begin_lockless_pgtbl_walk()
>          Insert before starting any lockless pgtable walk
> end_lockless_pgtbl_walk()
>          Insert after the end of any lockless pgtable walk
>          (Mostly after the ptep is last used)
> 
> A memory barrier was also added just to make sure there is no speculative
> read outside the interrupt disabled area. Other than that, it is not
> supposed to have any change of behavior from current code.

Is that speculative barrier necessary for all architectures ? Does it 
impact performance ? Shouldn't this be another patch ?

> 
> It is planned to allow arch-specific versions, so that additional steps can
> be added while keeping the code clean.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   include/asm-generic/pgtable.h | 51 +++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index e2e2bef07dd2..8d368d3c0974 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1222,6 +1222,57 @@ static inline bool arch_has_pfn_modify_check(void)
>   #endif
>   #endif
>   
> +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> +/*
> + * begin_lockless_pgtbl_walk: Must be inserted before a function call that does
> + *   lockless pagetable walks, such as __find_linux_pte()
> + */
> +static inline
> +unsigned long begin_lockless_pgtbl_walk(void)

What about keeping the same syntax as local_irq_save(), something like:

#define begin_lockless_pgtbl_walk(flags) \
do {
	local_irq_save(flags);
	smp_mb();
} while (0)

> +{
> +	unsigned long irq_mask;
> +
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
> +
> +	return irq_mask;
> +}
> +
> +/*
> + * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
> + *   returned by a lockless pagetable walk, such as __find_linux_pte()
> + */
> +static inline void end_lockless_pgtbl_walk(unsigned long irq_mask)

Same

#define end_lockless_pgtbl_walk(flags) \
do {
	smp_mb();
	local_irq_restore(flags);
} while (0);

> +{
> +	/*
> +	 * This memory barrier pairs with any code that is either trying to
> +	 * delete page tables, or split huge pages. Without this barrier,
> +	 * the page tables could be read speculatively outside of interrupt
> +	 * disabling.
> +	 */
> +	smp_mb();
> +
> +	/*
> +	 * Interrupts must be disabled during the lockless page table walk.
> +	 * That's because the deleting or splitting involves flushing TLBs,
> +	 * which in turn issues interrupts, that will block when disabled.
> +	 */
> +	local_irq_restore(irq_mask);
> +}
> +#endif
> +
>   /*
>    * On some architectures it depends on the mm if the p4d/pud or pmd
>    * layer of the page table hierarchy is folded or not.
> 

Christophe
