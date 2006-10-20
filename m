Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:47537 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S2992505AbWJTRhr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Oct 2006 13:37:47 -0400
Message-ID: <45390964.3080108@yahoo.com.au>
Date: Sat, 21 Oct 2006 03:37:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au> <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <4538F1EC.1020806@yahoo.com.au> <Pine.LNX.4.64.0610200935290.3962@g5.osdl.org> <4538FDBC.6070301@yahoo.com.au> <Pine.LNX.4.64.0610201004520.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201004520.3962@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:
> 
> On Sat, 21 Oct 2006, Nick Piggin wrote:
> 
>>>So maybe the COW D$ aliasing patch-series is just the right thing to do. Not
>>>worry about D$ at _all_ when doing the actual fork, and only worry about it
>>>on an actual COW event. Hmm?
>>
>>Well if we have the calls in there, we should at least make them work
>>right for the architectures there now. At the moment the flush_cache_mm
>>before the copy_page_range wouldn't seem to do anything if you can still
>>have threads dirty the cache again through existing TLB entries.
>>
>>I don't think that flushing on COW is exactly right though, because dirty
>>data can remain invisible if you're only doing reads (no write, no flush).
> 
> 
> You're right. A virtually indexed cache needs the flush _before_ we return 
> from the fork into a new process (since otherwise the dirty data won't be 
> visible in the new virtual address space).
> 
> So you've convinced me. Flushing at COW time _cannot_ be right, because it 
> by definition means that there has been a time when the new process didn't 
> see the dirty data in the case of a virtual index. And in the case of a 
> physical index it cannot matter.
> 
> So I think the right thing to do is to forget about the COW D$ series 
> (which probably _hides_ most of the problems in practice, so it "works" 
> that way) and instead go with Ralf's last patch that just moves the 
> flush_cache_mm() to after the TLB flush.

So long as we don't move around the mmap semaphores, I'm OK with that
patch...

> We do need to have all the architecture people (especially S390, which has 
> been very strange in this regard in the past) check that it's ok. The 
> _mappings_ are still valid, so S390 should be able to do the write-back, 
> but there may be architectures that would want to do the flush _both_ 
> before and after (for performance reasons - if writing out dirty data 
> requires a TLB lookup, doing most fo the writeback before is probably a 
> better thing, and then we can do a _second_ writeback after the flush to 
> close the race with some other thread dirtying the pages before the TLB 
> was marked read-only).

Yes, that's my theory too. Probably the thing to aim for is replacing
that API with a new single call to flush caches and tlbs, and the
arch can do what best suits.

But for now, to get it actually *working*, moving the flush_cache_mm
seems like the first step.

> I added linux-arch and Martin Schwidefsky (s390) to the Cc:.
> 
> Guys, in case you missed the earlier discussion: there's a suggested patch 
> by Ralf Baechle on linux-kernel (but it does just the "flush after" 
> version, not the "perhaps we need it both before and after" thing I 
> theorise about above). Message-ID: 20061020160538.GB18649@linux-mips.org.

As I mentioned there, we probably want to to check that other places
which flush caches before invalidating TLBs (eg. most of the kernel) is
OK in the presence of concurrent writes to valid TLBs from other threads.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
