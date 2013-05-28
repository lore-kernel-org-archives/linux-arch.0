Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44947 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934418Ab3E1PQh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 May 2013 11:16:37 -0400
Date: Tue, 28 May 2013 17:16:34 +0200
From: Michal Hocko <mhocko@suse.cz>
Subject: Re: TLB and PTE coherency during munmap
Message-ID: <20130528151634.GA30672@dhcp22.suse.cz>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
 <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>
Message-ID: <20130528151634.XJ7z7osOUX_YwGA9fgD5MIj0RpqUNvnA2gOooKohhoc@z>

On Sun 26-05-13 06:50:46, Max Filippov wrote:
> Hello arch and mm people.
> 
> Is it intentional that threads of a process that invoked munmap syscall
> can see TLB entries pointing to already freed pages, or it is a bug?
> 
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
> PTEs and frees corresponding pages,

The page is not freed at that time (at least not for the generic
mmu_gather implementation). It is stored into mmu_gather and then freed
along with the tlb flush in tlb_flush_mmu.
[...]
-- 
Michal Hocko
SUSE Labs
