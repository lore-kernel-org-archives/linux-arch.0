From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask
 definitions
Date: Fri, 10 Jul 2015 12:39:45 +0200
Message-ID: <20150710103945.GH19282@twins.programming.kicks-ass.net>
References: <20150709172855.564686637@infradead.org>
 <20150709175310.229218215@infradead.org>
 <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48372 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbGJKkJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 06:40:09 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@ezchip.com>, Ingo Molnar <mingo@kernel.org>

On Fri, Jul 10, 2015 at 11:10:33AM +0200, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Jul 9, 2015 at 7:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > --- a/include/linux/atomic.h
> > +++ b/include/linux/atomic.h
> > @@ -28,6 +28,23 @@ static inline int atomic_add_unless(atom
> >  #define atomic_inc_not_zero(v)         atomic_add_unless((v), 1, 0)
> >  #endif
> >
> > +#ifndef atomic_nand
> > +static inline void atomic_nand(int i, atomic_t *v)
> > +{
> > +       atomic_and(~i, v);
> 
> That sounds like a misnomer...
> 
> Your NAND is "A & ~B", while my[*] NAND is "~(A & B)"?
> 
> [*] https://en.wikipedia.org/wiki/NAND_logic

Right you are.

> What about atomic_clear()? (Is atomic_bic() too ARM-centric?)

atomic_and_not() ?
