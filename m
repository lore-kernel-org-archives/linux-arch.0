Return-Path: <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v6 10/11] powerpc/mm: Adds counting method to track
 lockless pagetable walks
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-11-leonardo@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d9bf6878-43d5-b45a-7abb-cdcb712a0d7a@c-s.fr>
Date: Thu, 6 Feb 2020 07:23:24 +0100
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-11-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
To: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206062324.fkrZXZ-cxIvlpaaV1CkO0m4c2M-seNkns_4-e2mlDmY@z>



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Implements an additional feature to track lockless pagetable walks,
> using a per-cpu counter: lockless_pgtbl_walk_counter.
> 
> Before a lockless pagetable walk, preemption is disabled and the
> current cpu's counter is increased.
> When the lockless pagetable walk finishes, the current cpu counter
> is decreased and the preemption is enabled.
> 
> With that, it's possible to know in which cpus are happening lockless
> pagetable walks, and optimize serialize_against_pte_lookup().
> 
> Implementation notes:
> - Every counter can be changed only by it's CPU
> - It makes use of the original memory barrier in the functions
> - Any counter can be read by any CPU
> 
> Due to not locking nor using atomic variables, the impact on the
> lockless pagetable walk is intended to be minimum.

atomic variables have a lot less impact than preempt_enable/disable.

preemt_disable forces a re-scheduling, it really has impact. Why not use 
atomic variables instead ?

Christophe

> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/mm/book3s64/pgtable.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 535613030363..bb138b628f86 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -83,6 +83,7 @@ static void do_nothing(void *unused)
>   
>   }
>   
> +static DEFINE_PER_CPU(int, lockless_pgtbl_walk_counter);
>   /*
>    * Serialize against find_current_mm_pte which does lock-less
>    * lookup in page tables with local interrupts disabled. For huge pages
> @@ -120,6 +121,15 @@ unsigned long __begin_lockless_pgtbl_walk(bool disable_irq)
>   	if (disable_irq)
>   		local_irq_save(irq_mask);
>   
> +	/*
> +	 * Counts this instance of lockless pagetable walk for this cpu.
> +	 * Disables preempt to make sure there is no cpu change between
> +	 * begin/end lockless pagetable walk, so that percpu counting
> +	 * works fine.
> +	 */
> +	preempt_disable();
> +	(*this_cpu_ptr(&lockless_pgtbl_walk_counter))++;
> +
>   	/*
>   	 * This memory barrier pairs with any code that is either trying to
>   	 * delete page tables, or split huge pages. Without this barrier,
> @@ -158,6 +168,14 @@ inline void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq)
>   	 */
>   	smp_mb();
>   
> +	/*
> +	 * Removes this instance of lockless pagetable walk for this cpu.
> +	 * Enables preempt only after end lockless pagetable walk,
> +	 * so that percpu counting works fine.
> +	 */
> +	(*this_cpu_ptr(&lockless_pgtbl_walk_counter))--;
> +	preempt_enable();
> +
>   	/*
>   	 * Interrupts must be disabled during the lockless page table walk.
>   	 * That's because the deleting or splitting involves flushing TLBs,
> 
