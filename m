Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:39967 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaDWEXs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 00:23:48 -0400
Received: by mail-ve0-f176.google.com with SMTP id db11so475046veb.21
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2014 21:23:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
References: <1398032742.19682.11.camel@pasglop>
	<CA+55aFz1sK+PF96LYYZY7OB7PBpxZu-uNLWLvPiRz-tJsBqX3w@mail.gmail.com>
	<1398054064.19682.32.camel@pasglop>
	<1398057630.19682.38.camel@pasglop>
	<CA+55aFwWHBtihC3w9E4+j4pz+6w7iTnYhTf4N3ie15BM9thxLQ@mail.gmail.com>
	<53558507.9050703@zytor.com>
	<CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
	<53559F48.8040808@intel.com>
	<CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com>
	<CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
	<20140422075459.GD11182@twins.programming.kicks-ass.net>
	<CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
	<alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
Date: Tue, 22 Apr 2014 21:23:47 -0700
Message-ID: <CA+55aFw7JjEBUJRHXuwc7bGBD5c=J41mt46ovwHKAoMfPowWOw@mail.gmail.com>
Subject: Re: Dirty/Access bits vs. page content
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140423042347.wNlgbiEFi4LGK2jOk3XeKKJd9QlH35bSIt7eXaA6t5Y@z>

On Tue, Apr 22, 2014 at 8:08 PM, Hugh Dickins <hughd@google.com> wrote:
>
> At first I thought you were right, and set_page_dirty_lock() needed;
> but now I think not.  We only(?) need set_page_dirty_lock() when
> there's a danger that the struct address_space itself might be
> evicted beneath us.
>
> But here (even without relying on Al's delayed_fput) the fput()
> is done by remove_vma() called _after_ the tlb_finish_mmu().
> So I see no danger of struct address_space being freed:

Yeah, that's what the comments say. I'm a bit worried about
"page->mapping" races, though. So I don't think the address_space gets
freed, but I worry about truncate NULL'ing out page->mapping under us.
There, the page being either mapped in a page table (with the page
table lock held), or holding the page lock should protect us against
concurrent truncate doing that.

So I'm still a bit worried.

> page->mapping might be truncated to NULL at any moment without page
> lock and without mapping->tree_lock (and without page table lock
> helping to serialize page_mapped against unmap_mapping_range); but
> __set_page_dirty_nobuffers() (admittedly not the only set_page_dirty)
> is careful about that, and it's just not the problem Dave is seeing.

Yeah, I guess you're right. And no, page->mapping becoming NULL
doesn't actually explain Dave's issue anyway.

> However... Virginia and I get rather giddy when it comes to the
> clear_page_dirty_for_io() page_mkclean() dance: we trust you and
> Peter and Jan on that, and page lock there has some part to play.
>
> My suspicion, not backed up at all, is that by leaving the
> set_page_dirty() until after the page has been unmapped (and page
> table lock dropped), that dance has been disturbed in such a way
> that ext4 can be tricked into freeing page buffers before it will
> need them again for a final dirty writeout.

So I don't think it's new, but I agree that it opens a *much* wider
window where the dirty bit is not visible in either the page tables or
(yet) in the page dirty bit.

The same does happen in try_to_unmap_one() and in
clear_page_dirty_for_io(), but in both of those cases we hold the page
lock for the entire duration of the sequence, so this whole "page is
not visibly dirty and page lock is not held" is new. And yes, I could
imagine that that makes some code go "Ahh, we don't need buffers for
that page any more then".

In short, I think your suspicion is on the right track. I will have to
think about this.

But I'm starting to consider this whole thing to be a 3.16 issue by
now. It wasn't as simple as it looked, and while our old location of
set_page_dirty() is clearly wrong, and DaveH even got a test-case for
it (which I initially doubted would even be possible), I still
seriously doubt that anybody sane who cares about data consistency
will do concurrent unmaps (or MADV_DONTNEED) while another writer is
actively using that mapping.

Pretty much by definition, if you care about data consistency, you'd
never do insane things like that. You'd make damn sure that every
writer is all done before you unmap the area they are writing to.

So this is a "oops, we're clearly doing something wrong by marking the
page dirty too early early, but anybody who really hits it has it
coming to them" kind of situation. We want to fix it, but it doesn't
seem to be a high priority.

             Linus
