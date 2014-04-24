From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Dirty/Access bits vs. page content
Date: Thu, 24 Apr 2014 12:45:36 -0700
Message-ID: <CA+55aFwVgCshsVHNqr2EA1aFY18A2L17gNj0wtgHB39qLErTrg@mail.gmail.com>
References: <53558507.9050703@zytor.com>
	<CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
	<53559F48.8040808@intel.com>
	<CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com>
	<CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
	<20140422075459.GD11182@twins.programming.kicks-ass.net>
	<CA+55aFzM+NpE-EzJdDeYX=cqWRzkGv9o-vybDR=oFtDLMRK-mA@mail.gmail.com>
	<alpine.LSU.2.11.1404221847120.1759@eggly.anvils>
	<20140423184145.GH17824@quack.suse.cz>
	<CA+55aFwm9BT4ecXF7dD+OM0-+1Wz5vd4ts44hOkS8JdQ74SLZQ@mail.gmail.com>
	<20140424065133.GX26782@laptop.programming.kicks-ass.net>
	<alpine.LSU.2.11.1404241110160.2443@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:38904 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbaDXTph (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2014 15:45:37 -0400
Received: by mail-vc0-f175.google.com with SMTP id lh14so3555000vcb.6
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2014 12:45:37 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.11.1404241110160.2443@eggly.anvils>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

On Thu, Apr 24, 2014 at 11:40 AM, Hugh Dickins <hughd@google.com> wrote:
> safely with page_mkclean(), as it stands at present anyway.
>
> I think that (in the exceptional case when a shared file pte_dirty has
> been encountered, and this mm is active on other cpus) zap_pte_range()
> needs to flush TLB on other cpus of this mm, just before its
> pte_unmap_unlock(): then it respects the usual page_mkclean() protocol.
>
> Or has that already been rejected earlier in the thread,
> as too costly for some common case?

Hmm. The problem is that right now we actually try very hard to batch
as much as possible in order to avoid extra TLB flushes (we limit it
to around 10k pages per batch, but that's still a *lot* of pages). The
TLB flush IPI calls are noticeable under some loads.

And it's certainly much too much to free 10k pages under a spinlock.
The latencies would be horrendous.

We could add some special logic that only triggers for the dirty pages
case, but it would still have to handle the case of "we batched up
9000 clean pages, and then we hit a dirty page", so it would get
rather costly quickly.

Or we could have a separate array for dirty pages, and limit those to
a much smaller number, and do just the dirty pages under the lock, and
then the rest after releasing the lock. Again, a fair amount of new
complexity.

I would almost prefer to have some special (per-mapping?) lock or
something, and make page_mkclean() be serialize with the unmapping
case.

              Linus
