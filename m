From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC][PATCH 03/24] arm: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 11:24:36 +0100
Message-ID: <20150710102436.GQ7557@n2100.arm.linux.org.uk>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.296642297@infradead.org>
 <20150709180223.GF3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60788 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbbGJKY4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 06:24:56 -0400
Content-Disposition: inline
In-Reply-To: <20150709180223.GF3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org

On Thu, Jul 09, 2015 at 08:02:23PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 09, 2015 at 07:28:58PM +0200, Peter Zijlstra wrote:
> > @@ -320,6 +323,9 @@ static inline long long atomic64_##op##_
> >  
> >  ATOMIC64_OPS(add, adds, adc)
> >  ATOMIC64_OPS(sub, subs, sbc)
> > +ATOMIC64_OP(and, and, and)
> > +ATOMIC64_OP(or, or, or)
> 
> Hmm, reading through them, this should be:
> 
> ATOMIC64_OP(or, orr, orr)
> 
> I suppose, not sure why the compiler didn't complain, maybe because
> there aren't any users..

Yep, as it creates a static inline function, the code will only get
produced if something uses it, and which point the assembler would have
picked up on the error.

In any case, with that modification, the patch then _looks_ correct to
me for both atomic and atomic64 additions.  Not tested myself.

I guess as you're only looking for comments at the moment, there's
little point in acking it just yet.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
