Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266877AbUHITgS@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:4834 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266883AbUHISzo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 14:55:44 -0400
Date: Mon, 9 Aug 2004 11:49:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: copy_page_range()
Message-ID: <20040809184913.GQ11200@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com> <16663.15729.828367.307053@napali.hpl.hp.com> <20040809090458.GO11200@holomorphy.com> <Pine.LNX.4.58.0408091006280.1832@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408091006280.1832@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 9 Aug 2004, William Lee Irwin III wrote:
>> These results are actually consistent with large-memory ia32.
>> Instruction-level profiles showed that the largest overhead in
>> copy_page_range() on such ia32 boxen appeared to be mm->rss++.

On Mon, Aug 09, 2004 at 10:08:05AM -0700, Linus Torvalds wrote:
> That sounds unlikely. Most ia32 instruction profiles will give high 
> profile counts to instructions _following_ the one that was expensive, and 
> in this case I'd strongyl suspect that the real expense on x86 is the 
> "get_page(page)" thing. 
> Which is an atomic increment, and thus very expensive.

But it was real. The theory is that mm->rss++; was an off-node memory
access, where struct page (due to boot-time remapping voodoo) and pmd's
(thanks to my patchwerk) were node-local, and the 40:1 off-node memory
access latency for a remote cache miss (i.e. ZONE_NORMAL) killed it all.

Thankfully Oracle has me parked on 64-bit machines with cache
directories and vaguely speedy interconnects for this kind of work.


-- wli
