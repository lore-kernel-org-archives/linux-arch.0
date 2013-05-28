From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: TLB and PTE coherency during munmap
Date: Tue, 28 May 2013 15:35:44 +0100
Message-ID: <CAHkRjk4ZNwZvf_Cv+HqfMManodCkEpCPdZokPQ68z3nVG8-+wg@mail.gmail.com>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:54605 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934279Ab3E1OgE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2013 10:36:04 -0400
In-Reply-To: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm@vger.kernel.org, linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>

Max,

On 26 May 2013 03:42, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hello arch and mm people.
>
> Is it intentional that threads of a process that invoked munmap syscall
> can see TLB entries pointing to already freed pages, or it is a bug?

If it happens, this would be a bug. It means that a process can access
a physical page that has been allocated to something else, possibly
kernel data.

> I'm talking about zap_pmd_range and zap_pte_range:
>
>       zap_pmd_range
>         zap_pte_range
>           arch_enter_lazy_mmu_mode
>             ptep_get_and_clear_full
>             tlb_remove_tlb_entry
>             __tlb_remove_page
>           arch_leave_lazy_mmu_mode
>         cond_resched
>
> With the default arch_{enter,leave}_lazy_mmu_mode, tlb_remove_tlb_entry
> and __tlb_remove_page there is a loop in the zap_pte_range that clears
> PTEs and frees corresponding pages, but doesn't flush TLB, and
> surrounding loop in the zap_pmd_range that calls cond_resched. If a thread
> of the same process gets scheduled then it is able to see TLB entries
> pointing to already freed physical pages.

It looks to me like cond_resched() here introduces a possible bug but
it depends on the actual arch code, especially the
__tlb_remove_tlb_entry() function. On ARM we record the range in
tlb_remove_tlb_entry() and queue the pages to be removed in
__tlb_remove_page(). It pretty much acts like tlb_fast_mode() == 0
even for the UP case (which is also needed for hardware speculative
TLB loads). The tlb_finish_mmu() takes care of whatever pages are left
to be freed.

With a dummy __tlb_remove_tlb_entry() and tlb_fast_mode() == 1,
cond_resched() in zap_pmd_range() would cause problems.

I think possible workarounds:

1. tlb_fast_mode() always returning 0.
2. add a tlb_flush_mmu(tlb) before cond_resched() in zap_pmd_range().
3. implement __tlb_remove_tlb_entry() on xtensa to always flush the
tlb (which is probably costly).
4. drop the cond_resched() (not sure about preemptible kernels though).

I would vote for 1 but let's see what the mm people say.

--
Catalin
