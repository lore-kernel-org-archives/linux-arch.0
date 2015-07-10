From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask
 definitions
Date: Fri, 10 Jul 2015 14:42:56 +0100
Message-ID: <20150710134256.GS7557@n2100.arm.linux.org.uk>
References: <20150709172855.564686637@infradead.org>
 <20150709175310.229218215@infradead.org>
 <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
 <20150710103945.GH19282@twins.programming.kicks-ass.net>
 <559FC9CC.6000400@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:32928 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532AbbGJNnV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 09:43:21 -0400
Content-Disposition: inline
In-Reply-To: <559FC9CC.6000400@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>, =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>

On Fri, Jul 10, 2015 at 09:34:04AM -0400, Chris Metcalf wrote:
> On 7/10/2015 6:39 AM, Peter Zijlstra wrote:
> >On Fri, Jul 10, 2015 at 11:10:33AM +0200, Geert Uytterhoeven wrote:
> >>Hi Peter,
> >>
> >>On Thu, Jul 9, 2015 at 7:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>--- a/include/linux/atomic.h
> >>>+++ b/include/linux/atomic.h
> >>>@@ -28,6 +28,23 @@ static inline int atomic_add_unless(atom
> >>>  #define atomic_inc_not_zero(v)         atomic_add_unless((v), 1, 0)
> >>>  #endif
> >>>
> >>>+#ifndef atomic_nand
> >>>+static inline void atomic_nand(int i, atomic_t *v)
> >>>+{
> >>>+       atomic_and(~i, v);
> >>That sounds like a misnomer...
> >>
> >>Your NAND is "A & ~B", while my[*] NAND is "~(A & B)"?
> >>
> >>[*] https://en.wikipedia.org/wiki/NAND_logic
> >Right you are.
> >
> >>What about atomic_clear()? (Is atomic_bic() too ARM-centric?)
> >atomic_and_not() ?
> 
> I've seen this as ANDN (as opposed to NAND).  That's the name I used in
> the tilepro atomics as the thing that implements the bitmask clear operation.
> SPARC also has an "andn" instruction with this semantics.

The obvious question though is whether we have an established name for this
operation elsewhere in the kernel, and whether we should have consistency.
In include/linux, we already have (grepping for 'and_*not'):

include/linux/nodemask.h:#define nodes_andnot(dst, src1, src2) \
include/linux/bitmap.h:extern int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
include/linux/cpumask.h:static inline int cpumask_andnot(struct cpumask *dstp,

We also have:

include/linux/signal.h:#define _sig_andn(x,y)       ((x) & ~(y))

which seems to be the only instance of "andn" in include/.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
