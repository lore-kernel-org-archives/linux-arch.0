From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/3] Cache maintenance on VIPT caches
Date: Tue, 20 Jul 2010 12:37:00 +0100
Message-ID: <1279625820.10002.16.camel@e102109-lin.cambridge.arm.com>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
	 <20100716131908.GA15032@bnru02.bnr.st.com>
	 <1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
	 <20100720185611I.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60332 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932183Ab0GTLhX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Jul 2010 07:37:23 -0400
In-Reply-To: <20100720185611I.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: rabin.vincent@stericsson.com, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Tue, 2010-07-20 at 18:56 +0900, FUJITA Tomonori wrote:
> On Fri, 16 Jul 2010 15:39:17 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > On Fri, 2010-07-16 at 14:19 +0100, Rabin VINCENT wrote:
> > > On Fri, Jun 25, 2010 at 14:01:27 +0200, Catalin Marinas wrote:
> > > > The first and third patches have already been posted in the same form.
> > > > The second patch have been modified to handle all the VIPT caches via
> > > > __sync_icache_dcache(). The initial use case for this patch was dealing
> > > > with an SMP race condition but following suggestions from Rabin, it was
> > > > extended to cover ARMv6 onwards, both UP and SMP.
> > > >
> > > > Any Tested-by's are welcome.
> > > 
> > > This version also fixes the MMC rootfs init crashes, without the need
> > > for the flush_kernel_dcache_page() change:
> > > 
> > > Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>
> > 
> > Thanks for testing.
> 
> This patchset for arm handles I/D coherency (and D aliasing) with
> PG_arch_1, right? If so, can you please send it to linux-arch? I guess
> that some non arm people might be interested in it.

Yes, I will.

ARM uses lazy D-cache flushing as per cachetlb.txt. However, this file
recommends that the meaning of PG_arch_1 is 'dirty' and the bit is set
by flush_dcache_page(). It works fine if all PIO drivers would call
flush_dcache_page() but there are many (the majority?) that don't and we
end up with data corruption in user space. So rather than changing all
the drivers or proposing a PIO API (tried this as well :)), we changed
the meaning of PG_arch_1 to 'clean'. That's already done by PowerPC and
IA-64.

This was discussed on linux-arch on several occasions and I also posted
a patch to change the recommendations in cachetlb.txt
(http://thread.gmane.org/gmane.linux.kernel.cross-arch/6187).

> > > I ask because the
> > > mmci patches that I posted convert that driver to use the sg_miter API
> > > (which uses flush_kernel_dcache_page() internally), and not do any
> > > flushing inside the driver itself.  Or do you think it would be
> > > appropriate to have the driver call flush_dcache_page() explicitly?
> > > (Although this would be double flushing on systems with aliasing caches
> > > where flush_kernel_dcache_page() is not a no-op.)
> > 
> > I'm not sure why sg_miter doesn't call flush_dcache_page() but
> > flush_kernel_dcache_page() (I cc'ed Fujita as he seems to have added
> > this code).
> 
> It is intended to handle D aliasing due to kmap. As cachetlb.txt says
> that it is assumed here that the user has no incoherent cached copies
> (it was already addressed elsewhere). So flush_dcache_page() does too
> much there.

OK. So in this case a PIO driver using sg_miter should still call
flush_dcache_page() as usual (or not at all as we change the meaning
PG_arch_1 for the architectures where this matters).

Thanks.

-- 
Catalin
