From: Max Filippov <jcmvbkbc@gmail.com>
Subject: TLB and PTE coherency during munmap
Date: Sun, 26 May 2013 06:50:46 +0400
Message-ID: <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58242 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758497Ab3EZCuq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 May 2013 22:50:46 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so7625862oag.5
        for <linux-arch@vger.kernel.org>; Sat, 25 May 2013 19:50:46 -0700 (PDT)
In-Reply-To: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>

Hello arch and mm people.

Is it intentional that threads of a process that invoked munmap syscall
can see TLB entries pointing to already freed pages, or it is a bug?

I'm talking about zap_pmd_range and zap_pte_range:

      zap_pmd_range
        zap_pte_range
          arch_enter_lazy_mmu_mode
            ptep_get_and_clear_full
            tlb_remove_tlb_entry
            __tlb_remove_page
          arch_leave_lazy_mmu_mode
        cond_resched

With the default arch_{enter,leave}_lazy_mmu_mode, tlb_remove_tlb_entry
and __tlb_remove_page there is a loop in the zap_pte_range that clears
PTEs and frees corresponding pages, but doesn't flush TLB, and
surrounding loop in the zap_pmd_range that calls cond_resched. If a thread
of the same process gets scheduled then it is able to see TLB entries
pointing to already freed physical pages.

I've noticed that with xtensa arch when I added a test before returning to
userspace checking that TLB contents agrees with page tables of the
current mm. This check reliably fires with the LTP test mtest05 that
maps, unmaps and accesses memory from multiple threads.

Is there anything wrong in my description, maybe something specific to
my arch, or this issue really exists?

I've also noticed that there are a lot of arches with default implementations
of the involved functions, does that mean that any/all of them have this
issue too?

-- 
Thanks.
-- Max
