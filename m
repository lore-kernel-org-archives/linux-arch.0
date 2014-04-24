From: Hugh Dickins <hughd@google.com>
Subject: Re: Dirty/Access bits vs. page content
Date: Thu, 24 Apr 2014 11:40:17 -0700 (PDT)
Message-ID: <alpine.LSU.2.11.1404241110160.2443@eggly.anvils>
References: <53558507.9050703@zytor.com> <CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com> <53559F48.8040808@intel.com> <CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com> <CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
 <20140422075459.GD11182@twins.programming.kicks-ass.net> <CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com> <alpine.LSU.2.11.1404221847120.1759@eggly.anvils> <20140423184145.GH17824@quack.suse.cz> <CA+55aFwm9BT4ecXF7dD+OM0-+1Wz5vd4ts44hOkS8JdQ74SLZQ@mail.gmail.com>
 <20140424065133.GX26782@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41446 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758735AbaDXSld (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2014 14:41:33 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2209518pdj.36
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2014 11:41:32 -0700 (PDT)
In-Reply-To: <20140424065133.GX26782@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

On Thu, 24 Apr 2014, Peter Zijlstra wrote:
> On Wed, Apr 23, 2014 at 12:33:15PM -0700, Linus Torvalds wrote:
> > On Wed, Apr 23, 2014 at 11:41 AM, Jan Kara <jack@suse.cz> wrote:
> > >
> > > Now I'm not sure how to fix Linus' patches. For all I care we could just
> > > rip out pte dirty bit handling for file mappings. However last time I
> > > suggested this you corrected me that tmpfs & ramfs need this. I assume this
> > > is still the case - however, given we unconditionally mark the page dirty
> > > for write faults, where exactly do we need this?
> > 
> > Honza, you're missing the important part: it does not matter one whit
> > that we unconditionally mark the page dirty, when we do it *early*,
> > and it can be then be marked clean before it's actually clean!
> > 
> > The problem is that page cleaning can clean the page when there are
> > still writers dirtying the page. Page table tear-down removes the
> > entry from the page tables, but it's still there in the TLB on other
> > CPU's. 
> 
> > So other CPU's are possibly writing to the page, when
> > clear_page_dirty_for_io() has marked it clean (because it didn't see
> > the page table entries that got torn down, and it hasn't seen the
> > dirty bit in the page yet).
> 
> So page_mkclean() does an rmap walk to mark the page RO, it does mm wide
> TLB invalidations while doing so.
> 
> zap_pte_range() only removes the rmap entry after it does the
> ptep_get_and_clear_full(), which doesn't do any TLB invalidates.
> 
> So as Linus says the page_mkclean() can actually miss a page, because
> it's already removed from rmap() but due to zap_pte_range() can still
> have active TLB entries.
> 
> So in order to fix this we'd have to delay the page_remove_rmap() as
> well, but that's tricky because rmap walkers cannot deal with
> in-progress teardown. Will need to think on this.

I've grown sceptical that Linus's approach can be made to work
safely with page_mkclean(), as it stands at present anyway.

I think that (in the exceptional case when a shared file pte_dirty has
been encountered, and this mm is active on other cpus) zap_pte_range()
needs to flush TLB on other cpus of this mm, just before its
pte_unmap_unlock(): then it respects the usual page_mkclean() protocol.

Or has that already been rejected earlier in the thread,
as too costly for some common case?

Hugh
