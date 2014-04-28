Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51981 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbaD1KOu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Apr 2014 06:14:50 -0400
Date: Mon, 28 Apr 2014 12:14:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Dirty/Access bits vs. page content
Message-ID: <20140428101446.GY13658@twins.programming.kicks-ass.net>
References: <5359CD7C.5020604@zytor.com>
 <CA+55aFzktDDr5zNh-7gDhXW6-7_BP_MvKHEoLi9=td6XvwzaUA@mail.gmail.com>
 <alpine.LSU.2.11.1404250414590.5198@eggly.anvils>
 <20140425135101.GE11096@twins.programming.kicks-ass.net>
 <alpine.LSU.2.11.1404251215280.5909@eggly.anvils>
 <20140426180711.GM26782@laptop.programming.kicks-ass.net>
 <20140427072034.GC1429@laptop.programming.kicks-ass.net>
 <alpine.LSU.2.11.1404270459160.2688@eggly.anvils>
 <alpine.LSU.2.11.1404271220100.3724@eggly.anvils>
 <20140428092540.GO11096@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140428092540.GO11096@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Kara <jack@suse.cz>, Dave Hansen <dave.hansen@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>
Message-ID: <20140428101446.VM-u46THXaASTjxfGmCTBlSoyhmWhTlIuU8pvTrR-yg@z>

On Mon, Apr 28, 2014 at 11:25:40AM +0200, Peter Zijlstra wrote:
> > So in the interval when zap_pte_range() has brought page_mapcount()
> > down to 0, but not yet flushed TLB on all mapping cpus, it looked as
> > if we still had a problem - neither try_to_unmap() nor page_mkclean()
> > would take the lock either of us rely upon for serialization.
> > 
> > But pageout()'s preliminary is_page_cache_freeable() check makes
> > it safe in the end: although page_mapcount() has gone down to 0,
> > page_count() remains raised until the free_pages_and_swap_cache()
> > after the TLB flush.
> > 
> > So I now believe we're safe after all with either patch, and happy
> > for Linus to go ahead with his.
> 
> OK, so I'm just not seeing that atm. Will have another peek later,
> hopefully when more fully awake.

Sigh.. I suppose I should do more mm/ stuff, I'm getting real rusty.

So it looks like we also have a page-ref per map, every time we install
a page (->fault) we grab an extra ref.

So yes, we'll have >2 refs until the final free_page_and_swap_cache()


