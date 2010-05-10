From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC PATCH] Update the cachetlb.txt file WRT flush_dcache_page and update_mmu_cache
Date: Mon, 10 May 2010 19:29:48 +0900
Message-ID: <20100510102947.GA14278@linux-sh.org>
References: <20100507132418.28009.6013.stgit@e102109-lin.cambridge.arm.com> <20100510170616O.fujita.tomonori@lab.ntt.co.jp> <1273486607.3023.37.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:43951 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0EJKad (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2010 06:30:33 -0400
Content-Disposition: inline
In-Reply-To: <1273486607.3023.37.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, benh@kernel.crashing.org, davem@davemloft.net, rmk@arm.linux.org.uk

On Mon, May 10, 2010 at 11:16:47AM +0100, Catalin Marinas wrote:
> In most situations, just doing flushing in set_pte_at() would suffice
> and flush_dcache_page() can be ignored. There are two situations where I
> still see flush_dcache_page() useful:
> 
>      1. SMP systems where the cache maintenance operations aren't
>         automatically broadcast in hardware
>      2. The kernel modifies a page cache page that is already mapped in
>         user space
> 
> (1) can be worked around on some architectures (though not sure about
> all of them).
> 
> Is (2) a valid scenario?
> 
get_user_pages() ?
