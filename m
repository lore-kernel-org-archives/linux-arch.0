From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH] Update the cachetlb.txt file WRT flush_dcache_page
 and update_mmu_cache
Date: Mon, 10 May 2010 09:40:08 -0500
Message-ID: <1273502408.4424.4.camel@mulgrave.site>
References: <20100507132418.28009.6013.stgit@e102109-lin.cambridge.arm.com>
	 <20100510170616O.fujita.tomonori@lab.ntt.co.jp>
	 <1273486607.3023.37.camel@e102109-lin.cambridge.arm.com>
	 <20100510102947.GA14278@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100510102947.GA14278@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, davem@davemloft.net, rmk@arm.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On Mon, 2010-05-10 at 19:29 +0900, Paul Mundt wrote:
> On Mon, May 10, 2010 at 11:16:47AM +0100, Catalin Marinas wrote:
> > In most situations, just doing flushing in set_pte_at() would suffice
> > and flush_dcache_page() can be ignored. There are two situations where I
> > still see flush_dcache_page() useful:
> > 
> >      1. SMP systems where the cache maintenance operations aren't
> >         automatically broadcast in hardware
> >      2. The kernel modifies a page cache page that is already mapped in
> >         user space
> > 
> > (1) can be worked around on some architectures (though not sure about
> > all of them).
> > 
> > Is (2) a valid scenario?
> > 
> get_user_pages() ?

Actually, no, not really.  get_user_pages() is preparing the pages for
DMA (so it pins and possibly flushes them to make the underlying
physical page in the page cache clean).  This means it gathers the
physical pages into a scatter gather list.  It actually assumes the
kernel *won't* be touching them (without using kmap), so it doesn't give
the pages an in-kernel mapping.

James
