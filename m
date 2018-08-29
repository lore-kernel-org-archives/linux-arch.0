From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text
 poking
Date: Wed, 29 Aug 2018 11:28:39 +0200
Message-ID: <20180829092839.GP24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-6-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829081147.184610-6-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:
> +static void text_poke_fixmap(void *addr, const void *opcode, size_t len,
> +			     struct page *pages[2])
> +{
> +	u8 *vaddr;
> +
> +	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
> +	if (pages[1])
> +		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
> +	vaddr = (u8 *)fix_to_virt(FIX_TEXT_POKE0);
> +	memcpy(vaddr + offset_in_page(addr), opcode, len);
> +
> +	/*
> +	 * clear_fixmap() performs a TLB flush, so no additional TLB
> +	 * flush is needed.
> +	 */
> +	clear_fixmap(FIX_TEXT_POKE0);
> +	if (pages[1])
> +		clear_fixmap(FIX_TEXT_POKE1);
> +	sync_core();
> +	/* Could also do a CLFLUSH here to speed up CPU recovery; but
> +	   that causes hangs on some VIA CPUs. */

Please take this opportunity to fix that comment style.

> +}
> +
> +__ro_after_init struct mm_struct *poking_mm;
> +__ro_after_init unsigned long poking_addr;
> +
> +/**
> + * text_poke_safe() - Pokes the text using a separate address space.
> + *
> + * This is the preferable way for patching the kernel after boot, as it does not
> + * allow other cores to accidentally or maliciously modify the code using the
> + * temporary PTEs.
> + */
> +static void text_poke_safe(void *addr, const void *opcode, size_t len,
> +			   struct page *pages[2])
> +{
> +	temporary_mm_state_t prev;
> +	pte_t pte, *ptep;
> +	spinlock_t *ptl;
> +
> +	/*
> +	 * The lock is not really needed, but this allows to avoid open-coding.
> +	 */
> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> +
> +	pte = mk_pte(pages[0], PAGE_KERNEL);
> +	set_pte_at(poking_mm, poking_addr, ptep, pte);
> +
> +	if (pages[1]) {
> +		pte = mk_pte(pages[1], PAGE_KERNEL);
> +		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
> +	}
> +
> +	/*
> +	 * Loading the temporary mm behaves as a compiler barrier, which
> +	 * guarantees that the PTE will be set at the time memcpy() is done.
> +	 */
> +	prev = use_temporary_mm(poking_mm);
> +
> +	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +
> +	/*
> +	 * Ensure that the PTE is only cleared after copying is done by using a
> +	 * compiler barrier.
> +	 */
> +	barrier();

I tripped over the use of 'done', because even with TSO the store isn't
done once the instruction retires.

All we want to ensure is that the pte_clear() store is issued after the
copy, and that is indeed guaranteed by this.

> +	pte_clear(poking_mm, poking_addr, ptep);
> +
> +	/*
> +	 * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
> +	 * as it also flushes the corresponding "user" address spaces, which
> +	 * does not exist.
> +	 *
> +	 * Poking, however, is already very inefficient since it does not try to
> +	 * batch updates, so we ignore this problem for the time being.
> +	 *
> +	 * Since the PTEs do not exist in other kernel address-spaces, we do
> +	 * not use __flush_tlb_one_kernel(), which when PTI is on would cause
> +	 * more unwarranted TLB flushes.
> +	 */

yuck :-), but yeah.

> +	__flush_tlb_one_user(poking_addr);
> +	if (pages[1]) {
> +		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
> +		__flush_tlb_one_user(poking_addr + PAGE_SIZE);
> +	}
> +	/*
> +	 * Loading the previous page-table hierarchy requires a serializing
> +	 * instruction that already allows the core to see the updated version.
> +	 * Xen-PV is assumed to serialize execution in a similar manner.
> +	 */
> +	unuse_temporary_mm(prev);
> +
> +	pte_unmap_unlock(ptep, ptl);
> +}
