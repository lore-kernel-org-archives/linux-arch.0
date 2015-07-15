From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 04/24] arm64: Provide atomic_{or,xor,and}
Date: Wed, 15 Jul 2015 18:46:54 +0200
Message-ID: <20150715164654.GS19282@twins.programming.kicks-ass.net>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.361407648@infradead.org>
 <20150715160109.GB17107@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41397 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbGOQrc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2015 12:47:32 -0400
Content-Disposition: inline
In-Reply-To: <20150715160109.GB17107@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>, min

On Wed, Jul 15, 2015 at 05:01:09PM +0100, Will Deacon wrote:
> On Thu, Jul 09, 2015 at 06:28:59PM +0100, Peter Zijlstra wrote:
> > Implement atomic logic ops -- atomic_{or,xor,and}.
> > 
> > These will replace the atomic_{set,clear}_mask functions that are
> > available on some archs.
> > 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/arm64/include/asm/atomic.h |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > --- a/arch/arm64/include/asm/atomic.h
> > +++ b/arch/arm64/include/asm/atomic.h
> > @@ -84,6 +84,9 @@ static inline int atomic_##op##_return(i
> >  
> >  ATOMIC_OPS(add, add)
> >  ATOMIC_OPS(sub, sub)
> > +ATOMIC_OP(and, and)
> > +ATOMIC_OP(or, orr)
> 
> FYI, but without selecting CONFIG_ARCH_HAS_ATOMIC_OR this change leads to
> build errors:

Yah, already ran into that; I've a new set cooking which fixes all these
issues. I get the interesting build fails after a day or so (from the
build-bot).

I just pushed a fresh set into it and was hoping to be able to post
tomorrow.
