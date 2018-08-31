Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55438 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbeHaOAU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Aug 2018 10:00:20 -0400
Date: Fri, 31 Aug 2018 10:53:51 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180831095351.GD13166@arm.com>
References: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
 <20180830204515.GC24124@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180831095351.uVWvvAk7MIWbmiouIEtQB5QL91skazSGeCSgJbWqtwA@z>

On Fri, Aug 31, 2018 at 12:30:50AM +0000, Vineet Gupta wrote:
> On 08/30/2018 01:45 PM, Peter Zijlstra wrote:
> >>
> >> Indeed this is the mother of all issues, I tried and system is clearly hosed with
> >> and works after.
> >> What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;-)
> >> Back then we had a retry branch with backoff stuff which I'd reverted for new
> >> cores and the merge conflict somehow missed it.
> >>
> >> @PeterZ I'll create a patch with you as author ? do I need any formal sign offs,
> >> acks etc ?
> > Well, Will spotted it, give authorship to him, you have my ack per the
> > above.
> 
> Oops, sorry for the mixup. I have him as author now and pushed to ARC for-curr
> (will trickle into linux-next eventually).

Okey doke: you can have my Signed-off-by for all the diffs I sent. Just
stick something like [vineet: wrote commit message] in there so I don't
read it in the future and confuse myself.

Will
