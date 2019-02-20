Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTPC7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Feb 2019 10:02:59 -0500
Date: Wed, 20 Feb 2019 07:02:53 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20190220150253.GH12668@bombadil.infradead.org>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.207580251@infradead.org>
 <20190219124738.GD8501@fuggles.cambridge.arm.com>
 <20190219134147.GZ32494@hirez.programming.kicks-ass.net>
 <20190220144705.GH7523@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220144705.GH7523@fuggles.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, tony.luck@intel.com
Message-ID: <20190220150253.fYTh6rojbVc8Z743_bk-ztrJ75-LzmajSU6ENXF4WXc@z>

On Wed, Feb 20, 2019 at 02:47:05PM +0000, Will Deacon wrote:
> On Tue, Feb 19, 2019 at 02:41:47PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 19, 2019 at 12:47:38PM +0000, Will Deacon wrote:
> > > Fine for now, but I agree that we should drop the hook altogether. AFAICT,
> > > this only exists to help an ia64 optimisation which looks suspicious to
> > > me since it uses:
> > > 
> > >     mm == current->active_mm && atomic_read(&mm->mm_users) == 1
> > > 
> > > to identify a "single-threaded fork()" and therefore perform only local TLB
> > > invalidation. Even if this was the right thing to do, it's not clear to me
> > > that tlb_migrate_finish() is called on the right CPU anyway.
> > > 
> > > So I'd be keen to remove this hook before it spreads, but in the meantime:
> > 
> > Agreed :-)
> > 
> > The obvious slash and kill patch ... untested
> 
> I'm also unable to test this, unfortunately. Can we get it into next after
> the merge window and see if anybody reports issues?

While I do have a pair of Itanium systems in my basement, neither are
sn2 machines, which was the only sub-architecture that implemented
tlb_migrate_finish().  I see NASA decomissioned Columbia in 2013, and
I imagine most sn2 machines have been similarly scrapped.
